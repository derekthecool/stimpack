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

-- Terminals come back in the state they were left in. Neovim drops out of terminal
-- mode whenever you switch away, and the `auto_insert` of both Snacks and claudecode
-- (turned off in the plugin specs) answered that by forcing insert at the bottom of
-- the scrollback, losing wherever you were reading. Remember why terminal mode was
-- left instead: leaving the window keeps it pending, a deliberate <C-\><C-n> does not.
local terminalGroup = vim.api.nvim_create_augroup('Terminal state', { clear = true })

vim.api.nvim_create_autocmd('TermOpen', {
    group = terminalGroup,
    callback = function(ev)
        vim.b[ev.buf].terminal_insert = true
        -- A terminal you opened yourself is ready to type in; one that opened in the
        -- background keeps its hands off the mode. `nvim_buf_call` makes a buffer
        -- current without a window of its own, so let the dust settle first.
        vim.schedule(function()
            if vim.api.nvim_buf_is_valid(ev.buf) and vim.api.nvim_get_current_buf() == ev.buf then
                vim.cmd.startinsert()
            end
        end)
    end,
})

vim.api.nvim_create_autocmd('TermEnter', {
    group = terminalGroup,
    callback = function(ev)
        vim.b[ev.buf].terminal_insert = true
    end,
})

vim.api.nvim_create_autocmd('TermLeave', {
    group = terminalGroup,
    callback = function(ev)
        -- Switching window or tab leaves terminal mode too, so wait a tick: only
        -- stepping into normal mode on purpose leaves us standing in the terminal.
        vim.schedule(function()
            if vim.api.nvim_buf_is_valid(ev.buf) and vim.api.nvim_get_current_buf() == ev.buf then
                vim.b[ev.buf].terminal_insert = false
            end
        end)
    end,
})

vim.api.nvim_create_autocmd('BufEnter', {
    group = terminalGroup,
    callback = function(ev)
        if vim.bo[ev.buf].buftype == 'terminal' and vim.b[ev.buf].terminal_insert then
            vim.cmd.startinsert()
        end
    end,
})
