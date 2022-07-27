vim.cmd[[
"Startify settings
let g:startify_change_to_dir = 1 
let g:startify_change_to_vcs_root = 1
let g:startify_enable_special = 0 " Get rid of empty buffer

let g:startify_custom_header = 
        \ split(system('figlet Dereks Neovim -f shadow'), '\n')
        \ + startify#pad(split(system('date +"%B %d" | figlet -f slant'), '\n'))
                                                                      
let g:startify_bookmarks = [
        \ {'i': '~/.config/nvim/init.lua'},
        \ {'c': '~/.config/nvim/ChangeLog.md'},
        \ {'a': '~/.config/nvim/utils/tasks.ini'},
        \ {'A': '~/.config/nvim/general/asynctasks.vim'},
        \ '~/.config/nvim/lua/plugins.lua',
        \ '~/.config/nvim/lua/settings.lua',
        \ '~/.config/nvim/general/mappings.vim',
        \ '~/.config/nvim/lua/mappings.lua',
        \ {'f': '~/.config/nvim/lua/startify.lua'},
        \ {'w': '~/.config/nvim/lua/which-key.lua'},
        \ '~/.config/nvim/general/coc.vim',
        \ '~/.config/nvim/general/markdown-preview.vim',
        \ '~/.config/nvim/lua/vimwikisettings.lua',
        \ '~/.config/nvim/general/snippetsconfig.vim',
        \ '~/.config/nvim/snips',
        \ '~/.config/nvim/coc-settings.json',
        \ '~/.config/vifm/vifmrc',
        \ {'z': '~/.zshrc'},
        \ {'t': '~/.tmux.conf'},
        \ {'x': '~/.derek-shell-config/source'},
        \ {'y': '~/.derek-shell-config/scripts'},
        \ ]

" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]
]]
