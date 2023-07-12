-- Autotest runners
local dotnet_test = require('stimpack.code-auto-run.dotnet-test').dotnet_test
local neovim_test = require('stimpack.code-auto-run.plenary-neovim-test').neovim_test

-- At the moment I need plenary neovim tests to have the describe function name to have a ' --' at the end
-- Just fix it right away, no special mapping or anything weird. Just do it!
vim.api.nvim_create_autocmd('BufRead', {
    pattern = { '*_spec.lua' },
    callback = function()
        -- This special regex will only replace bad you ones, it will not add more to exiting ones
        vim.cmd([[silent! %s/describe.'.*\(--\)\@<!\zs'/ --']])
        vim.notify('Cleaned up test names', vim.log.levels.INFO, { title = 'Stimpack Notification' })
    end,
})

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
