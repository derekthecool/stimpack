local toggleterm_git_level = 2

return {
    'akinsho/toggleterm.nvim', -- Awesome terminal helper in lua
    keys = {
        '⏫',
        -- Set as second git plugin use <leader>g2
        { '<leader>g' .. toggleterm_git_level, desc = 'Lazygit' },
        { '<leader>gz', desc = 'Open lazygit to dotfiles bare repo ~/.cfg' },
    },
    config = function()
        require('toggleterm').setup({
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
                border = 'double',
                winblend = 0,
                highlights = {
                    border = 'Normal',
                    background = 'Normal',
                },
                width = function()
                    local win_width = vim.api.nvim_win_get_width(0)
                    local subtract_amount = 4
                    return win_width - subtract_amount
                end,
                height = function()
                    local win_height = vim.api.nvim_win_get_height(0)
                    local subtract_amount = 2
                    return win_height - subtract_amount
                end,
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

        local Terminal = require('toggleterm.terminal').Terminal
        local lazygit = Terminal:new({
            cmd = 'lazygit',
            count = 8,
            dir = 'git_dir',
            direction = 'float',
            -- function to run on opening the terminal
            on_open = function(term)
                vim.cmd('startinsert!')
                vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
            end,
            -- function to run on closing the terminal
            on_close = function(term)
                vim.cmd('startinsert!')
            end,
        })

        local function lazygit_toggle()
            lazygit:toggle()
        end

        local dotfileslazygit = Terminal:new({
            cmd = 'lazygit --git-dir=$HOME/.cfg --work-tree=$HOME',
            count = 9,
            direction = 'float',
            hidden = true,
            -- function to run on opening the terminal
            on_open = function(term)
                vim.cmd('startinsert!')
                vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
            end,
            -- function to run on closing the terminal
            on_close = function(term)
                vim.cmd('startinsert!')
            end,
        })

        local function dotfileslazygit_toggle()
            dotfileslazygit:toggle()
        end

        vim.keymap.set('n', '<leader>g' .. toggleterm_git_level, lazygit_toggle, { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>gz', dotfileslazygit_toggle, { noremap = true, silent = true })
    end,
}
