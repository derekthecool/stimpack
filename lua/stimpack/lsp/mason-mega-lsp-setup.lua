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

    -- The directory in which to install packages.
    -- install_root_dir = path.concat({ vim.fn.stdpath('data'), 'mason' }),

    pip = {
        -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
        -- and is not recommended.
        --
        -- Example: { "--proxy", "https://proxyserver" }
        install_args = {},
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

require('mason-lspconfig').setup({
    ensure_installed = { 'sumneko_lua', 'awk_ls' },
    automatic_installation = true,
})

require('mason-lspconfig').setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.

    function(server_name) -- default handler (optional)
        require('lspconfig')[server_name].setup({})
    end,

    -- Next, you can provide targeted overrides for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- powershell_es
    -- clangd
    -- awk_ls
    -- bashls
    -- omnisharp
    -- sumneko_lua

    ['sumneko_lua'] = function()
        -- local sumneko_opts = require('stimpack.lsp.settings.sumneko_lua')
        -- opts = vim.tbl_deep_extend('force', sumneko_opts, opts)
        require('lspconfig')['sumneko_lua'].setup({
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        -- globals = { 'vim', 'use', 'it', 'describe' },
                        globals = { 'vim' },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file('', true),
                        [vim.fn.stdpath('config') .. '/lua'] = true,
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })
    end,
})
