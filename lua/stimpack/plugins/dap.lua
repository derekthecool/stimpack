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
            require('telescope').load_extension('dap')

            require('which-key').add({
                { '<leader>d', group = 'Debug' },
                { '<leader>do', '<cmd>lua require(\'dap\').step_over()<CR>', desc = 'Step over (≤)' },
                { '<leader>de', '<cmd>lua require(\'dapui\').eval()<CR>', desc = 'Eval variable under cursor' },
                { '<leader>dt', '<cmd>lua require(\'dapui\').toggle()<CR>', desc = 'Toggle dapui' },
                { '<leader>dd', [[:lua require"osv".launch({port = 8086})<CR>]], desc = 'Start neovim lua debugging' },
                { '<leader>di', '<cmd>lua require(\'dap\').step_into()<CR>', desc = 'Step into (≥)' },
                { '<leader>dO', '<cmd>lua require(\'dap\').step_out()<CR>', desc = 'Step out (µ)' },
                { '<leader>db', '<cmd>lua require(\'dap\').toggle_breakpoint()<CR>', desc = 'Toggle breakpoint (__)' },
                {
                    '<leader>dB',
                    '<cmd>lua require(\'dap\').set_breakpoint(vim.fn.input(\'Breakpoint condition: \'))<CR>',
                    desc = 'Conditional breakpoint (___)',
                },
                {
                    '<leader>dm',
                    '<cmd>lua require(\'dap\').set_breakpoint(nil , nil , vim.fn.input(\'Log point message: \'))<CR>',
                    desc = 'Logging breakpoint (____)',
                },
                { '<leader>dr', '<cmd>lua require(\'dap\').repl.open()<CR>', desc = 'Open repl' },
                { '<leader>dR', '<cmd>lua require(\'dap\').run_last()<CR>', desc = 'Run last' },
                { '<leader>dq', '<cmd>lua require(\'dap\').terminate()<CR>', desc = 'Exit debugging' },
                { '<leader>dl', '<cmd>sp ~/.cache/nvim/dap.log<CR>', desc = 'Open dap log' },
            })

            vim.keymap.set('n', '≤', '<cmd>lua require(\'dap\').step_over()<CR>')
            vim.keymap.set('n', '≥', '<cmd>lua require(\'dap\').step_into()<CR>')
            vim.keymap.set('n', 'µ', '<cmd>lua require(\'dap\').step_out()<CR>')
            vim.keymap.set('n', '__', '<cmd>lua require(\'dap\').toggle_breakpoint()<CR>')
            vim.keymap.set(
                'n',
                '___',
                '<cmd>lua require(\'dap\').set_breakpoint(vim.fn.input(\'Breakpoint condition: \'))<CR>'
            )
            vim.keymap.set(
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
        dependencies = {
            -- required:
            'MunifTanjim/nui.nvim',
            -- optional extensions:
            -- 'kndndrj/projector-neotest',
            -- dependencies of extensions:
            -- 'nvim-neotest/neotest',
        },
        enabled = true,
        keys = {
            '_',
        },
        config = function()
            require('projector').setup({

                loaders = {
                    require('projector.loaders').BuiltinLoader:new({
                        path = function()
                            return string.format('%s/projector.json', vim.fn.getcwd())
                        end,
                    }),
                    require('projector.loaders').DapLoader:new(),
                },
            })

            vim.keymap.set('n', '_', function()
                require('projector').continue()
            end, { silent = true, desc = 'Projector continue' })
        end,
    },
}
