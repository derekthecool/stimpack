return {
    'TimUntersberger/neogit',
    dependencies = {
        'sindrets/diffview.nvim',
    },
    enabled = false,
    keys = {
        {
            '<leader>gg',
            '<cmd>lua require(\'neogit\').open()<cr>',
            desc = 'Neogit',
        },
    },
    config = {
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
            kind = 'split',
        },
        -- Change the default way of opening neogit
        kind = 'split',
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
}