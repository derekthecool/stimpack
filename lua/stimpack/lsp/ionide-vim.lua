-- https://github.com/ionide/Ionide-vim
-- NOTE: this is not from the mason lsp source like most other languages
-- this is it's own plugin and requires some setup
vim.g['fsharp#fsautocomplete_command'] = {
    'fsautocomplete',
    '--adaptive-lsp-server-enabled',
}

-- Autocommand to run file on save to fsharp interactive
local fsharpSettingsGroup = vim.api.nvim_create_augroup('General settings', { clear = true })
vim.api.nvim_create_autocmd(
    'BufWritePost',
    { pattern = { '*.fsx' }, command = ':FsiEvalBuffer', group = fsharpSettingsGroup }
)
