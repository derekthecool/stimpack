local map = require('user.mapping-function')

-- Ｎｏｒｍａｌ ｍａｐｓ
-- These are really only possible with Plover steno so don't feel crazy if you
-- can't type this with your keyboard
-- Quick fix maps
map('n', '→', ':cnext<CR>')
map('n', '→→', ':clast<CR>')
map('n', '←', ':cprev<CR>')
map('n', '←←', ':cfirst<CR>')
map('n', '↓', ':cclose<CR>')
map('n', '↑', ':copen<CR>')

-- Buffer maps
map('n', '⊃', ':bnext<cr>') -- Use right mod
map('n', '⊂', ':bprevious<cr>') -- Use left mod
map('n', 'π', ':bdelete<cr>') -- Use down mod

-- Ｉｎｓｅｒｔ ｍａｐｓ
-- Control + j/k to select from popup menu
map('i', '<c-j>', '<C-n>')
map('i', '<c-k>', '<C-p>')

-- Ｖｉｓｕａｌ ｍｏｄｅ
-- Better command to shift text in visual mode, text it reselected
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Eazy saving with zzzz
-- Press zzz
map('n', 'zzz', ':update<CR>')
map('i', 'zzz', '<C-o>:update<CR><ESC>^')

-- -- Permanent Very Magic Mode - Helps To Get PCRE Type Regex
map('n', '/', '/\\v')
map('v', '/', '/\\v')

-- Conceal level mappings from ziontee113

map("n", "<F10>", function()
  if vim.o.conceallevel > 0 then
    vim.o.conceallevel = 0
  else
    vim.o.conceallevel = 2
  end
end)

map("n", "<F11>", function()
  if vim.o.concealcursor == "n" then
    vim.o.concealcursor = ""
  else
    vim.o.concealcursor = "n"
  end
end)

-- TODO: make this work in LUA. As of 2021-07-21 it starts the folds then exits
-- Awesome search filtering "https://vim.fandom.com/wiki/Folding_with_Regular_Expression
-- 1. Search using /
-- 2. Press \z to filter everything not matching the search
-- 3. Press zr and zm for more and less context
--  nnoremap \z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>
vim.cmd [[
nnoremap § :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>
]]
