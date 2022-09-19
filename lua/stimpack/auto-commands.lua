-- Create augroup for the autocommands in this file
-- 2022-09-19: is a special day because I finally understand vim/neovim autocommands!
local generalSettingsGroup = vim.api.nvim_create_augroup('General settings', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost * ', {
    callback = function()
        require('vim.highlight').on_yank({ higroup = 'Visual', timeout = 500 })
    end,
    group = generalSettingsGroup,
})

-- This autocommand does not seem to work right on nonhelp files, not able to do macros
vim.api.nvim_create_autocmd(
    'FileType',
    { pattern = { 'qf', 'help' }, command = 'nnoremap <silent> <buffer> q :close<cr>', group = generalSettingsGroup }
)
vim.api.nvim_create_autocmd('BufWinEnter', { command = ':set formatoptions-=cro', group = generalSettingsGroup })

-- Map xaml and axaml to have xml syntax
vim.api.nvim_create_autocmd(
    { 'BufRead', 'BufNewFile' },
    { pattern = { '*.xaml', '*.axaml' }, command = ':set filetype=xml', group = generalSettingsGroup }
)
