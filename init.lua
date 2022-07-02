-- Ｄｅｒｅｋ'ｓ ｉｎｉｔ.ｌｕａ

-- Lua basic configuration
require('user.get-OS')
require('user.plugins') -- Source lua file ~/.config/nvim/lua/user/plugins.lua
require('user.settings') -- Source lua file ~/.config/nvim/lua/user/settings.lua
require('user.disable-vim-builtins') -- Source lua file ~/.config/nvim/lua/user/disable-vim-builtins.lua
require('user.mappings') -- Source lua file ~/.config/nvim/lua/user/mappings.lua
require('user.visualsettings') -- Source lua file ~/.config/nvim/lua/user/visualsettings.lua

-- Lua plugin configuration
require('user.vim-pandoc-markdown-preview-settings') -- Source lua file ~/.config/nvim/lua/vim-pandoc-markdown-preview-settings.lua
require('user.treesitter') -- Source lua file ~/.config/nvim/lua/treesitter.lua
require('user.vimwikisettings') -- Vimwiki is a great personal wiki and diary
require('user.which-key') -- Which-key is AMAZING to help you remember your mappings
require('user.startify') -- Very good startup up application helper
require('user.markdown-preview') -- Preview markdown in browser
require('user.vim_blob')
require('user.nvim-notify-settings')
require('user.nvim-tree-settings')
require('user.cmp')
require('user.lsp') -- A directory with its own init.lua
require('user.debugging') -- A directory with its own init.lua
require('git') -- A directory with its own init.lua
require('user.neoscroll')
require('user.telescopesettings') -- Source lua file ~/.config/nvim/lua/telescopesettings.lua
require('user.cheat-settings')
require('user.async-tasks')
require('user.luasnip-settings')
require('user.lightspeed-settings')
require('user.nvim-luapad-settings')

-- Configuration for my personal plugins that I wrote
require('user.dereks-plugins-config') -- Source lua file ~/.config/nvim/lua/dereks-plugins-config.lua


-- Use the new global status bar feature
vim.cmd([[
set lazyredraw
set laststatus=3
highlight WinSeparator guibg=none

silent! unmap f
silent! unmap F
silent! unmap t
silent! unmap T

packadd cfilter
]])


require('user.lualine-settings')
