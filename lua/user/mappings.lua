local map = require('user.mapping-function')

-- Ｎｏｒｍａｌ ｍａｐｓ
-- Map alt + n/e to navigate quickfix list
map('n', '→', ':cnext<CR>')
map('n', '←', ':cprev<CR>')

-- Ｉｎｓｅｒｔ ｍａｐｓ
-- Control + j/k to select from popup menu
map('i', '<c-j>', '<C-n>')
map('i', '<c-k>', '<C-p>')
--Easy add semicolon to end of the line
map('i', ';;', '<C-o>A;')

-- Ｖｉｓｕａｌ ｍｏｄｅ
-- Better command to shift text in visual mode, text it reselected
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Eazy saving with zz
-- Press zz or <C-z> in normal mode to save
-- Press zz or <C-z> in insert mode to save, exit insert, and go to start of line
map('n' , 'zz'    , ':update<CR>'            )
map('i' , 'zz'    , '<C-o>:update<CR><ESC>^' )

-- -- Permanent Very Magic Mode - Helps To Get PCRE Type Regex
map('n' , '/' , '/\\v' )
map('v' , '/' , '/\\v' )

-- TODO: make this work in LUA. As of 2021-07-21 it starts the folds then exits
-- Awesome search filtering "https://vim.fandom.com/wiki/Folding_with_Regular_Expression
-- 1. Search using /
-- 2. Press \z to filter everything not matching the search
-- 3. Press zr and zm for more and less context
--  nnoremap \z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>
-- vim.cmd "nnoremap \z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>"
