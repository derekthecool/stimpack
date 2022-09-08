local map = require('stimpack.mapping-function')

require('telescope').load_extension('dap')

local which_key_mapper = require('stimpack.which-key-mapping')
which_key_mapper({
    d = {
        name = 'Debug',
        o = { '<cmd>lua require(\'dap\').step_over()<CR>', 'Step over (≤)' },
        e = { '<cmd>lua require(\'dapui\').eval()<CR>', 'Eval variable under cursor' },
        -- E = { '<cmd>lua require(\'dapui\').float_element()<CR>', 'Open an item in a floating view' },
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
map('n', '____', '<cmd>lua require(\'dap\').set_breakpoint(nil , nil , vim.fn.input(\'Log point message: \'))<CR>')

-- lua require('dap').set_log_level('TRACE')

--[[ Available log levels:
          TRACE
          DEBUG
          INFO
          WARN
          ERROR ]]

local dap = require('dap')

vim.fn.sign_define('DapBreakpoint', { text = 'ﲀ', texthl = 'Title', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'ModeMsg', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = 'ﱦ', texthl = 'FoldColumn', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '🛑', texthl = '', linehl = '', numhl = '' })

-- dap.adapters.csharp = {
--     type = 'executable';
--     command = os.getenv('HOME') .. '/scoop/apps/netcoredbg/2.0.0-895/netcoredbg.exe';
--     args = { 'args for my app'};
-- }

local mason_bin = vim.fn.stdpath('data') .. '/mason/bin/'
local mason_dap_packages = vim.fn.stdpath('data') .. '/mason/packages/'

dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = mason_bin .. 'OpenDebugAD7',
}
-- Set the C++ settings to work for C as well
dap.configurations.c = dap.configurations.cpp

-- Csharp settings
dap.adapters.coreclr = {
    type = 'executable',
    command = mason_bin .. 'netcoredbg.cmd',
    -- command = '/home/derek/debug-adapters/netcoredbg/netcoredbg/netcoredbg',
    args = { '--interpreter=vscode' },
}

dap.configurations.cs = {
    {
        type = 'coreclr',
        name = 'netcoredbg',
        request = 'launch',
        -- program = '${workspaceFolder}/bin/Debug/net6.0/test.dll',
        program = '${workspaceFolder}\\bin\\Debug\\net6.0\\test.dll',
        -- program = "${workspaceFolder}\\fm-cli\\bin\\Debug\\net6.0\\fm-cli.dll",
        cwd = '${workspaceFolder}',
    },
}
