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
        },
        opts = {
            ---Add a space b/w comment and the line
            ---@type boolean|fun():boolean
            padding = true,
            ---Whether the cursor should stay at its position
            ---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
            ---@type boolean
            sticky = true,
            ---Lines to be ignored while comment/uncomment.
            ---Could be a regex string or a function that returns a regex string.
            ---Example: Use '^$' to ignore empty lines
            ---@type string|fun():string
            ignore = '.*TODO',
            ---LHS of toggle mappings in NORMAL + VISUAL mode
            ---@type table
            toggler = {
                ---Line-comment toggle keymap
                line = 'gcc',
                ---Block-comment toggle keymap
                block = 'gbc',
            },
            ---LHS of operator-pending mappings in NORMAL + VISUAL mode
            ---@type table
            opleader = {
                ---Line-comment keymap
                line = 'gc',
                ---Block-comment keymap
                block = 'gb',
            },
            ---LHS of extra mappings
            ---@type table
            extra = {
                ---Add comment on the line above
                above = 'gcO',
                ---Add comment on the line below
                below = 'gco',
                ---Add comment at the end of line
                eol = 'gcA',
            },
            ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
            ---@type table
            mappings = {
                ---Operator-pending mapping
                ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
                ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
                basic = true,
                ---Extra mapping
                ---Includes `gco`, `gcO`, `gcA`
                extra = true,
                ---Extended mapping
                ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
                extended = false,
            },
            ---Pre-hook, called before commenting the line
            ---@type fun(ctx: Ctx):string
            pre_hook = nil,
            ---Post-hook, called after commenting is done
            ---@type fun(ctx: Ctx)
            post_hook = nil,
        },
    },

    {
        'ThePrimeagen/refactoring.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        keys = {
            { '<leader>re', desc = 'Refactoring' },
            { '<leader>rf', desc = 'Refactoring' },
            { '<leader>rv', desc = 'Refactoring' },
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
            end, { desc = 'Refactor Debug Print Above' })
        end,
    },

    {
        'nvim-neotest/neotest',
        enabled = false,
        -- Basic plugin settings
        -- enabled = true,
        -- cond = function()
        --    return true
        -- end,
        dependencies = {
            -- Plugin requirements
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'antoinemadec/FixCursorHold.nvim',

            -- Test runners
            {
                'nvim-neotest/neotest-plenary',
                -- Working on solving an issue with this plugin right now. It does not work on windows.
                dev = true,
            },
            -- 'nvim-neotest/neotest-vim-test',
            'vim-test/vim-test',
            'Issafalcon/neotest-dotnet',
        },
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

        config = function()
            require('neotest').setup({
                adapters = {
                    require('neotest-plenary'),
                    require('neotest-dotnet'),
                    require('neotest-vim-test')({
                        ignore_file_types = { 'python', 'vim', 'lua' },
                    }),
                },
            })
        end,
        -- Plugin development
        -- dir = 'plugin local path',
        -- dev = true,
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
