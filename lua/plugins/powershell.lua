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
        init = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.name == 'powershell_es' then
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({
                                    async = false,
                                    timeout_ms = 10000,
                                    bufnr = args.buf,
                                    filter = function(c)
                                        return c.name == 'powershell_es'
                                    end,
                                })
                            end,
                        })
                    end
                end,
            })
        end,
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
}
