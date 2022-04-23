-- takes an optional argument for path, default is './.vim/projector.json'
require'projector.config_utils'.load_project_configurations()
require'projector.config_utils'.load_dap_configurations()

local map = require('user.mapping-function')

map("n" , "<leader>dd" , "<cmd>lua require('projector').continue('all')<CR>")
map("n" , "_"          , "<cmd>lua require('projector').continue('all')<CR>")
