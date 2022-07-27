if not pcall(require, 'lightspeed') then return end
-- Disable f/F/t/T features from lightspeed, they mess up my macros
-- vim.cmd[[
-- let g:lightspeed_no_default_keymaps = 1
-- ]]
vim.g.lightspeed_no_default_keymaps = 1
local map = require('stimpack.mapping-function')
map("n", "s", "<Plug>Lightspeed_s")
map("n", "S", "<Plug>Lightspeed_S")
map("n", "\\", "<Plug>Lightspeed_omni_s")
map("n", "√", "<Plug>Lightspeed_omni_gs")
map("n", "Δ", "<Plug>Lightspeed_gs")
map("n", "∞", "<Plug>Lightspeed_gS")
