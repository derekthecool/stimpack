return {
    {
        -- pounce is my favorite quick jumper since it works well with stenography
        -- oftentimes I can write the entire word I want to jump to quicker than 2-3 chars of that word
        -- e.g. to jump to the word 'great' with pounce I can just press my '\' keymap and then write
        -- the entire word 'great' with one single steno stroke and then press the suggestion letter to accept.
        -- To do the same thing with flash/hop and friends I would have to fingerspell several letters of the
        -- word which is much slower!
        'rlane/pounce.nvim',
        keys = { '\\' },
        config = function()
            vim.keymap.set({ 'n', 'o', 'x' }, '\\', function()
                require('pounce').pounce({})
            end)
            require('pounce').setup()
        end,
    },
    { 'echasnovski/mini.pairs', enabled = false },
    { 'folke/flash.nvim', enabled = false },
    {
        'folke/snacks.nvim',
        opts = {
            picker = {
                layout = {
                    preset = 'ivy_split',
                },
            },
        },
    },
}
