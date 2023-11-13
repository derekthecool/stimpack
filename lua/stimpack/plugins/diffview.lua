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
return {
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
}
