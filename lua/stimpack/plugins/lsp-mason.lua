return {
    'williamboman/mason.nvim',
    dependencies = { 'williamboman/mason-lspconfig.nvim', 'neovim/nvim-lspconfig', 'folke/neodev.nvim' },
    -- event = 'VeryLazy',
    config = function()
        -- First load mason
        require('mason').setup({
            ui = {
                -- Whether to automatically check for new versions when opening the :Mason window.
                check_outdated_packages_on_open = true,
                -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
                border = 'rounded',
                icons = {
                    -- -- The list icon to use for installed packages.
                    -- package_installed = "◍",
                    -- -- The list icon to use for packages that are installing, or queued for installation.
                    -- package_pending = "◍",
                    -- -- The list icon to use for packages that are not installed.
                    -- package_uninstalled = '◍',
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗',
                },
                keymaps = {
                    -- Keymap to expand a package
                    toggle_package_expand = '<CR>',
                    -- Keymap to install the package under the current cursor position
                    install_package = 'i',
                    -- Keymap to reinstall/update the package under the current cursor position
                    update_package = 'u',
                    -- Keymap to check for new version for the package under the current cursor position
                    check_package_version = 'c',
                    -- Keymap to update all installed packages
                    update_all_packages = 'U',
                    -- Keymap to check which installed packages are outdated
                    check_outdated_packages = 'C',
                    -- Keymap to uninstall a package
                    uninstall_package = 'X',
                    -- Keymap to cancel a package installation
                    cancel_installation = '<C-c>',
                    -- Keymap to apply language filter
                    apply_language_filter = '<C-f>',
                },
            },
            -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
            -- debugging issues with package installations.
            log_level = vim.log.levels.INFO,
            -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
            -- packages that are requested to be installed will be put in a queue.
            max_concurrent_installers = 4,
            github = {
                -- The template URL to use when downloading assets from GitHub.
                -- The placeholders are the following (in order):
                -- 1. The repository (e.g. "rust-lang/rust-analyzer")
                -- 2. The release version (e.g. "v0.3.0")
                -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
                download_url_template = 'https://github.com/%s/releases/download/%s/%s',
            },
        })

        -- Second load mason-lspconfig
        require('mason-lspconfig').setup({
            ensure_installed = { 'lua_ls' },
            -- automatic_installation = true, -- This one sounds good but it really means it will auto install any lsp for a file with variable lsp.
        })

        -- Help with neovim development
        require('neodev').setup()

        -- Auto setup all LSPs
        require('mason-lspconfig').setup_handlers({
            function(server_name) -- default handler (optional)
                local localConfigurationFound, localConfiguration =
                    pcall(require, string.format('stimpack.lsp.%s', server_name))

                -- Start LSP with my local configuration settings from lua/stimpack/lsp/*
                -- Else start LSP with default settings if not found
                if localConfigurationFound then
                    require('lspconfig')[server_name].setup(localConfiguration)
                else
                    require('lspconfig')[server_name].setup({})
                end
            end,
        })

        -- Third load lspconfig
        require('lspconfig')
        local signs = {
            { name = 'DiagnosticSignError', text = Icons.diagnostics.error1 },
            { name = 'DiagnosticSignWarn', text = Icons.diagnostics.warning },
            { name = 'DiagnosticSignHint', text = Icons.diagnostics.information },
            { name = 'DiagnosticSignInfo', text = Icons.diagnostics.question },
        }

        for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
        end
    end,
}
