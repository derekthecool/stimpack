-- Ｄｅｒｅｋ"ｓ ｉｎｉｔ.ｌｕａ

-- Start up profiler that shows what takes the most time and helps speed up
-- Load before any other plugins
if not pcall(require, 'impatient') then
    return
end

-- Lua basic configuration
require('stimpack.global-helpers')
require('stimpack.plugins')
require('stimpack.settings')
require('stimpack.auto-commands')
require('stimpack.disable-vim-builtins')
require('stimpack.mappings')
require('stimpack.visualsettings')

-- Lua plugin configuration
require('stimpack.lsp') -- Directory with its own init.lua
require('stimpack.git') -- Directory with its own init.lua

require('stimpack.file-watcher')
require('stimpack.vim-pandoc-markdown-preview-settings')
require('stimpack.treesitter')
require('stimpack.vimwikisettings') -- Vimwiki is a great personal wiki and diary
require('stimpack.which-key') -- Which-key is AMAZING to help you remember your mappings
require('stimpack.markdown-preview') -- Preview markdown in browser
require('stimpack.toggle-term-settings')
require('stimpack.nvim-notify-settings')
require('stimpack.nvim-tree-settings')
require('stimpack.cmp')
require('stimpack.debugging')
require('stimpack.neoscroll')
require('stimpack.telescopesettings')
require('stimpack.cheat-settings')
require('stimpack.async-tasks')
require('stimpack.luasnip-settings')
require('stimpack.leap-settings')
require('stimpack.nvim-luapad-settings')

-- Configuration for my personal plugins that I wrote
require('stimpack.dereks-plugins-config')

-- Source last
require('stimpack.lualine-settings')
