local status_ok, toggleterm = pcall(require, 'toggleterm')
if not status_ok then
    return
end

toggleterm.setup({
    size = 20,
    open_mapping = '⏫',
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = 'horizontal',
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = 'curved',
        winblend = 0,
        highlights = {
            border = 'Normal',
            background = 'Normal',
        },
    },
})

local map = require('stimpack.mapping-function')

-- Arrows mapped to steno symbol right side: -RL... Inverse of tab
map('n', '⏫⏫', '<Cmd>ToggleTermToggleAll<CR>')
map('n', '▶️', '<Cmd>ToggleTermSendCurrentLine<CR>')
-- TODO: find out why these visual lua mappings do not work like the vnoremap version
-- 2022-10-10 I found that use vim.keymap.set and vim.api.nvim_set_keymap both have the same issue
-- Some mappings just don't seem to work well with these two functions
vim.cmd([[vnoremap ▶️ :ToggleTermSendVisualLines<CR>]])
vim.cmd([[vnoremap ▶️▶️ :ToggleTermSendVisualSelection<CR>]])

map('t', '<C-k>', [[<Cmd>wincmd k<CR>]])
map('t', '<C-l>', [[<Cmd>wincmd l<CR>]])
map('t', '<C-h>', [[<Cmd>wincmd h<CR>]])
map('t', '<C-j>', [[<Cmd>wincmd j<CR>]])
map('t', '<C-k>', [[<Cmd>wincmd k<CR>]])
map('t', '<C-l>', [[<Cmd>wincmd l<CR>]])
