-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ','
vim.g.maplocalleader = '-' -- Default is \ which I really like for pounce plugin

vim.o.scrolloff = 999 -- Keep cursor vertically centered
vim.opt.mouse = ''
vim.opt.wrap = false
vim.opt.shiftwidth = 4
vim.opt.swapfile = false

-- Set pwsh as default terminal
LazyVim.terminal.setup('pwsh')
