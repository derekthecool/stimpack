vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { 'BelleLTE_DataLog*.txt', 'debug-logs-*.log', 'debug-logs-*.txt' },
    callback = function()
        vim.opt.filetype = 'mcn_device_logs'
    end,
    group = vim.api.nvim_create_augroup('mcn_device_logs', { clear = true }),
})
