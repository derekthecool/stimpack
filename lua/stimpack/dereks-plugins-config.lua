local map = require('stimpack.mapping-function')

map('n', '<leader>nn', require('dvp').comma_count)
map('n', '<leader>nb', require('dvp').bit_flip)

-- plover-tapey-tape.nvim
require('plover-tapey-tape').setup({
  filepath = 'auto',
  open_method = 'vsplit',
  vertical_split_height = 9,
  horizontal_split_width = 54,
  steno_capture = '|(.-)|',
  suggestion_notifications = {
    enabled = true,
  },
  status_line_setup = {
    enabled = true,
    additional_filter = '(|.-|)',
  },
}
)
map('n', '<leader>nt', require('plover-tapey-tape').toggle)
