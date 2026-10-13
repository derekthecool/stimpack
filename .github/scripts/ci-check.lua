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

if #failures > 0 then
    io.stderr:write(table.concat(failures, '\n') .. '\n')
    os.exit(1)
end
print('ci-check: ok')
