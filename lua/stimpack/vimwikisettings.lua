vim.cmd([[
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
]])

local map = require('stimpack.mapping-function')

local which_key_mapper = require('stimpack.which-key-mapping')
which_key_mapper({
    f = {
        name = 'file', -- optional group name
        W = {
            '<cmd>lua require (\'telescope.builtin\').live_grep({layout_strategy=\'vertical\'        , cwd=\'~/.mywiki\'                                 , prompt_title=\'Live grep through .mywiki\'})<CR>',
            'Live grep my wiki',
        },
        w = {
            '<cmd>lua require (\'telescope.builtin\').find_files({cwd=\'~/.mywiki\'                  , prompt_title=\'Search .mywiki\'})<CR>',
            'Search my wiki',
        },
    },

    v = {
        name = 'vimwiki',
        D = {
            '<cmd>VimwikiDiaryNextDay<cr>',
            'Diary next day',
        },
        d = { '<cmd>VimwikiDiaryPrevDay<cr>', 'Diary previous day' },
        h = { '<cmd>VimwikiSplitLink<cr>', 'Follow Link Horizontal' },
        l = { '<cmd>VimwikiToggleListItem<cr>', 'Toggle list item' },
        ['/'] = { '<cmd>VimwikiSearch<cr>', 'Vimwiki Search' },
        j = { '<cmd>lnext<cr>', 'Next search result' },
        k = { '<cmd>lprevious<cr>', 'Previous search result' },
        o = { '<cmd>lopen<cr>', 'Open list of all search results' },
        v = { '<cmd>VimwikiVSplitLink<cr>', 'Follow Link Verical' },
        u = { '<cmd>VimwikiNextTask<cr>', 'Find Next Unfinished Task' },
        T = { '<cmd>VimwikiTable<cr>', 'Vimwiki Table Insert' },
        t = { ':Tabularize /', 'Tabularize formatting' },
    },
})
