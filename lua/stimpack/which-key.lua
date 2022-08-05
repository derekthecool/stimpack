require('which-key').setup({
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
    operators = { gc = 'Comments' },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
        separator = '➜', -- symbol used between a key and it's label
        group = '+', -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = '<c-d>', -- binding to scroll down inside the popup
        scroll_up = '<c-u>', -- binding to scroll up inside the popup
    },
    window = {
        border = 'none', -- none, single, double, shadow
        position = 'bottom', -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = 'left', -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = 'auto', -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { 'j', 'k', ';', 'zzz', 'zz', 'z' },
        v = { 'j', 'k' },
    },
})

--[[
" f is for find, file, and FZF
" Dependent Plugins:
" Plug 'mhin/vim-startify'
let g:which_key_map_leader.f = {
      \ 'name' : '+Find'              ,
      \ 'h' : [':Startify'            , 'Startify']           ,
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
