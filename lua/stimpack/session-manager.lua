--[[
TODO: create session manager and use this command list
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
]]
