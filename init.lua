-- Ｄｅｒｅｋ'ｓ ｉｎｉｔ.ｌｕａ

-- Map leader to comma instead of space since switching to stenography.
-- Spacing is done after each word so comma is better for me now.
vim.g.mapleader = ','

require('stimpack.global-helpers')

-- Load lazy.nvim
require('stimpack.package-manager-config')

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
