-- Ｄｅｒｅｋ'ｓ ｉｎｉｔ.ｌｕａ
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ',' -- Map leader to comma instead of space since switching to stenography. Spacing is done after each word so comma is better for me now.

require('stimpack.global-helpers')

require('lazy').setup('stimpack.plugins')

-- Lua basic configuration
-- require('stimpack.plugins')
require('stimpack.settings')
require('stimpack.auto-commands')
require('stimpack.disable-vim-builtins')
require('stimpack.mappings')
require('stimpack.visualsettings')

-- Lua plugin configuration
require('stimpack.lsp') -- Directory with its own init.lua
--require('stimpack.git') -- Directory with its own init.lua

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
--require('stimpack.debugging')
require('stimpack.neoscroll')
require('stimpack.telescopesettings')
require('stimpack.cheat-settings')
-- require('stimpack.async-tasks')
require('stimpack.luasnip-settings')
require('stimpack.leap-settings')
require('stimpack.vim-rooter-settings')
require('stimpack.nvim-luapad-settings')
require('stimpack.code-auto-run')
require('stimpack.dressing-nvim-settings')

-- Configuration for my personal plugins that I wrote
-- require('stimpack.dereks-plugins-config')

-- Source last
-- require('stimpack.lualine-settings')

-- Firenvim plugin settings very last
--require('stimpack.firenvim-settings')
