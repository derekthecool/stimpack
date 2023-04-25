return {
    'mfussenegger/nvim-dap',
    lazy = true,
    dependencies = {
        'theHamsta/nvim-dap-virtual-text',
        'rcarriga/nvim-dap-ui',
        'nvim-telescope/telescope-dap.nvim',
        -- 'kndndrj/nvim-projector',
        -- { get_my_plugin_path('nvim-projector'), branch = 'master' },
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
        Mason.bin = OS.join_path( vim.fn.stdpath('data'), 'mason', 'bin' )
        Mason.packages = OS.join_path( vim.fn.stdpath('data'), 'mason', 'packages' )

        -- Source configuration files for each language
        require('stimpack.debugging.dap-csharp')
        require('stimpack.debugging.dap-c')
        require('stimpack.debugging.dap-powershell')
        require('stimpack.debugging.dap-bash')
        require('stimpack.debugging.dap-neovim-lua')
    end,
}
