return {
    {
        -- This feature is nearly replaced by the neovim builtin ':InspectTree'
        -- But this plugin allows for testing query which is very helpful
        'nvim-treesitter/playground',
        keys = { '<leader>ab', '<cmd>TSPlaygroundToggle<CR>', desc = 'Toggle Treesitter Playground' },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
        event = 'VeryLazy',
        config = function()
            require('nvim-treesitter.configs').setup({
                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                ensure_installed = {
                    'bash',
                    'c',
                    'c_sharp',
                    'cmake',
                    'comment',
                    'cpp',
                    'lua',
                    'markdown',
                    'proto',
                    'python',
                    'regex',
                    'vim',
                },

                ignore_install = { 'all' },

                auto_install = true,

                highlight = {
                    enable = true,
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },

                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = false, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = 'o',
                        toggle_hl_groups = 'i',
                        toggle_injected_languages = 't',
                        toggle_anonymous_nodes = 'a',
                        toggle_language_display = 'I',
                        focus_language = 'f',
                        unfocus_language = 'F',
                        update = 'R',
                        goto_node = '<cr>',
                        show_help = '?',
                    },
                    query_linter = {
                        enable = true,
                        use_virtual_text = true,
                        lint_events = { 'BufWrite', 'CursorHold' },
                    },
                },

                textobjects = {
                    lsp_interop = {
                        enable = true,
                        border = 'rounded',
                        peek_definition_code = {
                            ['<leader>df'] = '@function.outer',
                            ['<leader>dF'] = '@class.outer',
                        },
                    },
                    select = {
                        enable = true,
                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                        },
                    },
                    swap = {
                        enable = true,
                        -- TODO: make better mapping, I use this often
                        -- I'll need to make my own queries to enhance this: https://www.reddit.com/r/neovim/comments/tlkieq/swapping_objects_with_nvimtreesittertextobjects/
                        swap_next = {
                            ['<leader>hn'] = '@parameter.inner',
                        },
                        swap_previous = {
                            ['<leader>hN'] = '@parameter.inner',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            -- TODO: what is the difference between inner and outer?
                            ['<leader>tnfs'] = '@function.outer',
                        },
                        goto_next_end = {
                            ['<leader>tnfe'] = '@function.outer',
                        },
                        goto_previous_start = {
                            ['<leader>tpfs'] = '@function.outer',
                        },
                        goto_previous_end = {
                            ['<leader>tpfe'] = '@function.outer',
                        },
                    },
                },
            })

            -- local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
            -- parser_config.powershell = {
            --     install_info = {
            --         url = string.format('%s/nvim-plugin-development/tree-sitter-PowerShell', OS['home']), -- local path or git repo
            --         files = { 'src/scanner.c', 'src/parser.c' }, -- note that some parsers also require src/scanner.c or src/scanner.cc
            --         -- optional entries:
            --         branch = 'master', -- default branch in case of git repo if different from master
            --         generate_requires_npm = false, -- if stand-alone parser without npm dependencies
            --         requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
            --     },
            --     filetype = 'ps1', -- if filetype does not match the parser name
            -- }
        end,
    },
}
