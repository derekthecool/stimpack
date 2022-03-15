"    ____  __            _           
"   / __ \/ /_  ______ _(_)___  _____
"  / /_/ / / / / / __ `/ / __ \/ ___/
" / ____/ / /_/ / /_/ / / / / (__  ) 
"/_/   /_/\__,_/\__, /_/_/ /_/____/  
"              /____/                
"Auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))                                                                                    
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim                                                             
  autocmd VimEnter * PlugInstall                                                                                                      
endif                                        

call plug#begin('~/.config/nvim/autoload/plugged')
" Vimwiki
Plug 'vimwiki/vimwiki'                                 " Markdown related plugins
Plug 'mattn/calendar-vim'                              " Calendar plugin for use with vimwiki
Plug 'godlygeek/tabular'                               " Tabular must come before vim-markdown
Plug 'plasticboy/vim-markdown'                         " Markdown syntax

" TMUX
Plug 'christoomey/vim-tmux-navigator'                  " Use vim and tmux seamlesly
Plug 'tmux-plugins/vim-tmux-focus-events'              " Another tmux helper to help get notifications
Plug 'edkolev/tmuxline.vim'                            " Make tmux status bar match vim airline

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Colors and themes
Plug 'chriskempson/base16-vim'                         " Visual plugins
Plug 'vim-airline/vim-airline'                         " Nice looking bottom status bar
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " Color highlighter

" General helper plugins
Plug 'tpope/vim-surround'                              " Easily surround text
Plug 'tpope/vim-unimpaired'                              " Easily surround text
Plug 'liuchengxu/vim-which-key'                        " Convenience Plugins
Plug 'voldikss/vim-floaterm'                           " Awesome floating terminal in vim
Plug 'easymotion/vim-easymotion'                       " Navigate similar to vimimum web browsing

" File navigators
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }    " Fuzzy file finder
Plug 'junegunn/fzf.vim'                                " Second part to FZF
Plug 'vifm/vifm.vim'
Plug 'mhinz/vim-startify'                              " Really nice start menu for vim

" Coding helpers
Plug 'neoclide/coc.nvim', {'branch': 'release'}        " Auto complete awesomeness
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh', }                  " Bash LSP extension
Plug 'honza/vim-snippets'                              " Snippet resource
Plug 'tpope/vim-commentary'                            " Easily comment lines
Plug 'sheerun/vim-polyglot'                            " Syntax highlight for many additional languages
Plug 'puremourning/vimspector'                         " Code debugger for vim
Plug 'szw/vim-maximizer'                               " Maximize a vim pane, to be used with vimspector
Plug 'skywind3000/asynctasks.vim'                      " Async build resource
Plug 'skywind3000/asyncrun.vim'
Plug 'RishabhRD/popfix'                                " Needed for nvim-cheat.sh
Plug 'RishabhRD/nvim-cheat.sh'                         " Easy coding help from vim
Plug 'AndrewRadev/linediff.vim'                        " Diff items from the same file
Plug 'dbeniamine/cheat.sh-vim'                         " Another cheat sheet tool

" Git helpers
Plug 'airblade/vim-rooter'                             " Sets directory to git root
Plug 'tpope/vim-fugitive'                              " Git client helper
Plug 'tpope/vim-rhubarb'                               " Git helper to open file in github
Plug 'airblade/vim-gitgutter'                          " Git gutter to see changes in files

" Document helpers
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' } " Latex plugins
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Browser plugins
" firenvim works, but I am not sure I like it
" Using Firefox from WSL I hope to get this to work
" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
call plug#end()

"If plugin only needs one or two config items I will add them here otherwise I
"will make a file just for that plugin to source

"Latex preview options
" let g:livepreview_previewer = 'zathura'

"Vim-commentary setup
nnoremap <space>/ :Commentary<CR>
vnoremap <space>/ :Commentary<CR>
