"Awesome search filtering "https://vim.fandom.com/wiki/Folding_with_Regular_Expression
"1. Search using /
"2. Press \z to filter everything not matching the search
"3. Press zr and zm for more and less context
nnoremap \z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>
