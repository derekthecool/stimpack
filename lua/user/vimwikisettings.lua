vim.cmd[[
filetype plugin on

"Personal Wiki Setup
let wiki_1 = {}
let wiki_1.path = '~/.mywiki/personal/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'
let wiki_1.auto_diary_index = 1
let wiki_1.list_margin = 0

"Work Wiki Setup
let wiki_2 = {}
let wiki_2.path = '~/.mywiki/work/'
let wiki_2.syntax = 'markdown'
let wiki_2.ext = '.md'
let wiki_2.auto_diary_index = 1
let wiki_2.list_margin = 0

"Apply the different Wiki's into the setup vimwiki_list
let g:vimwiki_list = [ wiki_1, wiki_2 ]

"Allow automatic syntax check for code blocks
let g:automatic_nested_syntaxes = 1

"Template for work diary wiki using a python script
autocmd BufNewFile  ~/.mywiki/work/diary/*.md :silent 0r !~/.derek-shell-config/scripts/generate-vimwiki-diary-template.py '%'
]]

local map = require('user.mapping-function')

local which_key_mapper = require('user.which-key-mapping')
which_key_mapper({
f = {
  name = "file", -- optional group name
  W = {"<cmd>lua require ('telescope.builtin').live_grep({layout_strategy='vertical'        , cwd='~/.mywiki'                                 , prompt_title='Live grep through .mywiki'})<CR>"    , "Live grep my wiki" },
  w = {"<cmd>lua require ('telescope.builtin').find_files({cwd='~/.mywiki'                  , prompt_title='Search .mywiki'})<CR>"            , "Search my wiki"},
},

v = {
  name ="vimwiki",
  D = {"<cmd>VimwikiDiaryNextDay<cr>", "Diary next day"},
  d = {"<cmd>VimwikiDiaryPrevDay<cr>", "Diary previous day"},
}
})


-- " v is for vimwiki
-- " Dependent Plugins:
-- " Plug 'vimwiki/vimwiki'
-- " Plug 'godlygeek/tabular'
--  let g:which_key_map_leader.v = {
--       \ 'name' : '+Vimwiki'             ,
--       \ 'D' : [':VimwikiDiaryNextDay'   , 'Diary Next Day' ]                  ,
--       \ 'd' : [':VimwikiDiaryPrevDay'   , 'Diary Previous Day' ]              ,
--       \ 'h' : [':VimwikiSplitLink'      , 'Follow Link Horizontal' ]          ,
--       \ 'l' : [':VimwikiToggleListItem' , 'Toggle list item' ]                ,
--       \ '/' : [':VimwikiSearch'         , 'Vimwiki Search' ]                  ,
--       \ 'j' : [':lnext'                 , 'Next search result' ]              ,
--       \ 'k' : [':lprevious'             , 'Previous search result' ]          ,
--       \ 'o' : [':lopen'                 , 'Open list of all search results' ] ,
--       \ 'v' : [':VimwikiVSplitLink'     , 'Follow Link Verical']              ,
--       \ 'u' : [':VimwikiNextTask'       , 'Find Next Unfinished Task']        ,
--       \ 'T' : [':VimwikiTable'          , 'Vimwiki Table Insert']             ,
--       \ }

