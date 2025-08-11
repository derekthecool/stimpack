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
vim.keymap.set('n', '⊃', function() -- Use right Emily's symbols mod
    vim.api.nvim_cmd({ cmd = 'bnext', mods = { silent = true } }, {})
end, { desc = 'Next buffer' })
vim.keymap.set('n', '⊂', function() -- Use left Emily's symbols mod
    vim.api.nvim_cmd({ cmd = 'bprevious', mods = { silent = true } }, {})
end, { desc = 'Previous buffer' })
vim.keymap.set('n', 'π', function() -- Use down Emily's symbols mod
    vim.api.nvim_cmd({ cmd = 'bdelete', mods = { silent = true } }, {})
end, { desc = 'Next buffer' })

-- Ｖｉｓｕａｌ ｍｏｄｅ
-- Better command to shift text in visual mode, text it reselected
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
