-- Configuration for my plugin
-- https://github.com/derekthecool/plover-tapey-tape.nvim
return {
    'derekthecool/plover-tapey-tape.nvim',
    event = 'CursorMoved',
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

        vim.keymap.set('n', '<leader>nt', require('plover-tapey-tape').toggle, { desc = 'Toggle plover-tapey-tape' })
    end,
}
