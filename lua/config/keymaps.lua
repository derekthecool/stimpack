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

vim.keymap.set('n', '<c-b>', function()
    Snacks.picker.buffers()
end, { desc = 'Buffers' })
vim.keymap.set('n', '<c-f>', function()
    Snacks.picker.git_files()
end, { desc = 'Files' })

-- Debugging keymaps (other lazyvim <leader>d keymaps are unchanged)
vim.keymap.set('n', '_', require('dap').continue, { silent = true, desc = 'Run/Continue' })
vim.keymap.set('n', '≥', require('dap').step_into, { silent = true, desc = 'Step Into' })
vim.keymap.set('n', '≤', require('dap').step_out, { silent = true, desc = 'Step Out' })
vim.keymap.set('n', 'µ', require('dap').toggle_breakpoint, { silent = true, desc = 'Toggles Breakpoint' })

vim.keymap.set('n', '<leader>Nw', function()
    local daily_note = string.format('%s/.mywiki/work/Freeus/diary/%s.md', OS.home, os.date('%Y-%m-%d'))
    vim.cmd(string.format('e %s', daily_note))
end, { silent = true, desc = 'Open daily work note' })

vim.keymap.set('n', '<leader>Np', function()
    local daily_note = string.format('%s/.mywiki/personal/diary/%s.md', OS.home, os.date('%Y-%m-%d'))
    vim.cmd(string.format('e %s', daily_note))
end, { silent = true, desc = 'Open daily note' })

-- TODO: make this work in LUA. As of 2021-07-21 it starts the folds then exits
-- Awesome search filtering "https://vim.fandom.com/wiki/Folding_with_Regular_Expression
-- 1. Search using /
-- 2. Press \z to filter everything not matching the search
-- 3. Press zr and zm for more and less context
--  nnoremap \z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>
vim.cmd([[
nnoremap § :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>
]])
