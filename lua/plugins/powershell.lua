local psformat = require('config.psformat')
psformat.setup()

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            indent = { enable = true }, ---@type lazyvim.TSFeat
            highlight = { enable = true }, ---@type lazyvim.TSFeat
            folds = { enable = true }, ---@type lazyvim.TSFeat
            ensure_installed = { 'powershell' },
        },
    },
    {
        'mason-org/mason.nvim',
        opts = { ensure_installed = { 'powershell-editor-services' } },
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            -- powershell.nvim manages the powershell_es client itself (named-pipe
            -- transport); letting mason-lspconfig's automatic_enable also start
            -- nvim-lspconfig's built-in stdio-based powershell_es races both
            -- processes over the same LogPath/SessionDetailsPath and one of them
            -- dies with exit code 1.
            servers = {
                powershell_es = { enabled = false },
            },
        },
    },
    {
        -- Format via PSScriptAnalyzer's Invoke-Formatter through conform.nvim.
        -- PSES's own textDocument/formatting repeatedly fails with
        -- ContentModified on save, so it is not used for formatting.
        'stevearc/conform.nvim',
        optional = true,
        opts = {
            formatters_by_ft = {
                ps1 = { 'PSScriptAnalyzer' },
            },
            formatters = {
                PSScriptAnalyzer = {
                    format = psformat.conform_format,
                },
            },
        },
    },
    {
        'TheLeoP/powershell.nvim',
        opts = {
            bundle_path = vim.fs.joinpath(vim.fn.stdpath('data'), 'mason', 'packages', 'powershell-editor-services'),
            settings = {
                powershell = {
                    ScriptAnalysis = {
                        enable = true,
                        settingsPath = psformat.settings_path,
                    },
                    -- CodeFormatting = {
                    --     autoCorrectAliases = true,
                    -- },
                },
            },
        },
    },
}
