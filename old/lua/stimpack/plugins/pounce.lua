return {
    'rlane/pounce.nvim',
    keys = { '\\' },
    config = function()
        local map = vim.keymap.set
        map({ 'n', 'o', 'x' }, '\\', function()
            require('pounce').pounce({})
        end)
        require('pounce').setup()
    end,
}
