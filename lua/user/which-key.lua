require("which-key").setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>', -- binding to scroll up inside the popup
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k", ";", "zzz", "zz", "z" },
    v = { "j", "k" },
  },
}


--[[
" f is for find, file, and FZF
" Dependent Plugins:
" Plug 'mhin/vim-startify'
let g:which_key_map_leader.f = {
      \ 'name' : '+Find'              ,
      \ 'h' : [':Startify'            , 'Startify']           ,
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
--]]
