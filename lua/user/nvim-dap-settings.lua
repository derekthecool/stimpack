local map = require('user.mapping-function')

map("n" , "<leader>dd" , "<cmd>lua require('dap').continue()<CR>")
map("n" , "<leader>do" , "<cmd>lua require('dap').step_over()<CR>")
map("n" , "<leader>di" , "<cmd>lua require('dap').step_into()<CR>")
map("n" , "<leader>dO" , "<cmd>lua require('dap').step_out()<CR>")
map("n" , "<leader>db" , "<cmd>lua require('dap').toggle_breakpoint()<CR>")
map("n" , "<leader>dr" , "<cmd>lua require('dap').repl.open()<CR>")
map("n" , "<leader>dR" , "<cmd>lua require('dap').run_last()<CR>")

local dap = require('dap')
dap.adapters.csharp = {
    type = 'executable';
    command = os.getenv('HOME') .. '/scoop/apps/netcoredbg/2.0.0-895/netcoredbg.exe';
    args = { 'args for my app'};
}

-- Mappings to look at later
-- map('n' , '' , 'lua require'dap'<cmd>.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>')
-- map('n' , '' , 'lua require'dap'<cmd>.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>')
