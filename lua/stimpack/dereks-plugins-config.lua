local map = require('stimpack.mapping-function')

map('n', '<leader>nn', require('dvp').comma_count)
map('n', '<leader>nb', require('dvp').bit_flip)

-- plover-tapey-tape.nvim
require('plover-tapey-tape').setup({
  filepath = 'auto',
  vertical_split_height = 3,
  horizontal_split_width = 42,
  status_line_setup = {
    enabled = true,
    additional_filter = '(|.*|)',
  },
})
