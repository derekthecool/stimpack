local map = require('stimpack.mapping-function')

map('n', '<leader>nn', require('dvp').comma_count)
map('n', '<leader>nb', require('dvp').bit_flip)

-- plover-tapey-tape.nvim
require('plover-tapey-tape').setup()
map('n', '<leader>nt', require('plover-tapey-tape').open)
