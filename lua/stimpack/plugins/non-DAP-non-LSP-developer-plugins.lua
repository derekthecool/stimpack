return {
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

    {
        'numToStr/Comment.nvim',
        keys = {
            { 'gc', mode = { 'n', 's', 'v' } },
            { 'gb', mode = { 'n', 's', 'v' } },
            { 'gcc', mode = { 'n', 's', 'v' } },
            { 'gbc', mode = { 'n', 's', 'v' } },
        },
        config = function()
            require('Comment').setup({
                ignore = '.*TODO',
            })
            local ft = require('Comment.ft')
            ft.cpp = { '//%s', '/*%s*/' }
            ft.ps1 = { '#%s', '<#\n%s\n#>' }
            ft.asm = ';%s'
        end,
    },

    {
        'ThePrimeagen/refactoring.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        keys = {
            { '<leader>re', mode = { 'x', 'n' }, desc = 'Refactoring extract function' },
            { '<leader>rf', mode = { 'x', 'n' }, desc = 'Refactoring extract function to file' },
            { '<leader>rv', mode = { 'x', 'n' }, desc = 'Refactoring extract variable' },
        },
        config = function()
            require('refactoring').setup({
                prompt_func_return_type = {
                    go = true,
                    java = true,
                    cpp = true,
                    c = true,
                    h = true,
                    hpp = true,
                    cxx = true,
                },
                prompt_func_param_type = {
                    go = true,
                    java = true,
                    cpp = true,
                    c = true,
                    h = true,
                    hpp = true,
                    cxx = true,
                },
                printf_statements = {},
                print_var_statements = {},
            })

            -- Extract commands support only visual mode
            vim.keymap.set('x', '<leader>re', function()
                require('refactoring').refactor('Extract Function')
            end, { desc = 'Extract Function' })
            vim.keymap.set('x', '<leader>rf', function()
                require('refactoring').refactor('Extract Function To File')
            end, { desc = 'Extract Function To File' })
            vim.keymap.set('x', '<leader>rv', function()
                require('refactoring').refactor('Extract Variable')
            end, { desc = 'Extract Variable' })

            -- Inline func supports only normal
            vim.keymap.set('n', '<leader>rI', function()
                require('refactoring').refactor('Inline Function')
            end, { desc = 'Inline Function' })

            -- Inline var supports both normal and visual mode
            vim.keymap.set({ 'n', 'x' }, '<leader>ri', function()
                require('refactoring').refactor('Inline Variable')
            end, { desc = 'Inline Variable' })

            -- Extract block supports only normal mode
            vim.keymap.set('n', '<leader>rb', function()
                require('refactoring').refactor('Extract Block')
            end, { desc = 'Extract Block' })
            vim.keymap.set('n', '<leader>rB', function()
                require('refactoring').refactor('Extract Block To File')
            end, { desc = 'Extract Block To File' })

            -- You can also use below = true here to to change the position of the printf
            -- statement (or set two remaps for either one). This remap must be made in normal mode.
            vim.keymap.set('n', '<leader>rp', function()
                require('refactoring').debug.printf({ below = false })
            end, { desc = 'Refactor Debug Print Above' })

            vim.keymap.set('n', '<leader>rP', function()
                require('refactoring').debug.printf({ below = true })
            end, { desc = 'Refactor Debug Print Below' })

            vim.keymap.set({ 'n', 'x' }, '<leader>rr', function()
                require('telescope').extensions.refactoring.refactors()
            end, { desc = 'Telescope refactor menu' })
        end,
    },

    {
        'nvim-neotest/neotest',
        enabled = true,
        keys = {
            {
                '<leader>tt',
                function()
                    require('neotest').run.run(vim.fn.expand('%'))
                end,
                desc = 'Run File',
            },
            {
                '<leader>tT',
                function()
                    require('neotest').run.run(vim.uv.cwd())
                end,
                desc = 'Run All Test Files',
            },
            {
                '<leader>tr',
                function()
                    require('neotest').run.run()
                end,
                desc = 'Run Nearest',
            },
            {
                '<leader>tl',
                function()
                    require('neotest').run.run_last()
                end,
                desc = 'Run Last',
            },
            {
                '<leader>ts',
                function()
                    require('neotest').summary.toggle()
                end,
                desc = 'Toggle Summary',
            },
            {
                '<leader>to',
                function()
                    require('neotest').output.open({ enter = true, auto_close = true })
                end,
                desc = 'Show Output',
            },
            {
                '<leader>tO',
                function()
                    require('neotest').output_panel.toggle()
                end,
                desc = 'Toggle Output Panel',
            },
            {
                '<leader>tS',
                function()
                    require('neotest').run.stop()
                end,
                desc = 'Stop',
            },
        },
        dependencies = {
            -- Plugin requirements
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'antoinemadec/FixCursorHold.nvim',

            -- Test runners
            {
                'nvim-neotest/neotest-plenary',
                -- Working on solving an issue with this plugin right now. It does not work on windows.
                -- dev = true,
            },
            'nvim-neotest/neotest-python',
            'vim-test/vim-test',
            'Issafalcon/neotest-dotnet',
            'sidlatau/neotest-dart',
        },

        log_level = vim.log.levels.TRACE,
        config = function()
            require('neotest').setup({
                adapters = {
                    require('neotest-plenary'),
                    require('neotest-dotnet'),
                    require('neotest-python'),
                    require('neotest-dart')({
                        command = 'flutter',
                        use_lsp = true,
                    }),
                },
            })

            vim.keymap.set('n', '<leader>tt', function()
                require('neotest').run.run()
            end, { silent = true, desc = 'Run neotest' })
        end,
    },

    {
        'andrewferrier/debugprint.nvim',
        enabled = false,
        -- Basic plugin settings
        -- enabled = true,
        -- cond = function()
        --    return true
        -- end,
        -- dependencies = {
        --     'other plugins to load first',
        -- },

        -- Plugin version settings
        -- branch = 'branch name',
        -- tag = 'tag name',
        -- commit = 'commit hash',
        -- version = 'semver version string',
        -- pin = true, -- if true, never update
        -- submodules = true, -- if false git submodules will not be fetched
        -- priority = 50, -- Only needed for start plugins, default 50

        -- Lazy loading settings
        -- lazy = true,
        -- event = 'VeryLazy',
        -- cmd = 'MyExCommandNameToLoadThisPlugin',
        -- ft = { 'cs', 'help', 'lua' },
        -- keys = { "<C-a>", { "<C-x>", mode = "i" } }, -- LazyKeys table

        -- Configuration
        -- opts = configuration table to be passed to plugin's setup function
        -- config = function to execute when plugin loads
        -- init = function that is always run on startup
        opts = {},
        -- Plugin development
        -- dir = 'plugin local path',
        -- dev = true,
    },
}
