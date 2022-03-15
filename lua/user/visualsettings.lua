-- Visual settings
vim.o.termguicolors = true                       -- Needed for better color display
vim.cmd "colorscheme base16-atelier-forest"      -- Current color scheme
-- vim.cmd "colorscheme base16-atelier-sulphurpool"   -- Former favorite
vim.cmd([[match Error /\t/]])                    -- Diplay tabs with error highlight
vim.cmd([[match ColorColumn /\s\+$/]])           -- Highlight trailing whitespace with color column
vim.cmd "set listchars=trail:·,precedes:«,extends:»,tab:▸\\ "
vim.cmd "set list"

require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "蚠",
    color = "#428850",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}
