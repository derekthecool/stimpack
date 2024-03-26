-- My favorite method to use git commands is actually just plain terminal
-- This was demonstrated in a remarkably simple way by Paul Fioravanti, thanks Paul!
-- You can't beat the speed of steno'd git command-line

local fugitive_git_level = 1
local neogit_git_level = 3

return {

    --[[
    This plugin is quite powerful. Here is my list of favorite commands


    -- The main command: easy mapping for toggle is my command <leader>gd
    :DiffviewOpen
    :DiffviewOpen HEAD~2
    :DiffviewOpen HEAD~4..HEAD~2
    :DiffviewOpen d4a7b0d
    :DiffviewOpen d4a7b0d^!
    :DiffviewOpen d4a7b0d..519b30e
    :DiffviewOpen origin/main...HEAD
    :DiffviewOpen HEAD~2 -- lua/diffview plugin
    :DiffviewOpen d4a7b0d -uno

    :DiffviewFileHistory
    :DiffviewFileHistory %
    :DiffviewFileHistory path/to/some/file.txt
    :DiffviewFileHistory path/to/some/directory
    :DiffviewFileHistory multiple/paths foo/bar baz/qux
    :DiffviewFileHistory --base=HEAD~4
    :DiffviewFileHistory --base=LOCAL
    :DiffviewFileHistory --range=origin..HEAD
    :DiffviewFileHistory --range=feat/some-branch
    :'<,'>DiffviewFileHistory

    See :h diffview-maps for other mappings available

    ]]
    {
        'sindrets/diffview.nvim',
        keys = {
            '<leader>gd',
        },
        cmd = {
            'DiffviewOpen',
            'DiffviewFileHistory',
        },
        config = function()
            require('diffview').setup({
                diff_binaries = false, -- Show diffs for binaries
                use_icons = true, -- Requires nvim-web-devicons
                icons = {
                    -- Only applies when use_icons is true.
                    folder_closed = Icons.documents.closeddirectory1,
                    folder_open = Icons.documents.opendirectory1,
                },
                signs = {
                    fold_closed = Icons.ui.arrowclosed1,
                    fold_open = Icons.ui.arrowopen1,
                },
                file_panel = {
                    listing_style = 'tree', -- One of 'list' or 'tree'
                    tree_options = {
                        -- Only applies when listing_style is 'tree'
                        flatten_dirs = true, -- Flatten dirs that only contain one single dir
                        folder_statuses = 'only_folded', -- One of 'never', 'only_folded' or 'always'.
                    },
                },
                file_history_panel = {
                    log_options = {
                        -- See ':h diffview-config-log_options'
                        git = {
                            single_file = {
                                diff_merges = 'combined',
                            },
                            multi_file = {
                                diff_merges = 'first-parent',
                            },
                        },
                    },
                },
                default_args = {
                    -- Default args prepended to the arg-list for the listed commands
                    DiffviewOpen = {},
                    DiffviewFileHistory = {},
                },
            })

            require('stimpack.which-key-mapping')({
                g = {
                    d = {
                        function()
                            -- Set the initial value for the global or keep the existing state
                            if DiffViewToggleState == nil then
                                DiffViewToggleState = true
                            end

                            if DiffViewToggleState then
                                require('diffview').open()
                            else
                                require('diffview').close()
                            end

                            -- Toggle the state
                            DiffViewToggleState = not DiffViewToggleState
                        end,
                        'DiffViewToggle',
                    },
                },
            })
        end,
    },

    {
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
                    q = {
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
                    S = {
                        function()
                            require('gitsigns').stage_buffer()
                        end,
                        'Stage Buffer',
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
    },

    {
        'tpope/vim-fugitive',
        keys = {
            {
                -- Set as third git plugin
                '<leader>g' .. fugitive_git_level,
                '<cmd>G<CR>',
                desc = 'Vim fugitive',
            },
        },
        config = function()
            vim.api.nvim_create_autocmd('BufEnter', {
                pattern = { 'fugitive:*' },
                callback = function()
                    -- Mappings to use fugitive to push and pull
                    vim.keymap.set('n', '<leader>gP', ':G push<CR>')
                    vim.keymap.set('n', '<leader>gp', ':G pull<CR>')

                    local fugitive_user_group = vim.api.nvim_create_augroup('fugitive_user_group', { clear = true })
                    vim.api.nvim_create_autocmd('BufNew', {
                        pattern = { '*COMMIT_EDITMSG' },
                        callback = function()
                            V('in commit')
                            vim.api.nvim_feedkeys('i', 'n', nil)
                        end,
                        group = fugitive_user_group,
                    })
                end,
            })
        end,
    },

    {
        'TimUntersberger/neogit',
        dependencies = {
            'sindrets/diffview.nvim',
        },
        keys = {
            {
                '<leader>g' .. neogit_git_level,
                function()
                    require('neogit').open()
                end,
                desc = 'Neogit',
            },
        },
        opts = {
            disable_signs = false,
            disable_hint = false,
            disable_context_highlighting = false,
            disable_commit_confirmation = true,
            -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
            -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
            auto_refresh = true,
            disable_builtin_notifications = false,
            use_magit_keybindings = false,
            commit_popup = {
                kind = 'floating',
            },
            -- Change the default way of opening neogit
            kind = 'tab',
            -- customize displayed signs
            signs = {
                -- { CLOSED, OPENED }
                section = { Icons.ui.arrowclosed3, Icons.ui.arrowopen3 },
                item = { Icons.ui.arrowclosed3, Icons.ui.arrowopen3 },
                hunk = { '', '' },
            },
            integrations = {
                diffview = true,
            },
            -- Setting any section to `false` will make the section not render at all
            sections = {
                untracked = {
                    folded = false,
                },
                unstaged = {
                    folded = false,
                },
                staged = {
                    folded = false,
                },
                stashes = {
                    folded = true,
                },
                unpulled = {
                    folded = true,
                },
                unmerged = {
                    folded = false,
                },
                recent = {
                    folded = true,
                },
            },
            -- override/add mappings
            mappings = {
                -- modify status buffer mappings
                status = {
                    -- Adds a mapping with "B" as key that does the "BranchPopup" command
                    ['B'] = 'BranchPopup',
                    -- Removes the default mapping of "s"
                    -- ["s"] = "",
                },
            },
        },
    },
}
