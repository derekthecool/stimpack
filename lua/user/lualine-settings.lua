-- NOTE: colorscheme needs to be loaded before lualine
-- https://github.com/nvim-lualine/lualine.nvim/issues/632
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'base16',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'filesize', 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- WinSeparator looks nicer like this
vim.cmd [[highlight WinSeparator guibg=none]]

-- I can't get rid of this dumb error on every start up. This is my work around.
-- Copied from this example: https://github.com/ChristianChiarulli/nvim/blob/master/ftplugin/c.lua
local notify_filter = vim.notify
vim.notify = function(msg, ...)
  if msg:match "lualine: There are some issues with your config. Run :LualineNotices for details" then
    return
  end
  notify_filter(msg, ...)
end
