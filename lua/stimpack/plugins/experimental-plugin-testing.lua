return {
    { 'rktjmp/fwatch.nvim' },
    {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
    },

    -- My plugins{
    -- https://github.com/derekthecool/dvp.nvim
    {
        'derekthecool/dvp.nvim',
        event = 'CursorMoved',
        config = function()
            vim.keymap.set('n', '<leader>nn', require('dvp').comma_count, { desc = 'Comma count' })
            vim.keymap.set('n', '<leader>nb', require('dvp').bit_flip, { desc = 'Bit flip' })
        end,
    },

    -- https://github.com/derekthecool/plover-tapey-tape.nvim
    {
        'derekthecool/plover-tapey-tape.nvim',
        event = 'CursorMoved',
        enabled = false, -- There are still bugs with fresh installs that I need to fix
        config = function()
            require('plover-tapey-tape').setup({
                filepath = 'auto',
                open_method = 'vsplit',
                vertical_split_height = 9,
                horizontal_split_width = 54,
                steno_capture = '|(.-)|',
                suggestion_notifications = {
                    enabled = true,
                },
                status_line_setup = {
                    enabled = true,
                    additional_filter = '(|.-|)',
                },
            })

            vim.keymap.set(
                'n',
                '<leader>nt',
                require('plover-tapey-tape').toggle,
                { desc = 'Toggle plover-tapey-tape' }
            )
        end,
    },
}
