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
    'nvim-tree/nvim-tree.lua',
    keys = { { '<leader>fe', '<cmd>NvimTreeToggle<cr>', desc = 'NvimTreeToggle' } },
    config = function()
        local function on_attach(bufnr)
            local api = require('nvim-tree.api')

            local function opts(desc)
                return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- Default mappings. Feel free to modify or remove as you wish.
            --
            -- BEGIN_DEFAULT_ON_ATTACH
            vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
            vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
            vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
            vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
            vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
            vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
            vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
            vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
            vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
            vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
            vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
            vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
            vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
            vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
            vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
            vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
            vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
            vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
            vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
            vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
            vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
            vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
            vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
            vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
            vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
            vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
            vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
            vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
            vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
            vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
            vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
            vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
            vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
            vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
            vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
            vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
            vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
            vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
            vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
            vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
            vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
            vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
            vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
            vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
            vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
            vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
            vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
            vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
            vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
            vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
            vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
            vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
            -- END_DEFAULT_ON_ATTACH

            -- Mappings removed via:
            --   remove_keymaps
            --   OR
            --   view.mappings.list..action = ""
            --
            -- The dummy set before del is done for safety, in case a default mapping does not exist.
            --
            -- You might tidy things by removing these along with their default mapping.
            vim.keymap.set('n', 'O', '', { buffer = bufnr })
            vim.keymap.del('n', 'O', { buffer = bufnr })
            vim.keymap.set('n', '<2-RightMouse>', '', { buffer = bufnr })
            vim.keymap.del('n', '<2-RightMouse>', { buffer = bufnr })
            vim.keymap.set('n', 'D', '', { buffer = bufnr })
            vim.keymap.del('n', 'D', { buffer = bufnr })
            vim.keymap.set('n', 'E', '', { buffer = bufnr })
            vim.keymap.del('n', 'E', { buffer = bufnr })

            -- Mappings migrated from view.mappings.list
            -- list = {
            --     { key = { 'l', '<CR>', 'o' }, action = 'open_file' },
            --     { key = 'h', action = 'close_node' },
            --     { key = 'v', action = 'vsplit' },
            -- },
            --
            -- You will need to insert "your code goes here" for any mappings with a custom action_cb
            vim.keymap.set('n', 'A', api.tree.expand_all, opts('Expand All'))
            vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
            vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
            vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
            vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('CD'))
            vim.keymap.set('n', 'P', function()
                local node = api.tree.get_node_under_cursor()
                print(node.absolute_path)
            end, opts('Print Node Path'))

            vim.keymap.set('n', 'Z', api.node.run.system, opts('Run System'))
        end

        local opts = {
            auto_reload_on_write = true,
            disable_netrw = false,
            hijack_cursor = false,
            hijack_netrw = true,
            hijack_unnamed_buffer_when_opening = false,
            open_on_tab = false,
            sort_by = 'name',
            update_cwd = false,
            on_attach = on_attach,
            view = {
                width = 50,
                side = 'left',
                preserve_window_proportions = false,
                number = false,
                relativenumber = false,
                signcolumn = 'yes',
                mappings = {
                    custom_only = false,
                    -- list = {
                    --     { key = { 'l', '<CR>', 'o' }, action = 'open_file' },
                    --     { key = 'h', action = 'close_node' },
                    --     { key = 'v', action = 'vsplit' },
                    -- },
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
                custom = {
                    -- I was getting nasty errors from creating and deleting symlinked files, ignore them
                    [[test/OtaCommandOutput/*.proto]],
                    [[test/OtaCommandOutput/*.options]],
                },
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
                        chars = '1234567890',
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
        }

        require('nvim-tree').setup(opts)
    end,
}
