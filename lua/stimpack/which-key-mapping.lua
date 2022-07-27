--[[
This function is meant to make it very easy to setup which key mappings in
each file where they are needed. This will help keep the config closer to
where it is needed rather than one huge which key mapping file.

This function is meant to make it easy to set mappings in other files
To use this mapping function follow these steps:

1. Require this file as a local variable
local which_key_mapper = require('stimpack.which-key-mapping')

2. Set the mapping
which_key_mapper({
  f = {
    f = { "<cmd>Telescope find_files<cr>", "Find File" }
  }
  })
]]


local function which_key_mapping(setup)
  local wk = require("which-key")

  local options = {
    mode = "n",          -- NORMAL mode
    prefix = "<leader>", -- Every mapping is prepended with <leader>
    buffer = nil,        -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,       -- use `silent` when creating keymaps
    noremap = true,      -- use `noremap` when creating keymaps
    nowait = false,      -- use `nowait` when creating keymaps
  }

  wk.register(setup, options)
end

return which_key_mapping
