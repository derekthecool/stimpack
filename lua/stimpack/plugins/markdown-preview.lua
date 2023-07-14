return {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
    config = function()
        -- vim.g.mkdp_browser = 'vieb'

        vim.keymap.set('n', '<leader>fM', function()
            vim.cmd('MarkdownPreviewToggle')
        end, { silent = true, desc = 'MarkdownPreviewToggle' })
    end,
}
