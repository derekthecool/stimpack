return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/playground',
    },
    build = ':TSUpdate',
    event = 'VeryLazy',
    config = function()
        require('nvim-treesitter.configs').setup({

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
                        ['<leader>t011'] = '@conditional.outer',
                    },
                    swap_previous = {
                        ['<leader>hN'] = '@parameter.inner',
                        ['<leader>t311'] = '@conditional.outer',
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        -- TODO: what is the difference between inner and outer?
                        ['<leader>tnfs'] = '@function.outer',
                        -- ['<leader>t201'] = '@function.outer',
                        -- ['<leader>t211'] = '@conditional.outer',
                        -- ['<leader>t221'] = '@class.outer',
                    },
                    goto_next_end = {
                        ['<leader>tnfe'] = '@function.outer',
                        -- ['<leader>t202'] = '@function.outer',
                        -- ['<leader>t212'] = '@conditional.outer',
                        -- ['<leader>t222'] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['<leader>tpfs'] = '@function.outer',
                        -- ['<leader>t101'] = '@function.outer',
                        -- ['<leader>t111'] = '@conditional.outer',
                        -- ['<leader>t121'] = '@class.outer',
                    },
                    goto_previous_end = {
                        ['<leader>tpfe'] = '@function.outer',
                        -- ['<leader>t102'] = '@function.outer',
                        -- ['<leader>t112'] = '@conditional.outer',
                        -- ['<leader>t122'] = '@class.outer',
                    },
                },
            },
        })
    end,
}
