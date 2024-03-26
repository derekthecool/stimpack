return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'theHamsta/nvim-dap-virtual-text',
            'rcarriga/nvim-dap-ui',
            'nvim-telescope/telescope-dap.nvim',
            'kndndrj/nvim-projector',
        },
        -- TODO: 8/7/2023 3:13:27 PM, add all other keymappings here to help speed startup time
        keys = {
            '<leader>d',
        },
        config = function()
            local map = require('stimpack.mapping-function')

            require('telescope').load_extension('dap')

            local which_key_mapper = require('stimpack.which-key-mapping')
            which_key_mapper({
                d = {
                    name = 'Debug',
                    o = { '<cmd>lua require(\'dap\').step_over()<CR>', 'Step over (≤)' },
                    e = { '<cmd>lua require(\'dapui\').eval()<CR>', 'Eval variable under cursor' },
                    t = { '<cmd>lua require(\'dapui\').toggle()<CR>', 'Toggle dapui' },
                    -- E = { '<cmd>lua require(\'dapui\').float_element()<CR>', 'Open an item in a floating view' },
                    d = { [[:lua require"osv".launch({port = 8086})<CR>]], 'Start neovim lua debugging' },
                    i = { '<cmd>lua require(\'dap\').step_into()<CR>', 'Step into (≥)' },
                    O = { '<cmd>lua require(\'dap\').step_out()<CR>', 'Step out (µ)' },
                    b = { '<cmd>lua require(\'dap\').toggle_breakpoint()<CR>', 'Toggle breakpoint (__)' },
                    B = {
                        '<cmd>lua require(\'dap\').set_breakpoint(vim.fn.input(\'Breakpoint condition: \'))<CR>',
                        'Conditional breakpoint (___)',
                    },
                    m = {
                        '<cmd>lua require(\'dap\').set_breakpoint(nil , nil , vim.fn.input(\'Log point message: \'))<CR>',
                        'Logging breakpoint (____)',
                    },
                    r = { '<cmd>lua require(\'dap\').repl.open()<CR>', 'Open repl' },
                    R = { '<cmd>lua require(\'dap\').run_last()<CR>', 'Run last' },
                    q = { '<cmd>lua require(\'dap\').terminate()<CR>', 'Exit debugging' },
                    l = { '<cmd>sp ~/.cache/nvim/dap.log<CR>', 'Open dap log' },
                },
            })

            map('n', '≤', '<cmd>lua require(\'dap\').step_over()<CR>')
            map('n', '≥', '<cmd>lua require(\'dap\').step_into()<CR>')
            map('n', 'µ', '<cmd>lua require(\'dap\').step_out()<CR>')
            map('n', '__', '<cmd>lua require(\'dap\').toggle_breakpoint()<CR>')
            map('n', '___', '<cmd>lua require(\'dap\').set_breakpoint(vim.fn.input(\'Breakpoint condition: \'))<CR>')
            map(
                'n',
                '____',
                '<cmd>lua require(\'dap\').set_breakpoint(nil , nil , vim.fn.input(\'Log point message: \'))<CR>'
            )

            require('dap').set_log_level('TRACE') -- TRACE, DEBUG, INFO, WARN, ERROR

            vim.fn.sign_define('DapBreakpoint', { text = Icons.ui.sign, texthl = 'Title', linehl = '', numhl = '' })
            vim.fn.sign_define(
                'DapStopped',
                { text = Icons.miscellaneous.fish, texthl = 'ModeMsg', linehl = '', numhl = '' }
            )
            vim.fn.sign_define(
                'DapBreakpointCondition',
                { text = Icons.miscellaneous.react, texthl = 'FoldColumn', linehl = '', numhl = '' }
            )
            vim.fn.sign_define('DapLogPoint', { text = Icons.letters.w, texthl = '', linehl = '', numhl = '' })
            vim.fn.sign_define('DapBreakpointRejected', { text = Icons.ui.stop, texthl = '', linehl = '', numhl = '' })

            -- Set global variables to help with path locations
            Mason = {}
            Mason.bin = OS.join_path(vim.fn.stdpath('data'), 'mason', 'bin')
            Mason.packages = OS.join_path(vim.fn.stdpath('data'), 'mason', 'packages')

            -- Source configuration files for each language
            require('stimpack.debugging.dap-csharp')
            require('stimpack.debugging.dap-c')
            require('stimpack.debugging.dap-powershell')
            require('stimpack.debugging.dap-bash')
            require('stimpack.debugging.dap-neovim-lua')
        end,
    },

    {
        'theHamsta/nvim-dap-virtual-text',
        lazy = true,
        opts = {
            enabled = true, -- enable this plugin (the default)
            enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
            highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
            highlight_new_as_changed = true, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
            show_stop_reason = true, -- show stop reason when stopped for exceptions
            commented = true, -- prefix virtual text with comment string
            -- experimental features:
            virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
            all_frames = true, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.

            -- 2022-04-16 virtual lines did not work for me with can clangd
            virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
            virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
            -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
        },
    },

    {
        'rcarriga/nvim-dap-ui',
        lazy = true,
        config = function()
            require('dapui').setup({
                icons = { expanded = Icons.ui.arrowclosed2, collapsed = Icons.ui.arrowopen2 },
                mappings = {
                    -- Use a table to apply multiple mappings
                    expand = { '<CR>', '<2-LeftMouse>' },
                    open = 'o',
                    remove = 'd',
                    edit = 'e',
                    repl = 'r',
                    toggle = 't',
                },
                -- Expand lines larger than the window
                -- Requires >= 0.7
                expand_lines = vim.fn.has('nvim-0.7'),
                -- Layouts define sections of the screen to place windows.
                -- The position can be "left", "right", "top" or "bottom".
                -- The size specifies the height/width depending on position.
                -- Elements are the elements shown in the layout (in order).
                -- Layouts are opened in order so that earlier layouts take priority in window sizing.
                layouts = {
                    {
                        elements = {
                            -- Elements can be strings or table with id and size keys.
                            { id = 'scopes', size = 0.25 },
                            'breakpoints',
                            'stacks',
                            'watches',
                        },
                        size = 40,
                        position = 'left',
                    },
                    {
                        elements = {
                            'console',
                        },
                        size = 15,
                        position = 'bottom',
                    },
                },
                floating = {
                    max_height = nil, -- These can be integers or a float between 0 and 1.
                    max_width = nil, -- Floats will be treated as percentage of your screen.
                    border = 'single', -- Border style. Can be "single", "double" or "rounded"
                    mappings = {
                        close = { 'q', '<Esc>' },
                    },
                },
                windows = { indent = 1 },
                render = {
                    max_type_length = nil, -- Can be integer or nil.
                },
            })

            local dap, dapui = require('dap'), require('dapui')
            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close()
            end
        end,
    },

    {
        'kndndrj/nvim-projector',
        enabled = false,
        keys = {
            '_',
        },
        config = function()
            require('projector').setup({
                loaders = {
                    {
                        module = 'builtin',
                        options = {
                            -- path = vim.fn.getcwd() .. OS.separator .. 'projector.json',
                            path = OS.join_path(vim.fn.getcwd(), 'projector.json'),
                            configs = nil,
                        },
                    },
                },
                display_format = function(_, scope, group, modes, name)
                    return scope .. '  ' .. group .. '  ' .. modes .. '  ' .. name
                end,
                automatic_reload = true,
                -- local output_config = require("projector").config.outputs[mode]
                outputs = {
                    task = {
                        module = 'builtin',
                        options = nil,
                    },
                    debug = {
                        module = 'dap',
                        options = nil,
                    },
                    database = {
                        module = 'dadbod',
                        options = nil,
                    },
                },
                -- Reload configurations automatically before displaying task selector
                -- map of icons
                -- NOTE: "groups" use nvim-web-devicons if available
                icons = {
                    enable = true,
                    scopes = {
                        global = '',
                        project = '',
                    },
                    groups = {},
                    loaders = {},
                    modes = {
                        task = '',
                        debug = '',
                        database = '',
                    },
                },
            })

            vim.keymap.set('n', '_', function()
                require('projector').continue()
            end, { silent = true, desc = 'Projector continue' })
        end,
    },
}
