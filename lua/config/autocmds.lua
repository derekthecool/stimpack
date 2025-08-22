-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

local generalSettingsGroup = vim.api.nvim_create_augroup('General settings', { clear = true })

-- Map xaml and axaml to have xml syntax
vim.api.nvim_create_autocmd(
    { 'BufRead', 'BufNewFile' },
    { pattern = { '*.xaml', '*.axaml' }, command = ':set filetype=xml', group = generalSettingsGroup }
)
-- Set .h files as C filetype and not cpp
vim.filetype.add({ extension = { h = 'c' }, priority = 100 })
vim.filetype.add({ extension = { fsproj = 'xml' }, priority = 1 })

vim.api.nvim_create_autocmd('SearchWrapped', {
    pattern = { '*' },
    callback = function()
        vim.notify('Search Wrapped', vim.log.levels.INFO, { title = 'Stimpack Notification' })
    end,
    group = generalSettingsGroup,
})

-- Disable autoformat for some filetypes
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'c', 'cpp' },
    callback = function()
        vim.b.autoformat = false
    end,
})
