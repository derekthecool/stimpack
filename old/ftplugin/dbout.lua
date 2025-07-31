local dbout_autocommands = vim.api.nvim_create_augroup('dbout_autocommands', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    pattern = '*.dbout',
    callback = function()
        vim.api.nvim_feedkeys('zR', 'n', nil)
    end,
    group = dbout_autocommands,
})

-- Conceal this text with something more cool
-- mysql: [Warning] Using a password on the command line interface can be insecure.
vim.fn.matchadd('Conceal', 'mysql:.*insecure.', nil, -1, { conceal = '🐬' })
vim.opt.conceallevel = 2
