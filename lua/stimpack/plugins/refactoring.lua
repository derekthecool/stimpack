return {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    config = function()
        require('refactoring').setup({
            prompt_func_return_type = {
                go = false,
                java = false,
                cpp = false,
                c = false,
                h = false,
                hpp = false,
                cxx = false,
            },
            prompt_func_param_type = {
                go = false,
                java = false,
                cpp = false,
                c = false,
                h = false,
                hpp = false,
                cxx = false,
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
    end,
}
