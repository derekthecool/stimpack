local map = require('user.mapping-function')

-- Ｎｏｒｍａｌ ｍａｐｓ
-- Use 'less' style maps for page up and down
-- With new tmux mapping, I can't use <C-u> any more
map('n' , 'U' , '<C-u>' ,{noremap = true})
map('n' , 'D' , '<C-d>' ,{noremap = true})
-- Map alt + n/e to navigate quickfix list
map('n', '<M-.>', ':cnext<CR>',{noremap = true})
map('n', '<M-,>', ':cprev<CR>',{noremap = true})

-- Ｉｎｓｅｒｔ ｍａｐｓ
-- Control + j/k to select from popup menu
map('i', '<c-j>', '<C-n>',{noremap = true})
map('i', '<c-k>', '<C-p>',{noremap = true})
--Easy add semicolon to end of the line
map('i', ';;', '<C-o>A;',{noremap = true})

-- Ｖｉｓｕａｌ ｍｏｄｅ
-- Better command to shift text in visual mode, text it reselected
map('v', '<', '<gv',{noremap = true})
map('v', '>', '>gv',{noremap = true})

-- Eazy saving with zz
-- Press zz or <C-z> in normal mode to save
-- Press zz or <C-z> in insert mode to save, exit insert, and go to start of line
map('n' , 'zz'    , ':update<CR>'            ,{noremap = true})
map('i' , 'zz'    , '<C-o>:update<CR><ESC>^' ,{noremap = true})

-- -- Permanent Very Magic Mode - Helps To Get PCRE Type Regex
map('n' , '/' , '/\\v' ,{noremap = true})
map('v' , '/' , '/\\v' ,{noremap = true})

-- TODO: make this work in LUA. As of 2021-07-21 it starts the folds then exits
-- Awesome search filtering "https://vim.fandom.com/wiki/Folding_with_Regular_Expression
-- 1. Search using /
-- 2. Press \z to filter everything not matching the search
-- 3. Press zr and zm for more and less context
--  nnoremap \z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>
-- vim.cmd "nnoremap \z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>"
