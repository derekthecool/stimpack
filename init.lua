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
require('stimpack.settings')
require('stimpack.auto-commands')
require('stimpack.disable-vim-builtins')
require('stimpack.mappings')
require('stimpack.visualsettings')
require('stimpack.code-auto-run')
require('stimpack.file-watcher')

-- Configuration for my personal plugins that I wrote
-- require('stimpack.dereks-plugins-config')

-- Source last
-- require('stimpack.lualine-settings')

-- Firenvim plugin settings very last
--require('stimpack.firenvim-settings')
