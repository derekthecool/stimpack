-- Helpful mapping function from oroques.dev
-- https://oroques.dev/notes/neovim-init/#mappings
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<space>nn", '<cmd>lua require(\'dvp\').comma_count()<cr>', {noremap = true})
map("n", "<space>nb", '<cmd>lua require(\'dvp\').bit_flip()<cr>', {noremap = true})
