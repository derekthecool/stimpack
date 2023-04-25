return {
    'glepnir/template.nvim',
    config = function()
        vim.keymap.set('n', '<leader>fT', ':Telescope find_template<CR>', { silent = true })

        require('template').setup({
            temp_dir = OS.join_path( vim.fn.stdpath('config'), 'template.nvim_templates' ),
            author = 'Derek Lomax',
            email = 'derekthecool@gmail.com',
            project = {
                ['test'] = {
                    ['lang'] = {
                        ['lua'] = {
                            ['lua'] = {
                                'plugin.lua',
                            },
                            ['tests'] = {
                                'plugin_spec.lua',
                            },
                        },
                    },
                },
            },
        })
    end,
}
