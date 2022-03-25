vim.cmd[[
" Map leader to which_key
nnoremap <silent> <leader> :silent WhichKey ','<CR>
vnoremap <silent> <leader> :silent WhichKeyVisual ','<CR>
nnoremap <silent> <Space> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <Space> :<c-u>WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map_leader =  {}
" Define a separator
let g:which_key_sep = '→'

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" f is for find, file, and FZF
" Dependent Plugins:
" Plug 'mhinz/vim-startify'
let g:which_key_map_leader.f = {
      \ 'name' : '+Find'              ,
      \ 'h' : [':Startify'            , 'Startify']           ,
      \ }

" c is for cheat
" Dependent Plugins:
" 'RishabhRD/popfix'
" 'RishabhRD/nvim-cheat.sh'
nnoremap <leader>Kh :HowIn 
let g:which_key_map_leader.K = {
      \ 'name' : '+CheatSheet'               ,
      \ 'c' : [':Cheat'                      , 'Cheat Sheet (cht.sh)'] ,
      \ 'i' : [':FloatermNew cht.sh --shell' , 'cht.sh interactive']   ,
      \ }

" t is for terminal
" Dependent Plugins:
" Plug 'voldikss/vim-floaterm'
let g:which_key_map_leader.t = {
      \ 'name' : '+Floaterm'                             ,
      \ ';' : [':FloatermNew --wintype=popup --height=6' , 'Terminal'] ,
      \ 'd' : [':FloatermNew lazydocker'                 , 'Docker']   ,
      \ 'f' : [':FloatermNew fzf'                        , 'Fzf']      ,
      \ 'g' : [':FloatermNew lazygit'                    , 'LazyGit']  ,
      \ 'n' : [':FloatermNew node'                       , 'Node']     ,
      \ 'p' : [':FloatermNew python3'                    , 'Python']   ,
      \ 'r' : [':FloatermNew ranger'                     , 'Ranger']   ,
      \ 't' : [':FloatermToggle'                         , 'Toggle']   ,
      \ 'v' : [':FloatermNew vifm'                       , 'Vifm']     ,
      \ } 

" " d is for debug
" " Dependent Plugins:
" " Plug 'puremourning/vimspector'
" " Plug 'szw/vim-maximizer'
" function! GotoWindow(id)
"     call win_gotoid(a:id)
"     MaximizerToggle
" endfunction
" 
" function! AddToVimspectorWatch()
"     let word = expand("<cexpr>")
"     call vimspector#AddWatch(word)
" endfunction
" 
" " Mapping VimspectorBallonEval does not work in which key mappings
" nnoremap <leader>di :lua require('telescope').extensions.vimspector.configurations()<CR>
" 
" " Allow for use of function key mappings as well
" let g:vimspector_enable_mappings = 'HUMAN'
" 
" let g:which_key_map_leader.d = {
"       \ 'name' : '+debug'                                                             ,
"       \ 'b' : ['<Plug>VimspectorToggleBreakpoint'                                     , 'breakpoint']             ,
"       \ 'B' : ['<Plug>VimspectorToggleConditionalBreakpoint'                          , 'conditional breakpoint'] ,
"       \ 'c' : ['<Plug>VimspectorRunToCursor'                                          , 'run to cursor']          ,
"       \ 'C' : [':call vimspector#ClearBreakpoints()<CR>'                              , 'clear all breakpoints']  ,
"       \ 'd' : ['<Plug>VimspectorContinue'                                             , 'continue']               ,
"       \ 'f' : ['<Plug>VimspectorAddFunctionBreakpoint'                                , 'function breakpoint']    ,
"       \ 'l' : [':call vimspector#Launch()<CR>'                                        , 'launch debugger']        ,
"       \ 'm' : [':MaximizerToggle!'                                                    , 'maximize window']        ,
"       \ 'o' : ['<Plug>VimspectorStepOver'                                             , 'step over']              ,
"       \ 'O' : ['<Plug>VimspectorStepOut'                                              , 'step out']               ,
"       \ 'i' : ['<Plug>VimspectorStepInto'                                             , 'step into']              ,
"       \ 'h' : ['<Plug>VimspectorBalloonEval'                                          , 'ballon eval']            ,
"       \ 'p' : ['<Plug>VimspectorPause'                                                , 'pause']                  ,
"       \ 'q' : [':VimspectorReset'                                                     , 'exit debugger']          ,
"       \ 'r' : ['<Plug>VimspectorRestart'                                              , 'restart']                ,
"       \ 'w' : [':call AddToVimspectorWatch()<CR>'                                     , 'add variable to watch']  ,
"       \ 's' : ['<Plug>VimspectorStop'                                                 , 'stop']                   ,
"       \ '1' : [':call GotoWindow(g:vimspector_session_windows.code)<CR>'              , 'View: Code']             ,
"       \ '2' : [':call GotoWindow(g:vimspector_session_windows.variables)<CR>'         , 'View: Variables']        ,
"       \ '3' : [':call GotoWindow(g:vimspector_session_windows.watches)<CR>'           , 'View: Watches']          ,
"       \ '4' : [':call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>'       , 'View: Stack Trace']      ,
"       \ '5' : [':call GotoWindow(g:vimspector_session_windows.tagpage)<CR>'           , 'View: Tag Page']         ,
"       \ '6' : [':call GotoWindow(g:vimspector_session_windows.output)<CR>'            , 'View: Output']           ,
"       \ '+' : ['<Plug>VimspectorUpFrame'                                              , 'View: Stack Frame Up']   ,
"       \ '-' : ['<Plug>VimspectorDownFrame'                                            , 'View: Stack Frame Down'] ,
"       \ }

" u is for task
let g:which_key_map_leader.u = {
      \ 'name' : '+task'                ,
      \ ';' : [':AsyncTask build'       , 'LOCAL: run build']                 ,
      \ 'i' : [':AsyncTask test'        , 'LOCAL: run tests']                 ,
      \ 'u' : [':AsyncTask run'         , 'LOCAL: run project']               ,
      \ 'e' : [':AsyncTaskEdit'         , 'LOCAL: edit tasks']                ,
      \ 'h' : [':AsyncTaskList!'        , 'list hidden tasks']                ,
      \ 'm' : [':AsyncTaskMacro'        , 'macro help']                       ,
      \ 'g' : [':AsyncTaskEdit!'        , 'GLOBAL: edit tasks']               ,
      \ 'z' : [':AsyncTask cmake-init'  , 'GLOBAL: cmake setup build folder'] ,
      \ 'U' : [':AsyncTask file-run'    , 'GLOBAL: run file']                 ,
      \ 'p' : [':AsyncTask project-run' , 'GLOBAL: run project']              ,
      \ }

" " g is for git
" " Dependent Plugins:
" " Plug 'tpope/vim-fugitive'
" " Plug 'tpope/vim-rhubarb' (only for GBrowse)
" let g:which_key_map_leader.g = {
"       \ 'name' : '+git'                            ,
"       \ '1' : [':diffget'                          , 'diffget']             ,
"       \ '2' : [':diffput'                          , 'diffput']             ,
"       \ 'a' : [':Git add .'                        , 'add all']             ,
"       \ 'b' : [':Git blame'                        , 'blame']               ,
"       \ 'B' : [':GBrowse'                          , 'browse']              ,
"       \ 'c' : [':Git commit'                       , 'commit']              ,
"       \ 'd' : [':Git diff'                         , 'diff']                ,
"       \ 'D' : [':Gdiffsplit'                       , 'diff split']          ,
"       \ 'g' : [':Git'                              , 'status']              ,
"       \ 'G' : [':GGrep'                            , 'git grep']            ,
"       \ 'h' : [':GitGutterLineHighlightsToggle'    , 'highlight hunks']     ,
"       \ 'H' : ['<Plug>(GitGutterPreviewHunk)'      , 'preview hunk']        ,
"       \ 'i' : [':Gist -b'                          , 'post gist']           ,
"       \ 'j' : ['<Plug>(GitGutterNextHunk)'         , 'next hunk']           ,
"       \ 'k' : ['<Plug>(GitGutterPrevHunk)'         , 'prev hunk']           ,
"       \ 'l' : [':Git log'                          , 'log']                 ,
"       \ 'm' : ['<Plug>(git-messenger)'             , 'message']             ,
"       \ 'p' : [':Git push'                         , 'push']                ,
"       \ 'P' : [':Git pull'                         , 'pull']                ,
"       \ 'r' : [':GRemove'                          , 'remove']              ,
"       \ 's' : ['<Plug>(GitGutterStageHunk)'        , 'stage hunk']          ,
"       \ 't' : [':GitGutterSignsToggle'             , 'toggle signs']        ,
"       \ 'u' : ['<Plug>(GitGutterUndoHunk)'         , 'undo hunk']           ,
"       \ 'v' : [':GV'                               , 'view commits']        ,
"       \ 'V' : [':GV!'                              , 'view buffer commits'] ,
"       \ }


" l is for language server protocol
" Dependent Plugins:
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" This includes all the leader and <space> bindings from the coc suggested config

" xmap <leader>la  <Plug>(coc-codeaction-selected)
" nmap <leader>la  <Plug>(coc-codeaction-selected)
"
" let g:which_key_map_leader.l = {
"       \ 'name' : '+lsp'                            ,
"       \ '.' : [':CocConfig'                        , 'config']          ,
"       \ ';' : ['<Plug>(coc-refactor)'              , 'refactor']        ,
"       \ 'A' : ['<Plug>(coc-codeaction)'            , 'code action']     ,
"       \ 'b' : [':CocNext'                          , 'next action']     ,
"       \ 'B' : [':CocPrev'                          , 'prev action']     ,
"       \ 'c' : [':CocList commands'                 , 'commands']        ,
"       \ 'd' : ['<Plug>(coc-definition)'            , 'definition']      ,
"       \ 'D' : ['<Plug>(coc-declaration)'           , 'declaration']     ,
"       \ 'e' : [':CocList extensions'               , 'extensions']      ,
"       \ 'f' : ['<Plug>(coc-format-selected)'       , 'format selected'] ,
"       \ 'F' : ['<Plug>(coc-format)'                , 'format']          ,
"       \ 'h' : ['<Plug>(coc-float-hide)'            , 'hide']            ,
"       \ 'i' : ['<Plug>(coc-implementation)'        , 'implementation']  ,
"       \ 'I' : [':CocList diagnostics'              , 'diagnostics']     ,
"       \ 'j' : ['<Plug>(coc-float-jump)'            , 'float jump']      ,
"       \ 'l' : ['<Plug>(coc-codelens-action)'       , 'code lens']       ,
"       \ 'n' : ['<Plug>(coc-diagnostic-next)'       , 'next diagnostic'] ,
"       \ 'N' : ['<Plug>(coc-diagnostic-next-error)' , 'next error']      ,
"       \ 'O' : [':CocList outline'                  , 'search outline']  ,
"       \ 'p' : ['<Plug>(coc-diagnostic-prev)'       , 'prev diagnostic'] ,
"       \ 'P' : ['<Plug>(coc-diagnostic-prev-error)' , 'prev error']      ,
"       \ 'q' : ['<Plug>(coc-fix-current)'           , 'quickfix']        ,
"       \ 'r' : ['<Plug>(coc-references)'            , 'references']      ,
"       \ 'R' : ['<Plug>(coc-rename)'                , 'rename']          ,
"       \ 's' : [':CocList -I symbols'               , 'references']      ,
"       \ 'S' : [':CocList snippets'                 , 'snippets']        ,
"       \ 't' : ['<Plug>(coc-type-definition)'       , 'type definition'] ,
"       \ 'u' : [':CocListResume'                    , 'resume list']     ,
"       \ 'U' : [':CocUpdate'                        , 'update CoC']      ,
"       \ 'v' : [':source ~/.config/nvim/init.vim'   , 'source init.vim'] ,
"       \ 'z' : [':CocDisable'                       , 'disable CoC']     ,
"       \ 'Z' : [':CocEnable'                        , 'enable CoC']      ,
"       \ }

" S is for startify sessions
" Dependent Plugins:
" Plug 'mhinz/vim-startify'
let g:which_key_map_leader.S = {
      \ 'name' : '+Startify-Sessions' ,
      \ 'c' : [':SClose'              , 'Close Session']  ,
      \ 'd' : [':SDelete!'            , 'Delete Session'] ,
      \ 'l' : [':SLoad'               , 'Load Session']   ,
      \ 's' : [':Startify'            , 'Start Page']     ,
      \ 'S' : [':SSave!'               , 'Save Session']   ,
      \ }

" s is for spelling
" Dependent Plugins:
let g:which_key_map_leader.s = {
      \ 'name' : '+Spelling' ,
      \ 't' : [':set spell!' , 'Toggle Spelling On/Off']  ,
      \ 'j' : ['\]s'         , 'Next spelling error']     ,
      \ 'k' : ['\[s'         , 'Previous spelling error'] ,
      \ }

" q is for quickfix
" Dependent Plugins:
let g:which_key_map_leader.q = {
      \ 'name' : '+QuickFix' ,
      \ 'o' : [':copen'      , 'Open quickfix list']  ,
      \ 'q' : [':cclose'     , 'Close quickfix list'] ,
      \ }

" v is for vimwiki
" Dependent Plugins:
" Plug 'vimwiki/vimwiki'
" Plug 'godlygeek/tabular'
 let g:which_key_map_leader.v = {
      \ 'name' : '+Vimwiki'             ,
      \ 'D' : [':VimwikiDiaryNextDay'   , 'Diary Next Day' ]                  ,
      \ 'd' : [':VimwikiDiaryPrevDay'   , 'Diary Previous Day' ]              ,
      \ 'h' : [':VimwikiSplitLink'      , 'Follow Link Horizontal' ]          ,
      \ 'l' : [':VimwikiToggleListItem' , 'Toggle list item' ]                ,
      \ '/' : [':VimwikiSearch'         , 'Vimwiki Search' ]                  ,
      \ 'j' : [':lnext'                 , 'Next search result' ]              ,
      \ 'k' : [':lprevious'             , 'Previous search result' ]          ,
      \ 'o' : [':lopen'                 , 'Open list of all search results' ] ,
      \ 'v' : [':VimwikiVSplitLink'     , 'Follow Link Verical']              ,
      \ 'u' : [':VimwikiNextTask'       , 'Find Next Unfinished Task']        ,
      \ 'T' : [':VimwikiTable'          , 'Vimwiki Table Insert']             ,
      \ }

" Don't know how to include a command that requires input. So I will add the
" mappings here, they will still show up in which key mapping. These commands
" require input and a manual <CR> after the input.
nnoremap <leader>vt :Tabularize /
nnoremap <leader>vs :VWS 

"Register which key
call which_key#register(',', "g:which_key_map_leader")
]]
