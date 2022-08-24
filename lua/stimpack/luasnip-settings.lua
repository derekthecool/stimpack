-- Setup location to load my custom lua snippets - NOTE: the value OS.snippets
-- is a global table from my config which helps me have cross platform setup
require('luasnip.loaders.from_lua').load({ paths = OS.snippets })
-- Setup VSCode snippet loader with loads snippets from the plugin: rafamadriz/friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()

local types = require('luasnip.util.types')

-- Set my config options
require('luasnip').config.set_config({
  history = true,
  update_events = 'TextChanged,TextChangedI', -- update text as you type
  enable_autosnippets = true, -- I NEED autosnippets to live, default is false
  -- store_selection_keys = '<c-s>', -- I'm not sure about this, the default has it nil

  -- Add awesome highlights to help show where you are at in a snippet
  -- Think of them as a road map of where you're going
  ext_opts = {
    -- Nodes that don't need highlights:
    -- Text node. It just makes a mess and does not help anything

    -- TODO: make the virtual text into just a symbol once I know what they do and what colors I like

    [types.snippet] = {
      -- show nothing when active
      active = { virt_text = { { '' } } },
      -- Display a blue icon after leaving snippet. This'll help remind to use snippet history
      snippet_passive = { virt_text = { { ' ', 'DevIconDropbox' } } },
    },

    [types.insertNode] = {
      -- Display bright orange icon when active
      active = { virt_text = { { '', 'DevIconOPUS' } } },
      -- Display gray icon when passive
      passive = { virt_text = { { '', 'DevIconDefault' } } },
    },

    [types.functionNode] = {
      -- Display green icon when active
      active = { virt_text = { { ' ', 'DevIconCsv' } } },
      -- Display gray icon when passive
      passive = { virt_text = { { ' ', 'DevIconDefault' } } },
    },

    [types.dynamicNode] = {
      -- Display purple icon when active
      active = { virt_text = { { ' ', 'DevIconSln' } } },
      -- Display gray icon when passive
      passive = { virt_text = { { ' ', 'DevIconDefault' } } },
    },

    [types.choiceNode] = {
      -- Display a yellow icon when active
      active = { virt_text = { { '', 'DevIconCoffee' } } },
      -- Display gray icon when passive
      passive = { virt_text = { { '', 'DevIconIni' } } },
    },
  },
})

local map = require('stimpack.mapping-function')
map('i', '<c-j>', '<cmd>lua require\'luasnip\'.jump(1)<CR>')
map('s', '<c-j>', '<cmd>lua require\'luasnip\'.jump(1)<CR>')
map('i', '<c-k>', '<cmd>lua require\'luasnip\'.jump(-1)<CR>')
map('s', '<c-k>', '<cmd>lua require\'luasnip\'.jump(-1)<CR>')
map('i', '👉👉', '<cmd>lua require\'luasnip\'.jump(1)<CR>')
map('s', '👉👉', '<cmd>lua require\'luasnip\'.jump(1)<CR>')
map('i', '👈👈', '<cmd>lua require\'luasnip\'.jump(-1)<CR>')
map('s', '👈👈', '<cmd>lua require\'luasnip\'.jump(-1)<CR>')
map('i', '<c-d>', '<cmd>lua require\'luasnip\'.jump(1)<CR>')
map('s', '<c-d>', '<cmd>lua require\'luasnip\'.jump(1)<CR>')
map('i', '<c-u>', '<cmd>lua require\'luasnip\'.jump(-1)<CR>')
map('s', '<c-u>', '<cmd>lua require\'luasnip\'.jump(-1)<CR>')

map('i', '☝', '<cmd>lua require("luasnip.extras.select_choice")()<cr>')

-- My mapping function causes an error
-- map('i', '👉', '<Plug>luasnip-next-choice<CR>')
-- map('s', '👉', '<Plug>luasnip-next-choice<CR>')
-- map('i', '👈', '<Plug>luasnip-prev-choice<CR>')
-- map('s', '👈', '<Plug>luasnip-prev-choice<CR>')
vim.api.nvim_set_keymap('i', '👉', '<Plug>luasnip-next-choice', {})
vim.api.nvim_set_keymap('s', '👉', '<Plug>luasnip-next-choice', {})
vim.api.nvim_set_keymap('i', '👈', '<Plug>luasnip-prev-choice', {})
vim.api.nvim_set_keymap('s', '👈', '<Plug>luasnip-prev-choice', {})

-- STWHEUFL
map('n', '👇', '<cmd>lua require("luasnip.loaders.from_lua").edit_snippet_files()<CR>')
-- STWHEUFLS
map('n', '👇👇', '<cmd>source ' .. OS.nvim .. 'lua/stimpack/luasnip-settings.lua<cr>')
