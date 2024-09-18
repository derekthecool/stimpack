local toggleterm_git_level = 2

return {
    'akinsho/toggleterm.nvim', -- Awesome terminal helper in lua
    keys = {
        '⏫',
        -- Set as second git plugin use <leader>g2
        { '<leader>g' .. toggleterm_git_level, desc = 'Lazygit' },
        { '<leader>gz', desc = 'Open lazygit to dotfiles bare repo ~/.cfg' },
        { '<leader>gx', desc = 'Open plain terminal to be used for git in a new tab' },
        { '∵', desc = 'Open plain terminal to be used for git in a new tab' },
        { '`r3', desc = 'Custom toggleterm command with prompt (uses global variable TOGGLE_TERM_SAVED_COMMAND)' },
    },
    config = function()
        require('toggleterm').setup({
            size = function(term)
                if term.direction == 'horizontal' then
                    return 15
                elseif term.direction == 'vertical' then
                    return vim.o.columns * 0.4
                end
            end,
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
            -- Default to pwsh
            shell = 'pwsh',
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

        -- Arrows mapped to steno symbol right side: -RL... Inverse of tab
        vim.keymap.set('n', '⏫⏫', '<Cmd>ToggleTermToggleAll<CR>')
        vim.keymap.set('n', '▶️', '<Cmd>ToggleTermSendCurrentLine<CR>')
        -- TODO: find out why these visual lua mappings do not work like the vnoremap version
        -- 2022-10-10 I found that use vim.keymap.set and vim.api.nvim_set_keymap both have the same issue
        -- Some mappings just don't seem to work well with these two functions
        vim.cmd([[vnoremap ▶️ :ToggleTermSendVisualLines<CR>]])
        vim.cmd([[vnoremap ▶️▶️ :ToggleTermSendVisualSelection<CR>]])

        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]])
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]])
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]])
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]])
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]])
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]])
        vim.keymap.set('n', '`r3', function()
            -- Do not process when <CR> pressed in quick fix list
            if vim.bo.filetype == 'qf' then
                return
            end

            if not TOGGLE_TERM_SAVED_COMMAND then
                TOGGLE_TERM_SAVED_COMMAND = vim.fn.input('Enter command for toggleterm: ')
            end

            vim.cmd('update')
            V(string.format('Running command: %s', TOGGLE_TERM_SAVED_COMMAND))
            vim.cmd(string.format('TermExec cmd="%s"', TOGGLE_TERM_SAVED_COMMAND))
        end)

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

        local plain_git_tab = Terminal:new({
            -- cmd = 'git status --short',
            -- close_on_exit = false,
            count = 9,
            direction = 'tab',
            hidden = true,
            -- function to run on opening the terminal
            on_open = function(term)
                vim.cmd('startinsert!')
                -- For some reason these need to be out of order, newline first
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, false, true), 'i', true)
                vim.api.nvim_feedkeys('git status --short', 'i', false)
            end,
            -- function to run on closing the terminal
            on_close = function(term)
                vim.cmd('startinsert!')
            end,
        })

        local function plain_git_tab_toggle()
            plain_git_tab:toggle()
        end

        vim.keymap.set('n', '<leader>g' .. toggleterm_git_level, lazygit_toggle, { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>gz', dotfileslazygit_toggle, { noremap = true, silent = true })
        vim.keymap.set({ 'n', 'i', 's', 'c', 't' }, '∵', plain_git_tab_toggle, { silent = true, silent = true })
        vim.keymap.set({ 'n' }, '<leader>gx', plain_git_tab_toggle, { silent = true, silent = true })
    end,
}
