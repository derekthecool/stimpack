local fugitive_git_level = 1
return {
    'tpope/vim-fugitive',
    keys = {
        {
            -- Set as third git plugin
            '<leader>g' .. fugitive_git_level,
            '<cmd>G<CR>',
            desc = 'Vim fugitive',
        },
    },
    config = function()
        vim.api.nvim_create_autocmd('BufEnter', {
            pattern = { 'fugitive:*' },
            callback = function()
                -- Mappings to use fugitive to push and pull
                vim.keymap.set('n', '<leader>gP', ':G push<CR>', { buffer = true })
                vim.keymap.set('n', '<leader>gp', ':G pull<CR>', { buffer = true })
            end,
        })
    end,
}
