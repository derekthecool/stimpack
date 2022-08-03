-- vim.cmd [[
-- let g:asyncrun_open = 6
-- let g:asynctasks_term_pos = 'bottom'
-- let g:asynctasks_extra_config = ['~/.config/nvim/other/tasks.ini']
-- ]]

vim.g.asyncrun_open = 6
vim.g.asynctasks_term_pos = 'bottom'
vim.g.asynctasks_extra_config = { '~/.config/nvim/other/tasks.ini' }

local which_key_mapper = require('stimpack.which-key-mapping')
which_key_mapper({
  u = {
    name = "Async task runner", -- optional group name
    i = { "<cmd>AsyncTask test<cr>", "LOCAL: test" },
    u = { "<cmd>AsyncTask run<cr>", "LOCAL: run" },
    [";"] = { "<cmd>AsyncTask build<cr>", "LOCAL: build" },
    U = { "<cmd>AsyncTask file-run<cr>", "GLOBAL: run" },
    e = { "<cmd>AsyncTaskEdit<cr>", "LOCAL: edit tasks" },
    E = { "<cmd>AsyncTaskEdit!<cr>", "GLOBAL: edit tasks" },
    m = { "<cmd>AsyncTaskMacro<cr>", "View macros to help build config" },
  }
})
