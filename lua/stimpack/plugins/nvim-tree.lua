-- Autocommand to close when last window
vim.api.nvim_create_autocmd('BufEnter', {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match('NvimTree_') ~= nil then
            vim.cmd('quit')
        end
    end,
})

return {
    'kyazdani42/nvim-tree.lua',
    lazy = false,
    keys = { { '<leader>fe', '<cmd>NvimTreeToggle<cr>', desc = 'NvimTreeToggle' } },
    opts = {
        auto_reload_on_write = true,
        disable_netrw = false,
        hijack_cursor = false,
        hijack_netrw = true,
        hijack_unnamed_buffer_when_opening = false,
        ignore_buffer_on_setup = false,
        open_on_tab = false,
        sort_by = 'name',
        update_cwd = false,
        view = {
            width = 50,
            side = 'left',
            preserve_window_proportions = false,
            number = false,
            relativenumber = false,
            signcolumn = 'yes',
            mappings = {
                custom_only = false,
                list = {
                    { key = { 'l', '<CR>', 'o' }, action = 'open_file' },
                    { key = 'h', action = 'close_node' },
                    { key = 'v', action = 'vsplit' },
                },
            },
        },
        hijack_directories = {
            enable = true,
            auto_open = true,
        },
        update_focused_file = {
            enable = true,
            update_cwd = false,
            ignore_list = {},
        },
        ignore_ft_on_setup = {
            'startify',
            'alpha',
        },
        system_open = {
            cmd = nil,
            args = {},
        },
        diagnostics = {
            enable = false,
            show_on_dirs = false,
            icons = {
                hint = Icons.diagnostics.hint1,
                info = Icons.diagnostics.information,
                warning = Icons.diagnostics.warning,
                error = Icons.diagnostics.error1,
            },
        },
        renderer = {
            add_trailing = false,
            group_empty = false,
            highlight_git = false,
            full_name = false,
            highlight_opened_files = 'none',
            root_folder_modifier = ':~',
            indent_width = 2,
            indent_markers = {
                enable = false,
                inline_arrows = true,
                icons = {
                    corner = Icons.ui.borders.corner,
                    edge = Icons.ui.borders.edge,
                    item = Icons.ui.borders.item,
                    bottom = Icons.ui.borders.bottom,
                    none = Icons.ui.borders.none,
                },
            },
            icons = {
                webdev_colors = true,
                git_placement = 'before',
                padding = ' ',
                symlink_arrow = ' ' .. Icons.ui.arrowclosed3 .. ' ',
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true,
                },
                glyphs = {
                    default = Icons.documents.file3,
                    symlink = Icons.documents.linkedfile,
                    bookmark = Icons.miscellaneous.target,
                    folder = {
                        arrow_closed = Icons.ui.arrowclosed1,
                        arrow_open = Icons.ui.arrowopen1,
                        default = Icons.documents.flatdirectory,
                        open = Icons.opendirectory3,
                        empty = Icons.documents.emptydirectory,
                        empty_open = Icons.documents.opendirectory2,
                        symlink = Icons.documents.symlinkdirectory,
                        symlink_open = Icons.documents.symlinkdirectory,
                    },
                    git = {
                        unstaged = Icons.git.unstaged,
                        staged = Icons.git.staged,
                        unmerged = Icons.git.unmerged,
                        renamed = Icons.git.renamed,
                        untracked = Icons.git.untracked,
                        deleted = Icons.git.deleted,
                        ignored = Icons.git.ignored,
                    },
                },
            },
            special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md' },
            symlink_destination = true,
        },
        filters = {
            dotfiles = false,
            custom = {},
            exclude = {},
        },
        git = {
            enable = true,
            ignore = false,
            timeout = 400,
        },
        actions = {
            use_system_clipboard = true,
            change_dir = {
                enable = true,
                global = false,
            },
            open_file = {
                quit_on_open = true,
                resize_window = false,
                window_picker = {
                    enable = true,
                    chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
                    exclude = {
                        filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
                        buftype = { 'nofile', 'terminal', 'help' },
                    },
                },
            },
        },
        trash = {
            cmd = 'trash',
            require_confirm = true,
        },
        log = {
            enable = false,
            truncate = false,
            types = {
                all = false,
                config = false,
                copy_paste = false,
                diagnostics = false,
                git = false,
                profile = false,
            },
        },
    },
}
