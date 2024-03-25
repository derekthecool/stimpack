return {
    {
        'rcarriga/nvim-notify',
        -- lazy = true,
        config = function()
            vim.o.termguicolors = true -- Needed for better color display

            require('notify').setup({
                -- Minimum level to show
                level = 'info',

                fps = 15,

                time_formats = {
                    notification = '%T',
                    notification_history = '%FT%T',
                },

                -- Animation style (see below for details)
                stages = 'fade_in_slide_out',

                -- Function called when a new window is opened, use for changing win settings/config
                on_open = nil,

                -- Function called when a window is closed
                on_close = nil,

                -- Render function for notifications. See notify-render()
                render = 'default',

                -- Default timeout for notifications
                timeout = 3000,

                -- Max number of columns for messages
                max_width = nil,
                -- Max number of lines for a message
                max_height = nil,

                -- For stages that change opacity this is treated as the highlight behind the window
                -- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
                background_colour = 'Normal',
                background_colour = '#000000',

                -- Minimum width for notification windows
                minimum_width = 50,

                -- Icons for the different levels
                icons = {
                    ERROR = Icons.diagnostics.error1,
                    WARN = Icons.diagnostics.warning,
                    INFO = Icons.diagnostics.information,
                    DEBUG = Icons.debugging.bug,
                    TRACE = Icons.documents.write2,
                },

                top_down = false,
            })

            -- Set as default notify system
            vim.notify = require('notify')
        end,
    },

    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
        opts = {
            input = {
                -- Set to false to disable the vim.ui.input implementation
                enabled = true,

                -- Default prompt string
                default_prompt = 'Input:',

                -- Can be 'left', 'right', or 'center'
                prompt_align = 'left',

                -- When true, <Esc> will close the modal
                insert_only = false,

                -- When true, input will start in insert mode.
                start_in_insert = false,

                -- These are passed to nvim_open_win
                border = 'rounded',
                -- 'editor' and 'win' will default to being centered
                relative = 'cursor',

                -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                prefer_width = 40,
                width = nil,
                -- min_width and max_width can be a list of mixed types.
                -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
                max_width = { 140, 0.9 },
                min_width = { 20, 0.2 },

                buf_options = {},
                win_options = {
                    -- Window transparency (0-100)
                    winblend = 10,
                    -- Disable line wrapping
                    wrap = false,
                },

                -- Set to `false` to disable
                mappings = {
                    n = {
                        ['<Esc>'] = 'Close',
                        ['<CR>'] = 'Confirm',
                    },
                    i = {
                        ['<C-c>'] = 'Close',
                        ['<CR>'] = 'Confirm',
                        ['<Up>'] = 'HistoryPrev',
                        ['<Down>'] = 'HistoryNext',
                    },
                },

                override = function(conf)
                    -- This is the config that will be passed to nvim_open_win.
                    -- Change values here to customize the layout
                    return conf
                end,

                -- see :help dressing_get_config
                get_config = nil,
            },
            select = {
                -- Set to false to disable the vim.ui.select implementation
                enabled = true,

                -- Priority list of preferred vim.select implementations
                backend = { 'telescope', 'fzf_lua', 'fzf', 'builtin', 'nui' },

                -- Trim trailing `:` from prompt
                trim_prompt = true,

                -- Options for telescope selector
                -- These are passed into the telescope picker directly. Can be used like:
                -- telescope = require('telescope.themes').get_ivy({...})
                telescope = nil,

                -- Options for fzf selector
                fzf = {
                    window = {
                        width = 0.5,
                        height = 0.4,
                    },
                },

                -- Options for fzf_lua selector
                fzf_lua = {
                    winopts = {
                        width = 0.5,
                        height = 0.4,
                    },
                },

                -- Options for nui Menu
                nui = {
                    position = '50%',
                    size = nil,
                    relative = 'editor',
                    border = {
                        style = 'rounded',
                    },
                    buf_options = {
                        swapfile = false,
                        filetype = 'DressingSelect',
                    },
                    win_options = {
                        winblend = 10,
                    },
                    max_width = 80,
                    max_height = 40,
                    min_width = 40,
                    min_height = 10,
                },

                -- Options for built-in selector
                builtin = {
                    -- These are passed to nvim_open_win
                    border = 'rounded',
                    -- 'editor' and 'win' will default to being centered
                    relative = 'editor',

                    buf_options = {},
                    win_options = {
                        -- Window transparency (0-100)
                        winblend = 10,
                    },

                    -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                    -- the min_ and max_ options can be a list of mixed types.
                    -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
                    width = nil,
                    max_width = { 140, 0.8 },
                    min_width = { 40, 0.2 },
                    height = nil,
                    max_height = 0.9,
                    min_height = { 10, 0.2 },

                    -- Set to `false` to disable
                    mappings = {
                        ['<Esc>'] = 'Close',
                        ['<C-c>'] = 'Close',
                        ['<CR>'] = 'Confirm',
                    },

                    override = function(conf)
                        -- This is the config that will be passed to nvim_open_win.
                        -- Change values here to customize the layout
                        return conf
                    end,
                },

                -- Used to override format_item. See :help dressing-format
                format_item_override = {},

                -- see :help dressing_get_config
                get_config = nil,
            },
        },
    },

    {
        'folke/noice.nvim',
        enabled = false,
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
        opts = {
            {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true,
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true,         -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false,       -- add a border to hover docs and signature help
            },
        },
    },
}
