-- Helpful mapping function from oroques.dev
-- https://oroques.dev/notes/neovim-init/#mappings
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Eazy saving with zz
-- Press zz or <C-z> in normal mode to save
-- Press zz or <C-z> in insert mode to save, exit insert, and go to start of line
--
map('n' , 'zz'    , ':update<CR>'            , { noremap = true })
map('i' , 'zz'    , '<C-o>:update<CR><ESC>^' , { noremap = true })

-- Permanent Very Magic Mode - Helps To Get PCRE Type Regex
map('n' , '/' , '/\\v' , { noremap = true})
map('v' , '/' , '/\\v' , { noremap = true})

-- Use 'less' style maps for page up and down
-- With new tmux mapping, I can't use <C-u> any more
map('n' , 'U' , '<C-u>' , { noremap = true})
map('n' , 'D' , '<C-d>' , { noremap = true})

--Easy add semicolon to end of the line
map('i', ';;', '<C-o>A;', { noremap = true })

-- Better command to shift text in visual mode, it will reselect text after
-- shifting it
map('v', '<', '<gv', { noremap = true })
map('v', '>', '>gv', { noremap = true })

-- -- Awesome tips for mapping arrow keys to something useful
-- -- Tpope unimpaired is required
-- -- https://codingfearlessly.com/vim-putting-arrows-to-use
-- map('v' , '<Up>'    , '[egv')
-- map('v' , '<Down>'  , ']egv')
-- map('v' , '<Left>'  , '<gv')
-- map('v' , '<Right>' , '>gv')
-- map('n' , '<Left>'  , '<<')
-- map('n' , '<Right>' , '>>')
-- map('n' , '<Up>'    , '[e')
-- map('n' , '<Down>'  , ']e')

-- Control + j/k to select from popup menu
map('i', '<c-j>', '<C-n>', { noremap = true })
map('i', '<c-k>', '<C-p>', { noremap = true })

-- Map alt + n/e to navigate quickfix list
map('n', '<M-.>', ':cnext<CR>', { noremap = true})
map('n', '<M-,>', ':cprev<CR>', { noremap = true})

-- TODO: make this work in LUA. As of 2021-07-21 it starts the folds then exits
-- Awesome search filtering "https://vim.fandom.com/wiki/Folding_with_Regular_Expression
-- 1. Search using /
-- 2. Press \z to filter everything not matching the search
-- 3. Press zr and zm for more and less context
--  nnoremap \z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>
-- vim.cmd "nnoremap \z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>"

vim.cmd "nnoremap <space>/ :Commentary<CR>"
vim.cmd "vnoremap <space>/ :Commentary<CR>"
