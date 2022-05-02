--[[
Helpful mapping function from oroques.dev
https://blog.devgenius.io/create-custom-keymaps-in-neovim-with-lua-d1167de0f2c2
https://oroques.dev/notes/neovim-init

This function is meant to make it easy to set mappings in other files
To use this mapping function follow these steps:

1. Require this file as a local variable
local map = require('user.mapping-function')

2. Set the mapping
map('n', '→', ':cnext<CR>')
]]

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  -- vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  vim.keymap.set(mode, lhs, rhs, options)
end

return map
