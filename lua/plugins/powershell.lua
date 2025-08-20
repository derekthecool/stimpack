return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { ensure_installed = { 'powershell' } },
    },
    {
        'mason-org/mason.nvim',
        opts = { ensure_installed = { 'powershell-editor-services' } },
    },
    {
        'TheLeoP/powershell.nvim',
        opts = {
            bundle_path = vim.fs.joinpath(vim.fn.stdpath('data'), 'mason', 'packages', 'powershell-editor-services'),
            settings = {
                powershell = {
                    ScriptAnalysis = {
                        enable = true,
                        settingsPath = string.format('%s/Atelier/pwsh/PSScriptAnalyzerSettings.psd1', OS.home),
                    },
                    CodeFormatting = {
                        autoCorrectAliases = true,
                    },
                },
            },
        },
    },
    -- TODO: (Derek Lomax) 8/20/2025 9:51:06 AM, get formatting working
    -- {
    --     'stevearc/conform.nvim',
    --     optional = true,
    --     opts = {
    --         formatters_by_ft = {
    --             ps1 = { 'csharpier' },
    --         },
    --         formatters = {
    --             csharpier = {
    --                 command = 'dotnet-csharpier',
    --                 args = { '--write-stdout' },
    --             },
    --         },
    --     },
    -- },
}
