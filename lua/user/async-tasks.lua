local which_key_mapper = require('user.which-key-mapping')
which_key_mapper({
u = {
  name = "Async task runner", -- optional group name
  i = { "<cmd>AsyncTask test<cr>", "LOCAL: test" },
  u = { "<cmd>AsyncTask run<cr>", "LOCAL: run" },
  U = { "<cmd>AsyncTask file-run<cr>", "GLOBAL: run" },
  e = { "<cmd>AsyncTaskEdit<cr>", "LOCAL: edit tasks" },
  E = { "<cmd>AsyncTaskEdit!<cr>", "GLOBAL: edit tasks" },
  m = { "<cmd>AsyncTaskMacro<cr>", "View macros to help build config" },
}
})

