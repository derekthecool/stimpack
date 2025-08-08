-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Quick fix maps
vim.keymap.set({ 'n', 'i' }, '→', function()
    vim.api.nvim_cmd({ cmd = 'cnext' }, {})
end)
vim.keymap.set({ 'n', 'i' }, '→→', function()
    vim.api.nvim_cmd({ cmd = 'clast' }, {})
end)
vim.keymap.set({ 'n', 'i' }, '→→→', function()
    vim.api.nvim_cmd({ cmd = 'cnfile' }, {})
end)
vim.keymap.set({ 'n', 'i' }, '←', function()
    vim.api.nvim_cmd({ cmd = 'cprev' }, {})
end)
vim.keymap.set({ 'n', 'i' }, '←←', function()
    vim.api.nvim_cmd({ cmd = 'cfirst' }, {})
end)
vim.keymap.set({ 'n', 'i' }, '←←←', function()
    vim.api.nvim_cmd({ cmd = 'cNfile' }, {})
end)
vim.keymap.set({ 'n', 'i' }, '↓', function()
    vim.api.nvim_cmd({ cmd = 'cclose' }, {})
end)
vim.keymap.set({ 'n', 'i' }, '↑', function()
    vim.api.nvim_cmd({ cmd = 'copen' }, {})
end)

-- Buffer maps
vim.keymap.set('', '⊃', ':bnext<cr>') -- Use right mod
vim.keymap.set('', '⊂', ':bprevious<cr>') -- Use left mod
vim.keymap.set('', 'π', ':bdelete<cr>') -- Use down mod

-- Ｖｉｓｕａｌ ｍｏｄｅ
-- Better command to shift text in visual mode, text it reselected
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
