-- Ｎｏｒｍａｌ ｍａｐｓ
-- These are really only possible with Plover steno so don't feel crazy if you
-- can't type this with your keyboard
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

-- -- Ｉｎｓｅｒｔ ｍａｐｓ
-- -- Control + j/k to select from popup menu
-- vim.keymap.set('i', '<c-j>', '<C-n>')
-- vim.keymap.set('i', '<c-k>', '<C-p>')

-- Ｖｉｓｕａｌ ｍｏｄｅ
-- Better command to shift text in visual mode, text it reselected
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Eazy saving with zzzz
-- Press zzz
vim.keymap.set('n', 'zzz', ':update<CR>', { silent = true })
vim.keymap.set('i', 'zzz', '<C-o>:update<CR><ESC>^', { silent = true })

-- -- Permanent Very Magic Mode - Helps To Get PCRE Type Regex
vim.keymap.set('n', '/', '/\\v')
vim.keymap.set('v', '/', '/\\v')

-- Lazy commands
vim.keymap.set('n', '<leader>aa', ':Lazy<CR>')

-- Run plenary tests on current buffer
vim.keymap.set('n', '<leader>dP', '<Plug>PlenaryTestFile<CR>')

-- Show recent notifications
vim.keymap.set('n', '<leader>ad', function()
    require('notify')._print_history()
end)

-- Conceal level mappings from ziontee113

vim.keymap.set('n', '<F10>', function()
    if vim.o.conceallevel > 0 then
        vim.o.conceallevel = 0
    else
        vim.o.conceallevel = 2
    end
end)

vim.keymap.set('n', '<F11>', function()
    if vim.o.concealcursor == 'n' then
        vim.o.concealcursor = ''
    else
        vim.o.concealcursor = 'n'
    end
end)

vim.keymap.set({ 'n' }, '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set({ 'n' }, '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set({ 'n' }, '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set({ 'n' }, '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- TODO: make this work in LUA. As of 2021-07-21 it starts the folds then exits
-- Awesome search filtering "https://vim.fandom.com/wiki/Folding_with_Regular_Expression
-- 1. Search using /
-- 2. Press \z to filter everything not matching the search
-- 3. Press zr and zm for more and less context
--  nnoremap \z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>
vim.cmd([[
nnoremap § :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>
]])
--[[
Code flow:


Relavant Documentation:


						*v:lnum* *lnum-variable*
v:lnum		Line number for the 'foldexpr' |fold-expr|, 'formatexpr' and
		'indentexpr' expressions, tab page number for 'guitablabel'
		and 'guitabtooltip'.  Only valid while one of these
		expressions is being evaluated.  Read-only when in the
		|sandbox|.
]]
local function ReloadConfig()
    local count = 0
    for name, _ in pairs(package.loaded) do
        print(name)

        if name:match('stimpack') then
            -- print('name matched ' .. name)
            package.loaded.name = nil
            count = count + 1
        end
    end

    vim.notify(string.format('Reloaded entire neovim config with %d packages', count))
    dofile(OS.init_lua)
end

vim.keymap.set('n', '<leader>ac', ReloadConfig)

-- https://unix.stackexchange.com/questions/585019/horizontal-equivalent-of-zz-in-vim
-- vim.keymap.set('n', 'z.', '<C-u>normal! zszH<CR>', { silent = true, desc = 'Center cursor horizontally' })
vim.cmd([[nnoremap <silent> z. :<C-u>normal! zszH<CR>]])

vim.keymap.set('n', '<leader>nn', function()
    local date = os.date('%Y-%m-%d')
    local daily_note = string.format("%s/.mywiki/work/Freeus/diary/%s.md", OS.home, date)
    -- if FileExists(daily_note) then
    vim.cmd(string.format("e %s", daily_note))
    -- end
end, { silent = true, desc = 'Open daily note' })
