return {
    'kosayoda/nvim-lightbulb',
    event = 'CursorMoved',
    config = function()
        require('nvim-lightbulb').setup({
            -- LSP client names to ignore
            -- Example: {"sumneko_lua", "null-ls"}
            ignore = {},
            sign = {
                enabled = true,
                -- Priority of the gutter sign
                priority = 90,
            },
            float = {
                enabled = false,
                -- Text to show in the popup float
                text = Icons.diagnostics.hint2,
                -- Available keys for window options:
                -- - height     of floating window
                -- - width      of floating window
                -- - wrap_at    character to wrap at for computing height
                -- - max_width  maximal width of floating window
                -- - max_height maximal height of floating window
                -- - pad_left   number of columns to pad contents at left
                -- - pad_right  number of columns to pad contents at right
                -- - pad_top    number of lines to pad contents at top
                -- - pad_bottom number of lines to pad contents at bottom
                -- - offset_x   x-axis offset of the floating window
                -- - offset_y   y-axis offset of the floating window
                -- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
                -- - winblend   transparency of the window (0-100)
                win_opts = {},
            },
            virtual_text = {
                enabled = false,
                -- Text to show at virtual text
                text = Icons.diagnostics.hint2,
                -- highlight mode to use for virtual text (replace, combine, blend), see :help nvim_buf_set_extmark() for reference
                hl_mode = 'replace',
            },
            status_text = {
                enabled = false,
                -- Text to provide when code actions are available
                text = Icons.diagnostics.hint2,
                -- Text to provide when no actions are available
                text_unavailable = '',
            },
        })

        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            callback = function()
                require('nvim-lightbulb').update_lightbulb()
            end,
            group = vim.api.nvim_create_augroup('lightbulb', { clear = true }),
        })
    end,
}
