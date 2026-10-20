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
