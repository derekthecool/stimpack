return {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
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
}
