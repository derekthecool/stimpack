-- Ｄｅｒｅｋ'ｓ ｉｎｉｔ.ｌｕａ

-- Start up profiler that shows what takes the most time and helps speed up
-- Load before any other plugins
if not pcall(require, 'impatient') then return end

-- Lua basic configuration
require('user.global-helpers')
require('user.plugins')
require('user.settings')
require('user.auto-commands')
require('user.disable-vim-builtins')
require('user.mappings')
require('user.visualsettings')

-- Lua plugin configuration
require('user.vim-pandoc-markdown-preview-settings')
require('user.treesitter')
require('user.vimwikisettings') -- Vimwiki is a great personal wiki and diary
require('user.which-key') -- Which-key is AMAZING to help you remember your mappings
require('user.markdown-preview') -- Preview markdown in browser
require('user.toggle-term-settings')
require('user.nvim-notify-settings')
require('user.nvim-tree-settings')
require('user.cmp')
require('user.lsp')
require('user.debugging')
require('git')
require('user.neoscroll')
require('user.telescopesettings')
require('user.cheat-settings')
require('user.async-tasks')
require('user.luasnip-settings')
require('user.leap-settings')
require('user.nvim-luapad-settings')

-- Configuration for my personal plugins that I wrote
require('user.dereks-plugins-config')

-- Source last
require('user.lualine-settings')
