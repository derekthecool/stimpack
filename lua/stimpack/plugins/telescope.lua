return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-telescope/telescope-file-browser.nvim',
        -- Telescope extensions
        'xiyaowong/telescope-emoji.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
    },
    event = 'UIEnter',
    config = function()
        local layout_config = 'vertical'

        require('telescope').setup({
            defaults = {
                layout_config = {
                    vertical = { width = 0.85 },
                },
                mappings = {
                    i = {
                        ['<esc>'] = require('telescope.actions').close,
                    },
                },
            },
            pickers = {
                find_files = {
                    layout_strategy = layout_config,
                    prompt_prefix = string.format('%s : ', Icons.documents.file2),
                },
                git_files = {
                    layout_strategy = layout_config,
                    prompt_prefix = string.format('%s : ', Icons.git.git),
                    show_untracked = true,
                    preview_title = string.format('%s  File Preview', Icons.plugins.telescope),
                },
                help_tags = {
                    layout_strategy = layout_config,
                    prompt_prefix = string.format('%s : ', Icons.miscellaneous.brain),
                    show_untracted = true,
                },
                buffers = {
                    layout_strategy = layout_config,
                    prompt_prefix = string.format('%s : ', Icons.ui.righthandpoint),
                    sort_mru = true,
                    sort_lastused = true,
                    ignore_current_buffer = true,
                },
                live_grep = {
                    prompt_prefix = string.format('%s : ', Icons.miscellaneous.tornado),
                    results_title = 'Found',
                    preview_title = 'Preview',
                    prompt_title = 'File Content Search',
                    disable_coordinates = true,
                    disable_devicons = true,
                    vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--multiline-dotall',
                        '--smart-case',
                    },
                },
            },
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown({}),
                },
            },
        })

        -- Extensions to load
        require('telescope').load_extension('emoji')
        -- require('telescope').load_extension('ui-select') -- TODO: decide if dressing.nvim meets my needs
        require('telescope').load_extension('file_browser')

        local function gitfiles_or_findfiles()
            local builtin = require('telescope.builtin')
            if Execute('git rev-parse --is-inside-work-tree').ret == 0 then
                return builtin.git_files()
            else
                return builtin.find_files()
            end
        end

        local map = require('stimpack.mapping-function')
        map('n', '<C-f>', gitfiles_or_findfiles)
        map(
            'n',
            '<C-b>',
            '<cmd>lua require (\'telescope.builtin\').buffers({sort_mru=true, sort_lastused=true, ignore_current_buffer=true})<CR>'
        )

        vim.keymap.set('n', '<leader>fv', function()
            require('telescope.builtin').git_files({ cwd = OS.nvim, prompt_title = 'Nvim config: git files' })
        end, { desc = 'Nvim config files' })

        vim.keymap.set('n', '<leader>fV', function()
            require('telescope.builtin').live_grep({ cwd = OS.nvim, prompt_title = 'Nvim config: grep files' })
        end, { desc = 'Nvim config grep files' })

        vim.keymap.set('n', '<leader>fp', function()
            require('telescope.builtin').find_files({ cwd = OS.plover, prompt_title = 'Plover config: git files' })
        end, { desc = 'Plover config files' })

        vim.keymap.set('n', '<leader>fP', function()
            require('telescope.builtin').live_grep({ cwd = OS.plover, prompt_title = 'Plover config: grep files' })
        end, { desc = 'Plover config grep files' })

        local which_key_mapper = require('stimpack.which-key-mapping')
        local builtins = require('telescope.builtin')
        which_key_mapper({
            f = {
                name = 'file', -- optional group name
                -- Undocumented command that replaces the vim command Telescope... I looked through the telescope source code to find this
                f = { require('telescope.command').load_command, 'Telescope' }, -- create a binding with label
                -- f = { "<cmd>Telescope<cr>", "Telescope" }, -- create a binding with label
                F = { builtins.find_files, 'Find Files' },
                G = { builtins.git_files, 'Git Files' },
                E = { '<cmd>Telescope emoji<CR>', 'Telescope extension: emoji' },
                b = { builtins.buffers, 'Local buffers' },
                g = { builtins.live_grep, 'Live grep' }, -- search locally with live grep (uses ripgrep in the background)
                s = { builtins.grep_string, 'Grep string under cursor' },
                h = { builtins.help_tags, 'Help Search' },
                H = { builtins.highlights, 'Highlights' },
                c = { builtins.command_history, 'Command history' },
                z = { builtins.current_buffer_fuzzy_find, 'Current buffer fuzzy find' },
                S = { builtins.git_status, 'Search git changed files' },
                t = {
                    function()
                        require('telescope').extensions.file_browser.file_browser({ hidden = true })
                    end,
                    'Telescope file browser',
                },
                m = { builtins.keymaps, 'List key maps' }, -- list keymaps
            },
            l = {
                name = 'LSP',
                -- A = { builtins.code_actions{}, "Telescope: code action" },
            },
        })
    end,
}
