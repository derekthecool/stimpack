return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { ensure_installed = { 'powershell' } },
    },
    {
        'mason-org/mason.nvim',
        opts = { ensure_installed = { 'fsautocomplete', 'fantomas' } },
    },
    {
        'ionide/Ionide-vim',
        ft = { 'fsharp', 'fs', 'fsx' },
        config = function()
            vim.g['fsharp#fsautocomplete_command'] = { 'fsautocomplete', '--adaptive-lsp-server-enabled' }
            -- Autocommand to run file on save to fsharp interactive
            local fsharpSettingsGroup = vim.api.nvim_create_augroup('FsharpLsp', { clear = true })
            vim.api.nvim_create_autocmd(
                'BufWritePost',
                { pattern = { '*.fsx' }, command = ':FsiEvalBuffer', group = fsharpSettingsGroup }
            )
        end,
    },
}
