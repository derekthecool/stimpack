-- My plugin
-- https://github.com/derekthecool/dvp.nvim
return {
    'derekthecool/dvp.nvim',
    event = 'VeryLazy',
    config = function()
        vim.keymap.set('n', '<leader>nn', require('dvp').comma_count, { desc = 'Comma count' })
        vim.keymap.set('n', '<leader>nb', require('dvp').bit_flip, { desc = 'Bit flip' })
    end,
}
