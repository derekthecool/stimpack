return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer', -- buffer completions
            'hrsh7th/cmp-path', -- path completions
            'hrsh7th/cmp-cmdline', -- cmdline completions
            'hrsh7th/cmp-nvim-lsp-signature-help', -- Show function help while typing
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip', -- snippet completions
            'L3MON4D3/LuaSnip',
        },
        event = { 'InsertEnter', 'CursorMoved' },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            local check_backspace = function()
                local col = vim.fn.col('.') - 1
                return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
            end

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = {
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
                    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
                    ['<C-h>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),

                    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ['<C-e>'] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    -- Accept currently selected item. If none selected, `select` first item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ['∃'] = cmp.mapping.confirm({ select = true }),
                    ['×'] = cmp.mapping.confirm({ select = true }),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expandable() then
                            luasnip.expand()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif check_backspace() then
                            fallback()
                        else
                            fallback()
                        end
                    end, {
                        'i',
                        's',
                    }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, {
                        'i',
                        's',
                    }),
                },
                formatting = {
                    fields = { 'abbr', 'kind', 'menu' },
                    format = function(entry, vim_item)
                        -- Kind icons
                        vim_item.kind = string.format('%s %s', Icons.coding[vim_item.kind], vim_item.kind)
                        -- vim_item.menu = ({
                        --     nvim_lsp = '[LSP]',
                        --     nvim_lua = '[Nvim LSP]',
                        --     luasnip = '[Lua Snip]',
                        --     buffer = '[Buffer]',
                        --     path = '[Path]',
                        -- })[entry.source.name]
                        return vim_item
                    end,
                },
                sources = {
                    {
                        name = 'luasnip', --[[ option = { show_autosnippets = true  }]]
                    },
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'path' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'buffer', keyword_length = 3 },
                },
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                window = {
                    completion = {
                        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
                        winhighlight = 'Normal:DevIconEex,FloatBorder:DevIconGitIgnore,CursorLine:DevIconJpg,Search:None',
                        scrolloff = 0,
                        col_offset = 0,
                        side_padding = 1,
                    },
                    documentation = {
                        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
                        -- max_height = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
                        -- max_width = math.floor((WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
                        winhighlight = 'FloatBorder:NormalFloat',
                    },
                },
                view = {
                    native_menu = true,
                },
                experimental = {
                    ghost_text = false,
                },
            })

            -- Vim dad bod autocompletion setup
            local sql_types_wanted = { 'sql', 'mysql', 'sqlserver', 'postgresql', 'sqlite' }
            cmp.setup.filetype(sql_types_wanted, {
                sources = {
                    { name = 'luasnip' },
                    { name = 'vim-dadbod-completion' },
                    { name = 'buffer' },
                },
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },
                }, {
                    { name = 'cmdline' },
                }),
            })

            -- Custom colors
            vim.api.nvim_set_hl(0, 'CmpItemKindText', { fg = '#28d0ff' })
            vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { fg = '#aa5a7d' })
            vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { fg = '#6ee65f' })
            vim.api.nvim_set_hl(0, 'CmpItemKindConstructor', { fg = '#a8807d' })
            vim.api.nvim_set_hl(0, 'CmpItemKindField', { fg = '#3200ff' })
            vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { fg = '#003c87' })
            vim.api.nvim_set_hl(0, 'CmpItemKindClass', { fg = '#323264' })
            vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { fg = '#99664d' })
            vim.api.nvim_set_hl(0, 'CmpItemKindModule', { fg = '#335ab3' })
            vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { fg = '#7800ff' })
            vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { fg = '#1e4db3' })
            vim.api.nvim_set_hl(0, 'CmpItemKindValue', { fg = '#e6331a' })
            vim.api.nvim_set_hl(0, 'CmpItemKindEnum', { fg = '#e6e6b3' })
            vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { fg = '#3232ff' })
            vim.api.nvim_set_hl(0, 'CmpItemKindSnippet', { fg = '#b33366' })
            vim.api.nvim_set_hl(0, 'CmpItemKindColor', { fg = '#e600ff' })
            vim.api.nvim_set_hl(0, 'CmpItemKindFile', { fg = '#4d4d00' })
            vim.api.nvim_set_hl(0, 'CmpItemKindReference', { fg = '#cccc33' })
            vim.api.nvim_set_hl(0, 'CmpItemKindFolder', { fg = '#cccccc' })
            vim.api.nvim_set_hl(0, 'CmpItemKindEnummember', { fg = '#334d66' })
            vim.api.nvim_set_hl(0, 'CmpItemKindConstant', { fg = '#b399f0' })
            vim.api.nvim_set_hl(0, 'CmpItemKindStruct', { fg = '#e64d33' })
            vim.api.nvim_set_hl(0, 'CmpItemKindEvent', { fg = '#b333e6' })
            vim.api.nvim_set_hl(0, 'CmpItemKindOperator', { fg = '#33e6b3' })
            vim.api.nvim_set_hl(0, 'CmpItemKindTypeparameter', { fg = '#004d00' })

            -- mappings and settings
            local signs = {
                { name = 'DiagnosticSignError', text = Icons.diagnostics.error1 },
                { name = 'DiagnosticSignWarn', text = Icons.diagnostics.warning },
                { name = 'DiagnosticSignHint', text = Icons.diagnostics.information },
                { name = 'DiagnosticSignInfo', text = Icons.diagnostics.question },
            }

            for _, sign in ipairs(signs) do
                vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
            end

            local config = {
                -- virtual_text = true,
                -- show signs
                signs = {
                    active = signs,
                },
                update_in_insert = true,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = false,
                    style = 'minimal',
                    border = 'rounded',
                    source = 'always',
                    header = '',
                    prefix = '',
                },
            }

            -- vim.diagnostic.config(config)
            -- TODO: disable for noice
            -- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
            --     border = 'rounded',
            -- })
            -- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            --     border = 'rounded',
            -- })

            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
            vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
            vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
            vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
            vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
            vim.api.nvim_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            vim.api.nvim_set_keymap('n', '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            vim.api.nvim_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

            -- SKWHEUR
            vim.api.nvim_set_keymap('i', '…', '<cmd>lua vim.lsp.buf.completion()<CR>', opts)
            -- vim.api.nvim_set_keymap('i', '…', '<cmd>lua vim.lsp.buf.completion()<CR>', opts)
            vim.api.nvim_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
            vim.api.nvim_set_keymap('n', '<leader>ld', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
            vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
            vim.api.nvim_set_keymap('n', 'gp', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
            vim.keymap.set('n', '<leader>lf', function()
                vim.lsp.buf.format({ async = true })
            end, { silent = true, desc = 'Format code' })

            vim.keymap.set('x', '<leader>lf', function()
                vim.lsp.buf.format({
                    async = true,
                    range = {
                        ['start'] = vim.api.nvim_buf_get_mark(0, '<'),
                        ['end'] = vim.api.nvim_buf_get_mark(0, '>'),
                    },
                })
            end, { silent = true, desc = 'Format selected section' })
            vim.api.nvim_set_keymap('n', 'gl', '<cmd>lua vim.lsp.diagnostic.open_float()<CR>', opts)
            vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
            vim.api.nvim_set_keymap('n', 'gn', '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
            vim.api.nvim_set_keymap('n', '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
            vim.keymap.set('n', '<leader>li', function()
                vim.lsp.inlay_hint(0, nil)
            end, opts)
        end,
    },

    {
        'williamboman/mason.nvim',
        dependencies = { 'williamboman/mason-lspconfig.nvim', 'neovim/nvim-lspconfig', 'folke/neodev.nvim' },
        -- TODO: 8/9/2023 10:22:33 AM, Why the heck is this plugin not able to lazy load?
        -- event = 'VeryLazy',
        -- event = 'BufRead',
        -- event = { 'CursorHold', 'CursorHoldI' },
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
                ensure_installed = {
                    -- C programming
                    'clangd',
                    -- 'cmake',

                    -- Lua programming
                    'lua_ls',

                    -- C# programming
                    'omnisharp',

                    -- yaml
                    'yamlls',

                    -- Json
                    'jsonls',

                    -- Python
                    'pylsp',

                    -- Powershell
                    'powershell_es',
                },
                automatic_enable = {
                    exclude = {
                        -- setup of powershell LSP is handled by plugin powershell.nvim so do not auto setup this one
                        'powershell_es',
                    },
                },
            })

            -- Help with neovim development
            require('neodev').setup()

            -- -- Auto setup all LSPs
            -- TODO: (Derek Lomax) 5/16/2025 9:52:51 AM, Possible to do item is to make sure every LSP is using option I want
            -- require('mason-lspconfig').setup_handlers({
            --     function(server_name) -- default handler (optional)
            --         local localConfigurationFound, localConfiguration =
            --             pcall(require, string.format('stimpack.lsp.%s', server_name))
            --
            --         -- Start LSP with my local configuration settings from lua/stimpack/lsp/*
            --         -- Else start LSP with default settings if not found
            --         if localConfigurationFound then
            --             require('lspconfig')[server_name].setup(localConfiguration)
            --         else
            --             if server_name ~= 'powershell_es' then
            --                 require('lspconfig')[server_name].setup({})
            --             end
            --         end
            --     end,
            -- })

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
    },

    {
        'TheLeoP/powershell.nvim',
        opts = {
            bundle_path = OS.join_path(vim.fn.stdpath('data'), 'mason', 'packages', 'powershell-editor-services'),
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
        -- config = function()
        --     require('powershell').setup(
        --         ---@type powershell.user_config
        --         {
        --             capabilities = vim.lsp.protocol.make_client_capabilities(),
        --             bundle_path = OS.join_path(
        --                 vim.fn.stdpath('data'),
        --                 'mason',
        --                 'packages',
        --                 'powershell-editor-services'
        --             ),
        --             init_options = vim.empty_dict(),
        --             -- settings = {
        --             --     powershell = {
        --             --         ScriptAnalysis = {
        --             --             enable = true,
        --             --             settingsPath = string.format('%s/Atelier/pwsh/PSScriptAnalyzerSettings.psd1', OS.home),
        --             --         },
        --             --         CodeFormatting = {
        --             --             autoCorrectAliases = true,
        --             --         },
        --             --     },
        --             -- },
        --             shell = 'pwsh',
        --             -- handlers = base_handlers, -- see lua/powershell/handlers.lua
        --             root_dir = function(buf)
        --                 return fs.dirname(
        --                     fs.find({ '.git' }, { upward = true, path = fs.dirname(api.nvim_buf_get_name(buf)) })[1]
        --                 )
        --             end,
        --         }
        --     )
        -- end,
    },

    {
        -- Repository archived
        -- 'jose-elias-alvarez/null-ls.nvim',
        -- Use none-ls instead, drop in replacement
        'nvimtools/none-ls.nvim',
        event = 'VeryLazy',
        opts = function()
            local null_ls = require('null-ls')

            -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
            -- local formatting = null_ls.builtins.formatting
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
            -- local diagnostics = null_ls.builtins.diagnostics
            -- local code_actions = null_ls.builtins.code_actions
            -- local hover = null_ls.builtins.hover
            -- local completion = null_ls.builtins.completion

            return {
                debug = false,
                root_dir = require('null-ls.utils').root_pattern(
                    '.null-ls-root',
                    '.neoconf.json',
                    'Makefile',
                    '.git',
                    '.sln',
                    'README.md'
                ),
                sources = {
                    null_ls.builtins.formatting.csharpier,
                    null_ls.builtins.formatting.prettier.with({
                        extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' },
                    }),
                    null_ls.builtins.formatting.black.with({ extra_args = { '--fast' } }),
                    null_ls.builtins.formatting.stylua,

                    -- Requires pip install gersemi
                    null_ls.builtins.formatting.gersemi,
                    null_ls.builtins.formatting.prettier.with({
                        filetypes = { 'markdown', 'vimwiki' },
                        extra_args = { '--embedded-language-formatting=off' },
                    }),
                    null_ls.builtins.diagnostics.protolint,
                    null_ls.builtins.hover.dictionary.with({ filetypes = { 'markdown', 'text', 'vimwiki' } }),
                    -- Shell scripting
                    -- args = { "-i 2", "-filename", "$FILENAME"}, -- You can't use extra args with this as all args must be before filename
                    null_ls.builtins.formatting.shfmt,
                    -- null_ls.builtins.diagnostics.shellcheck, -- https://github.com/koalaman/shellcheck#installing Needs version 0.8.0 at least
                    -- null_ls.builtins.code_actions.shellcheck,

                    -- Sql
                    null_ls.builtins.diagnostics.sqlfluff.with({
                        extra_args = { '--dialect', 'mysql' }, -- change to your dialect
                    }),
                    null_ls.builtins.formatting.sqlfluff.with({
                        extra_args = { '--dialect', 'mysql' }, -- change to your dialect
                    }),
                },
            }
        end,
    },

    {
        'Maan2003/lsp_lines.nvim',
        event = 'CursorMoved',
        config = function()
            require('lsp_lines').setup()
            vim.keymap.set('', '<Leader>ll', require('lsp_lines').toggle, { desc = 'Toggle lsp_lines' })

            vim.diagnostic.config({
                virtual_lines = false,
                virtual_text = false,
            })
        end,
    },

    {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
        keys = { { '<leader>lb', '<cmd>CodeActionMenu<CR>', desc = 'Nvim code action menu' } },
    },
    {
        'kosayoda/nvim-lightbulb',
        event = 'CursorMoved',
        config = function()
            require('nvim-lightbulb').setup({
                -- LSP client names to ignore
                -- Example: {"sumneko_lua", "null-ls"}
                ignore = {},
                sign = {
                    enabled = true,
                    -- Priority of the gutter sign
                    priority = 90,
                },
                float = {
                    enabled = false,
                    -- Text to show in the popup float
                    text = Icons.diagnostics.hint2,
                    -- Available keys for window options:
                    -- - height     of floating window
                    -- - width      of floating window
                    -- - wrap_at    character to wrap at for computing height
                    -- - max_width  maximal width of floating window
                    -- - max_height maximal height of floating window
                    -- - pad_left   number of columns to pad contents at left
                    -- - pad_right  number of columns to pad contents at right
                    -- - pad_top    number of lines to pad contents at top
                    -- - pad_bottom number of lines to pad contents at bottom
                    -- - offset_x   x-axis offset of the floating window
                    -- - offset_y   y-axis offset of the floating window
                    -- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
                    -- - winblend   transparency of the window (0-100)
                    win_opts = {},
                },
                virtual_text = {
                    enabled = false,
                    -- Text to show at virtual text
                    text = Icons.diagnostics.hint2,
                    -- highlight mode to use for virtual text (replace, combine, blend), see :help nvim_buf_set_extmark() for reference
                    hl_mode = 'replace',
                },
                status_text = {
                    enabled = false,
                    -- Text to provide when code actions are available
                    text = Icons.diagnostics.hint2,
                    -- Text to provide when no actions are available
                    text_unavailable = '',
                },
            })

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                callback = function()
                    require('nvim-lightbulb').update_lightbulb()
                end,
                group = vim.api.nvim_create_augroup('lightbulb', { clear = true }),
            })
        end,
    },
}
