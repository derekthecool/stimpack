return {
    {
        'sindrets/diffview.nvim',
        keys = {
            {
                '<leader>gD',
                function()
                    -- Set the initial value for the global or keep the existing state
                    if DiffViewToggleState == nil then
                        DiffViewToggleState = true
                    end

                    if DiffViewToggleState then
                        vim.cmd('DiffviewOpen')
                    else
                        vim.cmd('DiffviewClose')
                    end

                    -- Toggle the state
                    DiffViewToggleState = not DiffViewToggleState
                end,
                desc = 'DiffViewToggle',
            },
        },
        cmd = {
            'DiffviewOpen',
            'DiffviewFileHistory',
        },
    },
    {
        -- TODO: (Derek Lomax) Fri Aug 15 11:01:58 2025, This plugin seems to be not Windows friendly
        -- Works in WSL though. Consider contributing to project.
        'ThePrimeagen/git-worktree.nvim',
        version = '^2',
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
        config = function()
            vim.keymap.set('n', '<leader>gw', function()
                local git_result = Execute('git worktree list')
                local worktrees = {}

                -- Load everything surrounded by [] into the list of worktrees
                for _, git_output in pairs(git_result.stdout) do
                    git_output:gsub('%[(%S+)%]', function(tree)
                        table.insert(worktrees, tree)
                    end)
                end

                vim.ui.select(worktrees, {
                    prompt = 'Select git worktree:',
                    format_item = function(item)
                        return item
                    end,
                }, function(choice)
                    if choice then
                        require('git-worktree').switch_worktree(choice)
                    end
                end)
            end, { desc = 'Select git worktree' })

            local function get_new_worktree_name()
                return vim.fn.input('Enter new git worktree name')
            end

            vim.keymap.set('n', '<leader>gm', function()
                local new_worktree = get_new_worktree_name()
                if not new_worktree then
                    return
                end

                require('git-worktree').create_worktree(new_worktree, new_worktree, 'origin')
            end, { silent = true, desc = 'Create new git worktree' })
        end,
    },
    {
        -- Azure DevOps PR inline comment poster. Self-contained; no remote plugin.
        dir = vim.fn.stdpath('config'),
        name = 'ado-pr-comment',
        dependencies = { 'nvim-neotest/nvim-nio' },
        keys = {
            { '<leader>gq', mode = { 'n', 'v' }, desc = 'ADO PR: post inline comment' },
        },
        config = function()
            local nio = require('nio')

            local PROJECT = 'FreeusDevice'
            local REPO_ID = '46006de2-5aef-4b13-a2f0-7d638c6b1983'
            local _pr_cache = {} -- branch -> { pr_id, repo_id }

            -- Run a shell string async; return trimmed stdout and exit code.
            -- Uses jobstart + nio.control.future to bridge into the coroutine.
            -- nio.process is avoided: its socket-type pipe check fails on WSL2.
            local function sh(cmd)
                local future = nio.control.future()
                local chunks = {}
                vim.fn.jobstart({ 'sh', '-c', cmd }, {
                    stdout_buffered = true,
                    on_stdout = function(_, data)
                        vim.list_extend(chunks, data)
                    end,
                    on_exit = function(_, code)
                        future.set({ table.concat(chunks, '\n'), code })
                    end,
                })
                local result = future.wait()
                return vim.trim(result[1]), result[2]
            end

            -- Look up PR info for the given branch (cached after first call).
            -- Must be called inside an nio.run() coroutine.
            local function resolve_pr(branch)
                if _pr_cache[branch] then
                    return _pr_cache[branch]
                end
                -- Use a targeted query so the response is small — the full PR object
                -- is hundreds of lines and risks being truncated by proc.stdout.read().
                local json = sh(
                    ('az repos pr list --source-branch %q --query \'[0].{id:pullRequestId,repo:repository.id}\' -o json 2>/dev/null'):format(
                        branch
                    )
                )
                local ok, pr = pcall(vim.fn.json_decode, json)
                if not ok or type(pr) ~= 'table' or pr == vim.NIL or not pr.id then
                    return nil
                end
                local info = {
                    pr_id = pr.id,
                    repo_id = REPO_ID or pr.repo,
                }
                _pr_cache[branch] = info
                return info
            end

            -- Open a floating scratch buffer; calls on_submit(text) on <C-s>.
            local function float_input(title, on_submit)
                local buf = vim.api.nvim_create_buf(false, true)
                vim.bo[buf].buftype = 'nofile'
                vim.bo[buf].bufhidden = 'wipe'
                vim.bo[buf].filetype = 'markdown'

                local W = math.min(80, vim.o.columns - 6)
                local H = 10
                local win = vim.api.nvim_open_win(buf, true, {
                    relative = 'editor',
                    width = W,
                    height = H,
                    row = math.floor((vim.o.lines - H) / 2),
                    col = math.floor((vim.o.columns - W) / 2),
                    style = 'minimal',
                    border = 'rounded',
                    title = title,
                    title_pos = 'center',
                    footer = ' <C-s> submit  q/<Esc> cancel ',
                    footer_pos = 'center',
                })
                vim.wo[win].wrap = true
                vim.wo[win].linebreak = true

                local function submit()
                    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
                    vim.api.nvim_win_close(win, true)
                    local text = vim.trim(table.concat(lines, '\n'))
                    if text ~= '' then
                        on_submit(text)
                    end
                end

                local function cancel()
                    if vim.api.nvim_win_is_valid(win) then
                        vim.api.nvim_win_close(win, true)
                    end
                end

                local o = { buffer = buf, nowait = true, silent = true }
                vim.keymap.set({ 'n', 'i' }, '<C-s>', submit, o)
                vim.keymap.set('n', 'q', cancel, o)
                vim.keymap.set('n', '<Esc>', cancel, o)
                vim.cmd('startinsert')
            end

            local function post_comment(file, start_line, end_line, text)
                nio.run(function()
                    local branch = sh('git rev-parse --abbrev-ref HEAD 2>/dev/null')
                    local root = sh('git rev-parse --show-toplevel 2>/dev/null')

                    local info = resolve_pr(branch)
                    if not info then
                        vim.notify('No active PR for branch: ' .. branch, vim.log.levels.ERROR)
                        return
                    end

                    -- ADO expects a repo-root-relative path with a leading slash.
                    local rel = file:sub(#root + 1)
                    if rel:sub(1, 1) ~= '/' then
                        rel = '/' .. rel
                    end

                    local body = vim.fn.json_encode({
                        comments = {
                            { parentCommentId = 0, content = text, commentType = 1 },
                        },
                        threadContext = {
                            filePath = rel,
                            rightFileStart = { line = start_line, offset = 1 },
                            rightFileEnd = { line = end_line, offset = 1 },
                        },
                        status = 1,
                    })

                    local tmp = vim.fn.tempname() .. '.json'
                    local f = assert(io.open(tmp, 'w'))
                    f:write(body)
                    f:close()

                    local result_json = sh(table.concat({
                        'az devops invoke',
                        '--area git --resource pullRequestThreads',
                        '--route-parameters',
                        'project=' .. PROJECT,
                        'repositoryId=' .. info.repo_id,
                        'pullRequestId=' .. info.pr_id,
                        '--http-method POST',
                        '--in-file ' .. vim.fn.shellescape(tmp),
                        '--api-version 7.0 -o json 2>&1',
                    }, ' '))
                    os.remove(tmp)

                    local ok, res = pcall(vim.fn.json_decode, result_json)
                    if ok and type(res) == 'table' and res.id then
                        vim.notify(('PR comment posted (thread %d)'):format(res.id), vim.log.levels.INFO)
                    else
                        vim.notify('PR comment failed:\n' .. result_json, vim.log.levels.ERROR)
                    end
                end)
            end

            local function comment_at_cursor(start_line, end_line)
                local file = vim.api.nvim_buf_get_name(0)
                local fname = vim.fn.fnamemodify(file, ':t')
                local title = start_line == end_line and (' PR comment  %s:%d '):format(fname, start_line)
                    or (' PR comment  %s:%d-%d '):format(fname, start_line, end_line)
                float_input(title, function(text)
                    post_comment(file, start_line, end_line, text)
                end)
            end

            vim.keymap.set('n', '<leader>gq', function()
                comment_at_cursor(vim.fn.line('.'), vim.fn.line('.'))
            end, { desc = 'ADO PR: comment on line' })

            vim.keymap.set('v', '<leader>gq', function()
                local s = vim.fn.line('v') -- visual anchor
                local e = vim.fn.line('.') -- cursor
                if s > e then
                    s, e = e, s
                end
                -- exit visual so the float doesn't inherit visual state
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'x', false)
                comment_at_cursor(s, e)
            end, { desc = 'ADO PR: comment on selection' })
        end,
    },
}
