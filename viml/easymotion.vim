"Disable default mappings
let g:EasyMotion_do_mapping = 0

"Basic key usage is to just press s to activate
nmap s <Plug>(easymotion-overwin-f)

"Use a smartcase so that you can search upper and lower case easily
let g:EasyMotion_smartcase = 1

"Color setup
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

hi link EasyMotionTarget2First MatchParen
hi link EasyMotionTarget2Second MatchParen

hi link EasyMotionMoveHL Search
hi link EasyMotionIncSearch Search
