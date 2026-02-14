local PSScriptAnalyzerSettingsPath = string.format('%s/Atelier/pwsh/PSScriptAnalyzerSettings.psd1', OS.home)

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
        'TheLeoP/powershell.nvim',
        opts = {
            bundle_path = vim.fs.joinpath(vim.fn.stdpath('data'), 'mason', 'packages', 'powershell-editor-services'),
            settings = {
                powershell = {
                    ScriptAnalysis = {
                        enable = true,
                        settingsPath = PSScriptAnalyzerSettingsPath,
                    },
                    -- CodeFormatting = {
                    --     autoCorrectAliases = true,
                    -- },
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
                        [[(Invoke-Formatter -ScriptDefinition ([Console]::In.ReadToEnd()) -Settings ]]
                            .. PSScriptAnalyzerSettingsPath
                            .. [[).TrimEnd()]],
                    },
                    stdin = true,
                    timeout_ms = 20000,
                },
            },
        },
    },
}
