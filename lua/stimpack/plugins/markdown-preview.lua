return {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
    -- keys = {
    --     '<leader>fM',
    -- },
    config = function()
        vim.keymap.set('n', '<leader>fM', function()
            vim.cmd('MarkdownPreviewToggle')
        end, { silent = true, desc = 'MarkdownPreviewToggle' })

        vim.g.mkdp_filetypes = { 'markdown', 'vimwiki' }
        vim.g.mkdp_theme = 'light'
    end,
}
