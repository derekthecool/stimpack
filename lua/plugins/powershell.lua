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
    {
        'stevearc/conform.nvim',
        optional = true,
        opts = {
            formatters_by_ft = {
                ps1 = { 'PSScriptAnalyzer' },
            },
            formatters = {
                PSScriptAnalyzer = {
                    command = 'pwsh',
                    args = {
                        '-NoProfile',
                        '-Command',
                        'Invoke-Formatter',
                        '-ScriptDefinition',
                        string.format('(Get-Content %s -Raw)', vim.fn.expand('%:p')),
                        -- TODO: (Derek Lomax) 9/11/2025 9:46:36 AM, my settings are not working well, the formatting is gross! It works better without this for now.
                        -- '-Settings',
                        -- string.format('%s/Atelier/pwsh/PSScriptAnalyzerSettings.psd1', OS.home),
                    },
                },
            },
        },
    },
}
