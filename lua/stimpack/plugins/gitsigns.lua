return {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    config = function()
        local which_key_mapper = require('stimpack.which-key-mapping')
        which_key_mapper({
            g = {
                name = 'git', -- optional group name
                G = {
                    '<cmd>Gitsigns toggle_deleted<cr>',
                    'Gitsigns toggle display of deleted lines',
                },
                B = {
                    '<cmd>Gitsigns toggle_current_line_blame<cr>',
                    'Gitsigns toggle display of deleted lines',
                },
                j = {
                    function()
                        require('gitsigns').next_hunk()
                    end,
                    'Next Hunk',
                },
                k = {
                    function()
                        require('gitsigns').prev_hunk()
                    end,
                    'Prev Hunk',
                },
                l = {
                    function()
                        require('gitsigns').blame_line()
                    end,
                    'Blame',
                },
                p = {
                    function()
                        require('gitsigns').preview_hunk()
                    end,
                    'Preview Hunk',
                },
                r = {
                    function()
                        require('gitsigns').reset_hunk()
                    end,
                    'Reset Hunk',
                },
                R = {
                    function()
                        require('gitsigns').reset_buffer()
                    end,
                    'Reset Buffer',
                },
                s = {
                    function()
                        require('gitsigns').stage_hunk()
                    end,
                    'Stage Hunk',
                },
                u = {
                    function()
                        require('gitsigns').undo_stage_hunk()
                    end,
                    'Undo Stage Hunk',
                },
                t = {
                    '<cmd>Gitsigns diffthis HEAD<cr>',
                    'Diff',
                },
                -- telescope
                o = {
                    '<cmd>Telescope git_status<cr>',
                    'Telescope: Open changed file',
                },
                b = {
                    '<cmd>Telescope git_branches<cr>',
                    'Telescope: Checkout branch',
                },
                c = {
                    '<cmd>Telescope git_commits<cr>',
                    'Telescope: Checkout commit',
                },
                -- 'sindrets/diffview.nvim'
                d = {
                    function()
                        require('diffview').open()
                    end,
                    'DiffViewOpen',
                },
                D = {
                    function()
                        require('diffview').close()
                    end,
                    'DiffViewClose',
                },
            },
        })

        require('gitsigns').setup({
            signs = {
                add = {
                    hl = 'DevIconCsv',
                    text = Icons.git.gutterbar,
                    numhl = 'GitSignsAddNr',
                    linehl = 'GitSignsAddLn',
                },
                change = {
                    hl = 'DevIconAi',
                    text = Icons.git.gutterbar,
                    numhl = 'GitSignsChangeNr',
                    linehl = 'GitSignsChangeLn',
                },
                delete = {
                    hl = 'DevIconJava',
                    text = Icons.git.gutterbar,
                    numhl = 'GitSignsDeleteNr',
                    linehl = 'GitSignsDeleteLn',
                },
                topdelete = {
                    hl = 'DevIconPackageLockJson',
                    text = Icons.ui.arrowclosed4,
                    numhl = 'GitSignsDeleteNr',
                    linehl = 'GitSignsDeleteLn',
                },
                changedelete = {
                    hl = 'DevIconCs',
                    text = Icons.git.gutterbar,
                    numhl = 'GitSignsChangeNr',
                    linehl = 'GitSignsChangeLn',
                },
                untracked = {
                    hl = 'DevIconToml',
                    text = Icons.git.gutterbar_dashed,
                    numhl = 'GitSignsChangeNr',
                    linehl = 'GitSignsChangeLn',
                },
            },
            signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                interval = 1000,
                follow_files = true,
            },
            attach_to_untracked = true,
            current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'overlay':replaces your text... rude! | 'right_align': right align is so far over I can't read it
                delay = 10000,
                ignore_whitespace = true,
            },
            current_line_blame_formatter_opts = {
                relative_time = true,
            },
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000,
            show_deleted = false,
            preview_config = {
                -- Options passed to nvim_open_win
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1,
            },
            yadm = {
                enable = false,
            },
        })

        vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = '#553355' })
    end,
}
