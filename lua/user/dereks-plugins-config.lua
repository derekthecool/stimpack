local map = require('user.mapping-function')

map("n", "<leader>nn", require('dvp').comma_count)
map("n", "<leader>nb", require('dvp').bit_flip)
