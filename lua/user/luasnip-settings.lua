-- Setup location to load my custom lua snippets - NOTE: the value OS.snippets
-- is a global table from my config which helps me have cross platform setup
require("luasnip.loaders.from_lua").load({ paths = OS.snippets })
-- Setup VSCode snippet loader with loads snippets from the plugin: rafamadriz/friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Set my config options
require("luasnip").config.set_config {
  history = true,
  update_events = "TextChanged,TextChangedI", -- update text as you type
  enable_autosnippets = true, -- I NEED autosnippets to live default is false
  -- store_selection_keys = '<c-s>', -- I'm not sure about this, the default has it nil
}

local map = require('user.mapping-function')
map("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>")
map("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>")
map("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>")
map("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>")

-- Steno down with root semicolon
map('n', '∄', '<cmd>lua require("luasnip.loaders.from_lua").edit_snippet_files()<CR>')
-- Steno left with root semicolon
map('i', '∀', '<cmd>lua require("luasnip.extras.select_choice")()<cr>')
-- Steno down with root backslash
map('n', '∄∄', '<cmd>source ' .. OS.nvim .. 'lua/user/luasnip-settings.lua<cr>')
