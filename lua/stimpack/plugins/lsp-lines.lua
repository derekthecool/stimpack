return {
    'Maan2003/lsp_lines.nvim',
    config = function()
        require('lsp_lines').setup()
        vim.keymap.set('', '<Leader>ll', require('lsp_lines').toggle, { desc = 'Toggle lsp_lines' })

        vim.diagnostic.config({
            virtual_lines = false,
            virtual_text = false,
        })
    end,
}
