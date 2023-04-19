return {
    'Maan2003/lsp_lines.nvim',
    init = function()
        vim.keymap.set('', '<Leader>ll', require('lsp_lines').toggle, { desc = 'Toggle lsp_lines' })
    end,
    opts = {},
}
