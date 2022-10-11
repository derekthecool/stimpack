--[[
Found this plugin by reading this page
https://www.mattlayman.com/blog/2019/supercharging-vim-blazing-fast-search/https://www.mattlayman.com/blog/2019/supercharging-vim-blazing-fast-search/

Website for the plugin is https://github.com/stefandtw/quickfix-reflector.vim
The latest release was from 2018 so it is not actively maintained

To use this plugin simply make edits to the quick fix list however you want.
when done save the buff and the changes will be written to the source files.

You can delete lines from the list but they will be out of sync, just save the
buffer and it will resync. Deleting lines from the quick fix list does not
delete them from the source files.
--]]

vim.g.qf_modifiable = 1
vim.g.qf_join_changes = 1
vim.g.qf_write_changes = 1

-- Another nice feature to have to help narrow down quick fix lists. Run :h Cfilter for help
vim.api.nvim_cmd({ cmd = 'packadd', args = { 'cfilter' } }, {})
