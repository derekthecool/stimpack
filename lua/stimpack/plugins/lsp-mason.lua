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
        -- require('neodev').setup()

        -- Auto setup all LSPs
        require('mason-lspconfig').setup_handlers({
            function(server_name) -- default handler (optional)
                if server_name == 'lua_ls' then
                    require('lspconfig')[server_name].setup({
                        -- Lua = {
                        --     workspace = { checkThirdParty = false },
                        --     telemetry = { enable = false },
                        -- },

                        Lua = {
                            runtime = {
                                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                                version = 'LuaJIT',
                            },
                            diagnostics = {
                                -- Get the language server to recognize the `vim` global
                                globals = { 'vim', 'use', 'it', 'describe' },
                                -- globals = { 'vim' },
                            },
                            workspace = {
                                -- Make the server aware of Neovim runtime files
                                library = {
                                    vim.api.nvim_get_runtime_file('', true),
                                    -- Add awesome WM libraries
                                    '/usr/share/awesome/lib/awful/',
                                    '/usr/share/awesome/lib/beautiful/',
                                    '/usr/share/awesome/lib/gears/',
                                    '/usr/share/awesome/lib/menubar/',
                                    '/usr/share/awesome/lib/naughty/',
                                    '/usr/share/awesome/lib/wibox/',
                                },
                                [vim.fn.stdpath('config') .. '/lua'] = true,
                            },
                            -- Do not send telemetry data containing a randomized but unique identifier
                            telemetry = {
                                enable = false,
                            },
                        },
                    })

                    require('neodev').setup()
                else
                    require('lspconfig')[server_name].setup({})
                end
            end,

            -- TODO: commenting this out seems best for now. After sumneko_lua was deprecated and I named to lua_ls to get rid of warnings is stopped working
            -- ['lua_ls'] = function()
            --     require('neodev').setup()
            --     require('lspconfig')['lua_ls'].setup({
            --         settings = {
            --             Lua = {
            --                 runtime = {
            --                     -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            --                     version = 'LuaJIT',
            --                 },
            --                 diagnostics = {
            --                     -- Get the language server to recognize the `vim` global
            --                     globals = { 'vim', 'use', 'it', 'describe' },
            --                     -- globals = { 'vim' },
            --                 },
            --                 workspace = {
            --                     -- Make the server aware of Neovim runtime files
            --                     library = {
            --                         vim.api.nvim_get_runtime_file('', true),
            --                         -- Add awesome WM libraries
            --                         '/usr/share/awesome/lib/awful/',
            --                         '/usr/share/awesome/lib/beautiful/',
            --                         '/usr/share/awesome/lib/gears/',
            --                         '/usr/share/awesome/lib/menubar/',
            --                         '/usr/share/awesome/lib/naughty/',
            --                         '/usr/share/awesome/lib/wibox/',
            --                     },
            --                     [vim.fn.stdpath('config') .. '/lua'] = true,
            --                 },
            --                 -- Do not send telemetry data containing a randomized but unique identifier
            --                 telemetry = {
            --                     enable = false,
            --                 },
            --             },
            --         },
            --     })
            -- end,
        })

        -- Third load lspconfig
        require('lspconfig')
        local signs = {
            { name = 'DiagnosticSignError', text = Icons.diagnostics.error1 },
            { name = 'DiagnosticSignWarn',  text = Icons.diagnostics.warning },
            { name = 'DiagnosticSignHint',  text = Icons.diagnostics.information },
            { name = 'DiagnosticSignInfo',  text = Icons.diagnostics.question },
        }

        for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
        end

        -- local config = {
        --     -- virtual_text = true,
        --     -- show signs
        --     signs = {
        --         active = signs,
        --     },
        --     update_in_insert = true,
        --     underline = true,
        --     severity_sort = true,
        --     float = {
        --         focusable = false,
        --         style = 'minimal',
        --         border = 'rounded',
        --         source = 'always',
        --         header = '',
        --         prefix = '',
        --     },
        -- }
        --
        -- vim.diagnostic.config(config)
        -- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
        --     border = 'rounded',
        -- })
        --
        -- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        --     border = 'rounded',
        -- })
    end,
}
