-- Visual settings
vim.o.termguicolors = true -- Needed for better color display
vim.wo.cursorcolumn = true
vim.wo.colorcolumn = "80" -- Display color column at 80 characters

-- vim.cmd "colorscheme base16-atelier-forest" -- Current color scheme
vim.cmd "colorscheme base16-atelier-sulphurpool" -- Former favorite

vim.cmd([[match Error /\t/]]) -- Diplay tabs with error highlight
vim.cmd([[match ColorColumn /\s\+$/]]) -- Highlight trailing whitespace with color column
-- vim.cmd "set listchars=trail:·,precedes:«,extends:»,tab:▸\\ "
vim.go.listchars = 'trail:·,precedes:«,extends:»,tab:▸\\ '
vim.wo.list = true

require 'nvim-web-devicons'.setup {
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true;
}
