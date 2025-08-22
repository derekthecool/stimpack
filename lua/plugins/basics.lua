return {
    {
        'rlane/pounce.nvim',
        keys = { '\\' },
        config = function()
            vim.keymap.set({ 'n', 'o', 'x' }, '\\', function()
                require('pounce').pounce({})
            end)
            require('pounce').setup()
        end,
    },
    {
        'echasnovski/mini.pairs',
        enabled = false,
    },
}
