-- Headless CI check: verify every Lua file parses and the snippet files load. Prints only failures; exits non-zero if any.
-- Usage: nvim --headless '+Lazy! restore' '+luafile .github/scripts/ci-check.lua' +qa
local failures = {}

local function fail(msg)
    table.insert(failures, msg)
end

-- Run after the normal config has loaded (see usage); plugins are already installed and restored.
require('lazy').load({ plugins = { 'LuaSnip' } })

-- Syntax check every Lua file in the config.
for _, file in ipairs(vim.fn.glob(vim.fn.stdpath('config') .. '/lua/**/*.lua', false, true)) do
    local chunk, parse_err = loadfile(file)
    if not chunk then
        fail(parse_err)
    end
end

-- LuaSnip loads every snippet file; errors there are otherwise silent.
local ok_snip, snip_err = pcall(function()
    require('luasnip.loaders.from_lua').load({ paths = vim.fn.stdpath('config') .. '/lua/luasnippets' })
end)
if not ok_snip then
    fail('luasnip: ' .. tostring(snip_err))
end

-- `config/autocmds.lua` and the keymaps are loaded on VeryLazy, which never arrives
-- without a UI, so ask for it before testing anything they set up.
vim.api.nvim_exec_autocmds('User', { pattern = 'VeryLazy', modeline = false })

-- Terminals get a tab page to themselves, and have to be opened at the size they
-- keep: Snacks starts the job as soon as the window exists, so a window that is
-- grown afterwards resizes the pty under a TUI that has already drawn itself.
local tabterm = require('config.tab-terminal')
local start_tab = vim.api.nvim_get_current_tabpage()

tabterm.open(function()
    -- `auto_close = false`: wiping the buffer below must not look like a crash.
    Snacks.terminal.open(nil, { auto_close = false, win = { position = 'current' } })
end)

local term_buf = vim.api.nvim_get_current_buf()
if vim.bo[term_buf].buftype ~= 'terminal' then
    fail('tab-terminal: opening a terminal left a ' .. vim.bo[term_buf].buftype .. ' buffer focused')
else
    local tab = vim.api.nvim_get_current_tabpage()
    if tab == start_tab then
        fail('tab-terminal: the terminal opened in the tab page it was called from')
    end
    -- `tidy()` runs on the next tick, so give it one.
    vim.wait(1000, function()
        return #vim.api.nvim_tabpage_list_wins(tab) == 1
    end)
    local wins = vim.api.nvim_tabpage_list_wins(tab)
    local width = vim.api.nvim_win_get_width(wins[1])
    if #wins ~= 1 then
        fail('tab-terminal: the terminal shares its tab page with ' .. (#wins - 1) .. ' other window(s)')
    elseif width ~= vim.o.columns then
        fail(('tab-terminal: the terminal is %d columns of a %d column tab page'):format(width, vim.o.columns))
    end
    tabterm.leave()
    if vim.api.nvim_get_current_tabpage() ~= start_tab then
        fail('tab-terminal: leave() did not go back to the tab page the terminal was opened from')
    end

    -- A terminal has to come back in the mode it was left in instead of being put
    -- back in insert at the bottom of the scrollback (see `config/autocmds.lua`).
    -- Real mode changes cannot be driven from inside a `:luafile`, so fire the events
    -- they would: what the rule has to tell apart is a TermLeave that lands somewhere
    -- else from one that leaves us standing in the terminal.
    local term_win = wins[1]
    local settle = function()
        vim.wait(200, function()
            return false
        end)
    end

    if vim.b[term_buf].terminal_insert ~= true then
        fail('terminal state: a terminal that was just opened is not ready to type in')
    end

    vim.api.nvim_set_current_win(term_win)
    vim.api.nvim_exec_autocmds('TermEnter', { buffer = term_buf })
    vim.api.nvim_exec_autocmds('TermLeave', { buffer = term_buf })
    tabterm.leave()
    settle()
    if vim.b[term_buf].terminal_insert ~= true then
        fail('terminal state: switching away from a terminal was taken for leaving terminal mode')
    end

    vim.api.nvim_set_current_win(term_win)
    vim.api.nvim_exec_autocmds('TermEnter', { buffer = term_buf })
    vim.api.nvim_exec_autocmds('TermLeave', { buffer = term_buf })
    settle()
    if vim.b[term_buf].terminal_insert ~= false then
        fail('terminal state: stepping into normal mode on purpose was not remembered')
    end
    tabterm.leave()
end
pcall(vim.api.nvim_buf_delete, term_buf, { force = true })

-- Claude has to take the whole tab page the same way. The Snacks default is a
-- third-width split, and Claude never redraws properly once it has been resized.
local ai_spec = dofile(vim.fn.stdpath('config') .. '/lua/plugins/ai.lua')
local claude_position = vim.tbl_get(ai_spec[1] or {}, 'opts', 'terminal', 'snacks_win_opts', 'position')
if claude_position ~= 'current' then
    fail('ai.lua: the Claude terminal is positioned \'' .. tostring(claude_position) .. '\', expected \'current\'')
end

if #failures > 0 then
    io.stderr:write(table.concat(failures, '\n') .. '\n')
    os.exit(1)
end
print('ci-check: ok')
