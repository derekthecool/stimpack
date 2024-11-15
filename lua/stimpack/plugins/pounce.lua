return {
    'rlane/pounce.nvim',
    keys = { '√', '\\', 's' },
    config = function()
        local map = vim.keymap.set
        map({ 'n', 'o', 'x' }, 's', function()
            require('pounce').pounce({})
        end)
        map({ 'n', 'o', 'x' }, '\\', function()
            require('pounce').pounce({})
        end)
        -- map('n', 'S', function()
        --     require('pounce').pounce({ do_repeat = true })
        -- end)
        map('n', 'S', function()
            require('pounce').pounce({ input = { reg = '/' } })
        end)

        require('pounce').setup()
    end,
}
