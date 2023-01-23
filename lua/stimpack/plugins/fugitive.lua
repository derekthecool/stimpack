return {
    'tpope/vim-fugitive',
    keys = { {
        '<leader>ggs',
        '<cmd>G<CR>',
        desc = 'Vim fugitive',
    } },
    config = function()
        function config()
            vim.keymap.set('n', 'Pp', ':G push', { silent = true, buffer = true })
            vim.keymap.set('n', 'pp', ':G pull', { silent = true, buffer = true })
        end

        vim.defer_fn(config, 1000)
    end,
}
