" This file is designed to set custom syntax to files in a certain location
" without an extension
" autocmd BufRead $HOME/.config/neomutt/* setlocal syntax=neomuttrc

" Change C,C++,C#,Java comments from /* */ style to //
autocmd FileType c,cpp,csharp,java set commentstring=//%s
