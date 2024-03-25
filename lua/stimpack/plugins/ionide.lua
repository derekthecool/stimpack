vim.g['fsharp#fsautocomplete_command'] = {
    'fsautocomplete',
    '--adaptive-lsp-server-enabled',
}

return {
    'ionide/Ionide-vim',
    ft = { 'fsharp', 'fs', 'fsx' },
    config = function()
        -- https://github.com/ionide/Ionide-vim
        -- NOTE: this is not from the mason lsp source like most other languages
        -- this is it's own plugin and requires some setup
        -- first: `dotnet tool install -g fsautocomplete

        -- Autocommand to run file on save to fsharp interactive
        local fsharpSettingsGroup = vim.api.nvim_create_augroup('FsharpLsp', { clear = true })
        vim.api.nvim_create_autocmd(
            'BufWritePost',
            { pattern = { '*.fsx' }, command = ':FsiEvalBuffer', group = fsharpSettingsGroup }
        )
    end,
}
