return {
    {
        'derekthecool/plover-tapey-tape.nvim',
        event = 'VeryLazy',
        keys = {

            {
                '<leader>pt',
                function()
                    require('plover-tapey-tape').toggle()
                end,
                desc = 'Toggle plover tapey tape',
            },
            {
                '<leader>ps',
                function()
                    require('plover-tapey-tape').stop()
                end,
                desc = 'Stop plover tapey tape',
            },
        },
        -- ~/neovim/neotest-pester/
        dev = true,
    },
}
