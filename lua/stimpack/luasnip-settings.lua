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
  ext_opts = {
    -- TODO: make the virtual text into just a symbol once I know what they do and what colors I like
    [types.insertNode] = {
      active = { virt_text = { { '🖊  insert:::active', 'DevIconCsv' } } },
      passive = { virt_text = { { '🖊  insert:::passive', 'DevIconDefault' } } },
      snippet_passive = { virt_text = { { '🖊  insert:::snippet_passive', 'DevIconDefault' } } },
    },

    [types.textNode] = {
      active = { virt_text = { { '©️ text:::active', 'DevIconCsv' } } },
      -- passive = { virt_text = { { '● text:::passive', 'DevIconDefault' } } }, -- way to noisy
      -- snippet_passive = { virt_text = { { '● text:::snippet_passive', 'DevIconDefault' } } }, -- way to noisy
    },

    [types.functionNode] = {
      active = { virt_text = { { '● function:::active', 'DevIconCsv' } } },
      passive = { virt_text = { { '● function:::passive', 'DevIconDefault' } } },
      snippet_passive = { virt_text = { { '● function:::snippet_passive', 'DevIconDefault' } } },
    },

    [types.dynamicNode] = {
      active = { virt_text = { { '● dynamic:::active', 'DevIconCsv' } } },
      passive = { virt_text = { { '● dynamic:::passive', 'DevIconDefault' } } },
      snippet_passive = { virt_text = { { '● dynamic:::snippet_passive', 'DevIconDefault' } } },
    },

    [types.choiceNode] = {
      active = { virt_text = { { '● choice:::active', 'DevIconDropbox' } } },
      passive = { virt_text = { { '● choice:::passive', 'DevIconIni' } } },
      snippet_passive = { virt_text = { { '● choice:::snippet_passive', 'DevIconEex' } } },
    },

    [types.snippet] = {
      active = { virt_text = { { '● snippet:::active', 'DevIconBmp' } } },
      passive = { virt_text = { { '● snippet:::passive', 'DevIconAwk' } } },
      snippet_passive = { virt_text = { { '● snippet:::snippet_passive', 'DevIconCpp' } } },
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
