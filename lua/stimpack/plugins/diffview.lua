return {
    'sindrets/diffview.nvim',
     opts = {
        diff_binaries = false, -- Show diffs for binaries
        enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
        use_icons = true, -- Requires nvim-web-devicons
        icons = { -- Only applies when use_icons is true.
            folder_closed = Icons.documents.closeddirectory1,
            folder_open = Icons.documents.opendirectory1,
        },
        signs = {
            fold_closed = Icons.ui.arrowclosed1,
            fold_open = Icons.ui.arrowopen1,
        },
        file_panel = {
            listing_style = 'tree', -- One of 'list' or 'tree'
            tree_options = { -- Only applies when listing_style is 'tree'
                flatten_dirs = true, -- Flatten dirs that only contain one single dir
                folder_statuses = 'only_folded', -- One of 'never', 'only_folded' or 'always'.
            },
        },
        file_history_panel = {
            log_options = { -- See ':h diffview-config-log_options'
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
        default_args = { -- Default args prepended to the arg-list for the listed commands
            DiffviewOpen = {},
            DiffviewFileHistory = {},
        },
    }
}
