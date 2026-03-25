return {
    {
        'nvim-neotest/neotest',
        dependencies = {
            {
                'derekthecool/neotest-pester',
                -- Development location ~/neovim/neotest-pester/
                dev = true,
            },
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'antoinemadec/FixCursorHold.nvim',
            'nvim-treesitter/nvim-treesitter',

            'nvim-neotest/neotest-plenary',
            'nvim-neotest/neotest-python',
            'vim-test/vim-test',
            'nsidorenco/neotest-vstest',
            'sidlatau/neotest-dart',
        },
        opts = {
            adapters = {
                ['neotest-plenary'] = {},
                ['neotest-python'] = {},
                ['neotest-vstest'] = {},
                ['neotest-dart'] = {},
                ['neotest-pester'] =
                    ---@type neotest-pester.Config
                    {
                        pwsh_path = 'pwsh',
                        ---@type PesterConfiguration
                        pester_configuration = {
                            Output = { Verbosity = 'Detailed' },
                            ---@type PesterConfiguration.Filter
                            Filter = {
                                FullName = { '.*þ.*' },
                            },
                        },
                    },
            },
            log_level = vim.log.levels.TRACE,
        },
    },
    { 'nvim-mini/mini.test', version = '*', opts = {} },
    {
        'rafcamlet/nvim-luapad',
        -- To jump to the printed preview window, use ^w w
        keys = {
            {
                '<leader>dV',
                function()
                    require('luapad').toggle()
                end,
                desc = 'Luapad neovim interactive buffer',
            },
        },
        opts = {
            count_limit = 150000,
            error_indicator = true,
            eval_on_move = true,
            error_highlight = 'TSQueryLinterError',
            print_highlight = 'DevIconMotoko',
            split_orientation = 'vertical',
            on_init = function()
                print('Hello from Luapad!')
            end,
            context = {
                the_answer = 42,
                shout = function(str)
                    return (string.upper(str) .. '!')
                end,
            },
        },
    },
}
