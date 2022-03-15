"" _    ___               _       ___ __   _ 
""| |  / (_)___ ___      | |     / (_) /__(_)
""| | / / / __ `__ \_____| | /| / / / //_/ / 
""| |/ / / / / / / /_____/ |/ |/ / / ,< / /  
""|___/_/_/ /_/ /_/      |__/|__/_/_/|_/_/   
""                                           

set nocompatible
filetype plugin on
syntax on

"Personal Wiki Setup
let wiki_1 = {}
let wiki_1.path = '~/.mywiki/personal/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'
let wiki_1.auto_diary_index = 1
let wiki_1.list_margin = 0
let wiki_1.custom_wiki2html = '$HOME/.derek-shell-config/scripts/wiki2html.sh'

"Work Wiki Setup
let wiki_2 = {}
let wiki_2.path = '~/.mywiki/work/'
let wiki_2.syntax = 'markdown'
let wiki_2.ext = '.md'
let wiki_2.auto_diary_index = 1
let wiki_2.list_margin = 0
let wiki_2.custom_wiki2html = '$HOME/.derek-shell-config/scripts/wiki2html.sh'

"Apply the different Wiki's into the setup vimwiki_list
let g:vimwiki_list = [ wiki_1, wiki_2 ]

"Allow automatic syntax check for code blocks
let g:automatic_nested_syntaxes = 1

"Template for work diary wiki using a python script
autocmd BufNewFile  ~/.mywiki/work/diary/*.md :silent 0r !~/.derek-shell-config/scripts/generate-vimwiki-diary-template.py '%'
