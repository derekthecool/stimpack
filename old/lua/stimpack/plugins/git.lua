-- My favorite method to use git commands is actually just plain terminal
-- This was demonstrated in a remarkably simple way by Paul Fioravanti, thanks Paul!
-- You can't beat the speed of steno'd git command-line

local fugitive_git_level = 1
local neogit_git_level = 3

return {

    --[[
    This plugin is quite powerful. Here is my list of favorite commands


    -- The main command: easy mapping for toggle is my command <leader>gd
    :DiffviewOpen
    :DiffviewOpen HEAD~2
    :DiffviewOpen HEAD~4..HEAD~2
    :DiffviewOpen d4a7b0d
    :DiffviewOpen d4a7b0d^!
    :DiffviewOpen d4a7b0d..519b30e
    :DiffviewOpen origin/main...HEAD
    :DiffviewOpen HEAD~2 -- lua/diffview plugin
    :DiffviewOpen d4a7b0d -uno

    :DiffviewFileHistory
    :DiffviewFileHistory %
    :DiffviewFileHistory path/to/some/file.txt
    :DiffviewFileHistory path/to/some/directory
    :DiffviewFileHistory multiple/paths foo/bar baz/qux
    :DiffviewFileHistory --base=HEAD~4
    :DiffviewFileHistory --base=LOCAL
    :DiffviewFileHistory --range=origin..HEAD
    :DiffviewFileHistory --range=feat/some-branch
    :'<,'>DiffviewFileHistory

    See :h diffview-maps for other mappings available

    ]]
    {
        'sindrets/diffview.nvim',
        keys = {
            {
                '<leader>gd',
                function()
                    -- Set the initial value for the global or keep the existing state
                    if DiffViewToggleState == nil then
                        DiffViewToggleState = true
                    end

                    if DiffViewToggleState then
                        require('diffview').open()
                    else
                        require('diffview').close()
                    end

                    -- Toggle the state
                    DiffViewToggleState = not DiffViewToggleState
                end,
                'DiffViewToggle',
            },
        },
        cmd = {
            'DiffviewOpen',
            'DiffviewFileHistory',
        },
    },

    {
        'lewis6991/gitsigns.nvim',
        event = 'CursorMoved',
        keys = { '<leader>gj', '<leader>gk' },
        config = function()
            require('which-key').add({
                { '<leader>g',  group = 'git' },
                {
                    '<leader>gG',
                    '<cmd>Gitsigns toggle_current_line_blame<cr>',
                    desc = 'Gitsigns toggle display of deleted lines',
                },
                {
                    '<leader>gB',
                    '<cmd>Telescope find_files<CR>',
                    desc = 'Gitsigns toggle display of deleted lines',
                },
                {
                    '<leader>gj',
                    function()
                        require('gitsigns').next_hunk()
                    end,
                    desc = 'Next Hunk',
                },
                {
                    '<leader>gk',
                    function()
                        require('gitsigns').prev_hunk()
                    end,
                    desc = 'Prev Hunk',
                },
                {
                    '<leader>gl',
                    function()
                        require('gitsigns').blame_line()
                    end,
                    desc = 'Blame',
                },
                {
                    '<leader>gq',
                    function()
                        require('gitsigns').preview_hunk()
                    end,
                    desc = 'Preview Hunk',
                },
                {
                    '<leader>gr',
                    function()
                        require('gitsigns').reset_hunk()
                    end,
                    desc = 'Reset Hunk',
                },
                {
                    '<leader>gR',
                    function()
                        require('gitsigns').reset_buffer()
                    end,
                    desc = 'Reset Buffer',
                },
                {
                    '<leader>gS',
                    function()
                        require('gitsigns').stage_buffer()
                    end,
                    desc = 'Stage Buffer',
                },
                {
                    '<leader>gs',
                    function()
                        require('gitsigns').stage_hunk()
                    end,
                    desc = 'Stage Hunk',
                },
                {
                    '<leader>gu',
                    function()
                        require('gitsigns').undo_stage_hunk()
                    end,
                    desc = 'Undo Stage Hunk',
                },
                { '<leader>gt', '<cmd>Gitsigns diffthis HEAD<cr>', desc = 'Diff' },
                {
                    '<leader>go',
                    '<cmd>Telescope git_status<cr>',
                    desc = 'Telescope: Open changed file',
                },
                {
                    '<leader>gb',
                    '<cmd>Telescope git_branches<cr>',
                    desc = 'Telescope: Checkout branch',
                },
                {
                    '<leader>gc',
                    '<cmd>Telescope git_commits<cr>',
                    desc = 'Telescope: Checkout commit',
                },
            })

            require('gitsigns').setup({
                signs = {
                    add = { text = Icons.git.gutterbar },
                    change = { text = Icons.git.gutterbar },
                    delete = { text = Icons.git.gutterbar },
                    topdelete = { text = Icons.ui.arrowclosed4 },
                    changedelete = { text = Icons.git.gutterbar },
                    untracked = { text = Icons.git.gutterbar_dashed },
                },
                signs_staged = {
                    add = { text = Icons.git.gutterbar },
                    change = { text = Icons.git.gutterbar },
                    delete = { text = Icons.git.gutterbar },
                    topdelete = { text = Icons.git.arrowclosed4 },
                    changedelete = { text = Icons.git.gutterbar },
                    untracked = { text = Icons.git.gutterbar_dashed },
                },
                signs_staged_enable = true,
                signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
                numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
                linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
                word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir = {
                    follow_files = true,
                },
                auto_attach = true,
                attach_to_untracked = true,
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = false,
                    virt_text_priority = 100,
                },
                current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil,  -- Use default
                max_file_length = 40000, -- Disable if file is longer than this (in lines)
                preview_config = {
                    -- Options passed to nvim_open_win
                    border = 'single',
                    style = 'minimal',
                    relative = 'cursor',
                    row = 0,
                    col = 1,
                },
            })

            -- TODO: (Derek Lomax) 7/20/2024 9:06:40 PM, Tweak the highlights so
            -- that only the gutter has color and the rest is transparent
            vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = '#553355' })
            vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = DevIconAi })
            vim.api.nvim_set_hl(0, 'GitSignsChangeLine', { fg = DevIconAi })
            vim.api.nvim_set_hl(0, 'GitSignsChangeLineNr', { fg = DevIconAi })
        end,
    },

    {
        'tpope/vim-fugitive',
        keys = {
            {
                -- Set as third git plugin
                '<leader>g' .. fugitive_git_level,
                '<cmd>G<CR>',
                desc = 'Vim fugitive',
            },
        },
        config = function()
            vim.api.nvim_create_autocmd('BufEnter', {
                pattern = { 'fugitive:*' },
                callback = function()
                    -- Mappings to use fugitive to push and pull
                    vim.keymap.set('n', '<leader>gP', ':G push<CR>')
                    vim.keymap.set('n', '<leader>gp', ':G pull<CR>')

                    local fugitive_user_group = vim.api.nvim_create_augroup('fugitive_user_group', { clear = true })
                    vim.api.nvim_create_autocmd('BufNew', {
                        pattern = { '*COMMIT_EDITMSG' },
                        callback = function()
                            V('in commit')
                            vim.api.nvim_feedkeys('i', 'n', nil)
                        end,
                        group = fugitive_user_group,
                    })
                end,
            })
        end,
    },

    {
        'TimUntersberger/neogit',
        dependencies = {
            'sindrets/diffview.nvim',
        },
        keys = {
            {
                '<leader>g' .. neogit_git_level,
                function()
                    require('neogit').open()
                end,
                desc = 'Neogit',
            },
        },
        opts = {
            disable_signs = false,
            disable_hint = false,
            disable_context_highlighting = false,
            disable_commit_confirmation = true,
            -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
            -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
            auto_refresh = true,
            disable_builtin_notifications = false,
            use_magit_keybindings = false,
            commit_popup = {
                kind = 'floating',
            },
            -- Change the default way of opening neogit
            kind = 'tab',
            -- customize displayed signs
            signs = {
                -- { CLOSED, OPENED }
                section = { Icons.ui.arrowclosed3, Icons.ui.arrowopen3 },
                item = { Icons.ui.arrowclosed3, Icons.ui.arrowopen3 },
                hunk = { '', '' },
            },
            integrations = {
                diffview = true,
            },
            -- Setting any section to `false` will make the section not render at all
            sections = {
                untracked = {
                    folded = false,
                },
                unstaged = {
                    folded = false,
                },
                staged = {
                    folded = false,
                },
                stashes = {
                    folded = true,
                },
                unpulled = {
                    folded = true,
                },
                unmerged = {
                    folded = false,
                },
                recent = {
                    folded = true,
                },
            },
            -- override/add mappings
            mappings = {
                -- modify status buffer mappings
                status = {
                    -- Adds a mapping with "B" as key that does the "BranchPopup" command
                    ['B'] = 'BranchPopup',
                    -- Removes the default mapping of "s"
                    -- ["s"] = "",
                },
            },
        },
    },

    {
        'ThePrimeagen/git-worktree.nvim',
        keys = {
            { '<leader>ge', mode = 'n', desc = 'git worktree switcher' },
            { '<leader>gf', mode = 'n', desc = 'git worktree create' },
            { '<leader>gm', mode = 'n', desc = 'git worktree main' },
            { '<leader>gM', mode = 'n', desc = 'git worktree master' },
        },
        config = function()
            local worktree = require('git-worktree')
            worktree.setup()

            -- setup custom callback for events Create, Delete, Switch
            worktree.on_tree_change(function(op, metadata)
                -- op = Operations.Switch, Operations.Create, Operations.Delete
                -- metadata = table of useful values (structure dependent on op)
                --      Switch
                --          path = path you switched to
                --          prev_path = previous worktree path
                --      Create
                --          path = path where worktree created
                --          branch = branch name
                --          upstream = upstream remote name
                --      Delete
                --          path = path where worktree deleted
                if op == worktree.Operations.Switch then
                    V('Switched from ' .. metadata.prev_path .. ' to ' .. metadata.path)
                    require('nvim-tree.api').tree.change_root(metadata.path)
                end
            end)

            -- Load telescope exextension
            require('telescope').load_extension('git_worktree')

            vim.keymap.set('n', '<leader>ge', function()
                require('telescope').extensions.git_worktree.git_worktrees()
            end, { silent = true, desc = 'git worktree switcher' })

            vim.keymap.set('n', '<leader>gf', function()
                require('telescope').extensions.git_worktree.create_git_worktree()
            end, { silent = true, desc = 'git worktree create' })

            vim.keymap.set('n', '<leader>gm', function()
                worktree.switch_worktree('main')
            end, { silent = true, desc = 'git worktree main' })

            vim.keymap.set('n', '<leader>gM', function()
                worktree.switch_worktree('master')
            end, { silent = true, desc = 'git worktree master' })
        end,
    },
}
