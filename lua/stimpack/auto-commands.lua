-- Create augroup for the autocommands in this file
-- 2022-09-19: is a special day because I finally understand vim/neovim autocommands!
local generalSettingsGroup = vim.api.nvim_create_augroup('General settings', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost * ', {
    callback = function()
        require('vim.highlight').on_yank({ higroup = 'Visual', timeout = 500 })
    end,
    group = generalSettingsGroup,
})

-- This autocommand does not seem to work right on nonhelp files, not able to do macros
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'qf', 'help', 'fugitive' },
    command = 'nnoremap <silent> <buffer> q :close<cr>',
    group = generalSettingsGroup,
})
vim.api.nvim_create_autocmd('BufWinEnter', { command = ':set formatoptions-=cro', group = generalSettingsGroup })

-- Map xaml and axaml to have xml syntax
vim.api.nvim_create_autocmd(
    { 'BufRead', 'BufNewFile' },
    { pattern = { '*.xaml', '*.axaml' }, command = ':set filetype=xml', group = generalSettingsGroup }
)

vim.api.nvim_create_autocmd('SearchWrapped', {
    pattern = { '*' },
    callback = function()
        vim.notify('Search Wrapped', vim.log.levels.INFO, { title = 'Stimpack Notification' })
    end,
    group = generalSettingsGroup,
})

vim.api.nvim_create_autocmd('LspAttach', {
    pattern = { '*' },
    callback = function()
        vim.lsp.inlay_hint(0, true)
    end,
    group = generalSettingsGroup,
})

-- vim.api.nvim_create_autocmd('BufWinEnter', {
--     pattern = { '*' },
--     callback = function()
--         local no_winbar_filetypes = {
--             ['toggleterm'] = true,
--             ['qf'] = true,
--             [''] = true,
--         }
--         if no_winbar_filetypes[vim.bo.filetype] then
--             return
--         end
--
--         vim.wo.winbar = [[%{%v:lua.require'stimpack.winbar'.eval()%}]]
--     end,
--     group = generalSettingsGroup,
-- })

vim.api.nvim_create_autocmd('RecordingEnter', {
    pattern = { '*' },
    callback = function()
        -- Print notification and set win bar to another color
        MacroWinbarIdentifier = ' -- recording macro ' .. vim.fn.reg_recording()
        vim.api.nvim_set_hl(0, 'WinBar', { bg = '#33FF33', fg = '#3333ff' })
        vim.api.nvim_set_hl(0, 'WinBarNC', { bg = 'none' })
    end,
    group = generalSettingsGroup,
})

vim.api.nvim_create_autocmd('RecordingLeave', {
    pattern = { '*' },
    callback = function()
        -- Print notification and set win bar to another color
        MacroWinbarIdentifier = ''
        vim.api.nvim_set_hl(0, 'WinBar', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'WinBarNC', { bg = 'none' })
    end,
    group = generalSettingsGroup,
})

-- Set .h files as C filetype and not cpp
vim.filetype.add({ extension = { h = 'c' }, priority = 100 })
vim.filetype.add({ extension = { fsproj = 'xml' }, priority = 1 })
-- vim.filetype.add({ pattern = { ['*.fsproj'] = 'xml', priority = 5 } })
