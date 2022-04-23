local map = require('user.mapping-function')

-- Use mappings from nvim projector for continue
-- map("n" , "<leader>dd" , "<cmd>lua require('dap').continue()<CR>")
-- map("n" , "_"          , "<cmd>lua require('dap').continue()<CR>")

map("n" , "<leader>do" , "<cmd>lua require('dap').step_over()<CR>")
map("n" , "≤"          , "<cmd>lua require('dap').step_over()<CR>")

map("n" , "<leader>di" , "<cmd>lua require('dap').step_into()<CR>")
map("n" , "≥"          , "<cmd>lua require('dap').step_into()<CR>")

map("n" , "<leader>dO" , "<cmd>lua require('dap').step_out()<CR>")
map("n" , "µ"          , "<cmd>lua require('dap').step_out()<CR>")

map("n" , "<leader>db" , "<cmd>lua require('dap').toggle_breakpoint()<CR>")
map("n" , "__"         , "<cmd>lua require('dap').toggle_breakpoint()<CR>")

map("n" , "<leader>dB" , "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map("n" , "___"        , "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")

map("n" , "<leader>dm" , "<cmd>lua require('dap').set_breakpoint(nil , nil , vim.fn.input('Log point message: '))<CR>")
map("n" , "____"       , "<cmd>lua require('dap').set_breakpoint(nil , nil , vim.fn.input('Log point message: '))<CR>")

map("n" , "<leader>dr" , "<cmd>lua require('dap').repl.open()<CR>")
map("n" , "<leader>dR" , "<cmd>lua require('dap').run_last()<CR>")

map("n" , "<leader>dl" , "<cmd>sp ~/.cache/nvim/dap.log<CR>")
-- lua require('dap').set_log_level('TRACE')

        --[[ Available log levels:
          TRACE
          DEBUG
          INFO
          WARN
          ERROR ]]

local dap = require('dap')


vim.fn.sign_define('DapBreakpoint'          , {text='ﲀ'  , texthl='Title'      , linehl='' , numhl=''})
vim.fn.sign_define('DapStopped'             , {text=''  , texthl='ModeMsg'    , linehl='' , numhl=''})
vim.fn.sign_define('DapBreakpointCondition' , {text='ﱦ'  , texthl='FoldColumn' , linehl='' , numhl=''})
vim.fn.sign_define('DapLogPoint'            , {text=''  , texthl=''           , linehl='' , numhl=''})
vim.fn.sign_define('DapBreakpointRejected'  , {text='🛑' , texthl=''           , linehl='' , numhl=''})

-- dap.adapters.csharp = {
--     type = 'executable';
--     command = os.getenv('HOME') .. '/scoop/apps/netcoredbg/2.0.0-895/netcoredbg.exe';
--     args = { 'args for my app'};
-- }

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/derek/debug-adapters/extension/debugAdapters/bin/OpenDebugAD7',
}
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = "${workspaceFolder}/debug/test/FA_test",
    -- program = function()
    --   return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    -- end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {"--command","FAgenerateLWT","ABCDEF"},
  },
}
dap.configurations.c = dap.configurations.cpp
