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
-- Remove o and O from indentkeys list
vim.opt.indentkeys:remove('o')
vim.opt.indentkeys:remove('O')

-- Set pwsh as default terminal. LazyVim only looks for pwsh on the PATH, where a
-- Microsoft Store install is an execution alias Neovim cannot spawn, and then falls
-- back to Windows PowerShell 5.1 without a word -- so point the shell at the pwsh
-- `config/pwsh.lua` can find.
LazyVim.terminal.setup('pwsh')
local pwsh = require('config.pwsh')
if pwsh.exe() and pwsh.exe() ~= 'pwsh' then
    vim.o.shell = pwsh.quoted()
end

-- Let a terminal program's bells and OSC 777 notifications reach WezTerm
require('config.terminal-notifications').setup()
