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
                    '<cmd>lua require \'gitsigns\'.next_hunk()<cr>',
                    'Next Hunk',
                },
                k = {
                    '<cmd>lua require \'gitsigns\'.prev_hunk()<cr>',
                    'Prev Hunk',
                },
                l = {
                    '<cmd>lua require \'gitsigns\'.blame_line()<cr>',
                    'Blame',
                },
                p = {
                    '<cmd>lua require \'gitsigns\'.preview_hunk()<cr>',
                    'Preview Hunk',
                },
                r = {
                    '<cmd>lua require \'gitsigns\'.reset_hunk()<cr>',
                    'Reset Hunk',
                },
                R = {
                    '<cmd>lua require \'gitsigns\'.reset_buffer()<cr>',
                    'Reset Buffer',
                },
                s = {
                    '<cmd>lua require \'gitsigns\'.stage_hunk()<cr>',
                    'Stage Hunk',
                },
                u = {
                    '<cmd>lua require \'gitsigns\'.undo_stage_hunk()<cr>',
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
                    '<cmd>lua require(\'diffview\').open()<cr>',
                    'DiffViewOpen',
                },
                D = {
                    '<cmd>lua require(\'diffview\').close()<cr>',
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
                    hl = 'GitSignsDelete',
                    text = Icons.ui.arrowclosed4,
                    numhl = 'GitSignsDeleteNr',
                    linehl = 'GitSignsDeleteLn',
                },
                changedelete = {
                    hl = 'GitSignsChange',
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

        vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', {  fg = '#553355' })
    end,
}
