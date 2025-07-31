vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = '*errlogpool*.txt',
    callback = function()
        vim.opt.filetype = 'errlogpool'
    end,
    group = vim.api.nvim_create_augroup('errlogpool', { clear = true }),
})
