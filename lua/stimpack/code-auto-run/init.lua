-- Autotest runners
local dotnet_test = require('stimpack.code-auto-run.dotnet-test').dotnet_test
local neovim_test = require('stimpack.code-auto-run.plenary-neovim-test').neovim_test

--[[ vim.keymap.set('n', '<leader>ui', function()
  package.loaded['stimpack.code-auto-run.dotnet-test'] = nil
  package.loaded['stimpack.code-auto-run.plenary-neovim-test'] = nil
  require('stimpack.code-auto-run').neovim_test()
end, {}) ]]

local autocommand_group = vim.api.nvim_create_augroup('code-auto-run', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', { pattern = { '*.cs' }, callback = dotnet_test, group = autocommand_group })

vim.api.nvim_create_autocmd(
    'BufWritePost',
    { pattern = { '*.lua' }, callback = neovim_test, group = autocommand_group }
)

-- Load other non callable modules
require('stimpack.code-auto-run.window-manager-config-check')

return {
    dotnet_test = dotnet_test,
    neovim_test = neovim_test,
}
