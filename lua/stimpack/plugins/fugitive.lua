return {
    'tpope/vim-fugitive',
    keys = { {
        '<leader>gf',
        '<cmd>G<CR>',
        desc = 'Vim fugitive',
    } },
    config = function()
        local function deferredConfigFunction()
            vim.keymap.set('n', 'Pp', ':G push<CR>', { silent = true, buffer = true })
            vim.keymap.set('n', 'pp', ':G pull<CR>', { silent = true, buffer = true })
        end

        vim.defer_fn(deferredConfigFunction, 1000)
    end,
}