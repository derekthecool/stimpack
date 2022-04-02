local map = require('user.mapping-function')

map("n", "<space>nn", '<cmd>lua require(\'dvp\').comma_count()<cr>')
map("n", "<space>nb", '<cmd>lua require(\'dvp\').bit_flip()<cr>')
