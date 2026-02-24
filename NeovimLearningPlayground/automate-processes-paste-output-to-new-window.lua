local bufnr = 100

vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('StimpackTestRunner', { clear = true }),
    pattern = 'Program.cs',
    callback = function()
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'output of: Program.cs' })
        vim.fn.jobstart({ 'dotnet', 'test' }, {
            stdout_buffered = true,
            on_stdout = function(_, data)
                if data then
                    vim.api.nvim_set_buf_lines(bufnr, -1, -1, false, data)
                end
            end,

            on_stderr = function(_, data)
                if data then
                    vim.api.nvim_set_buf_lines(bufnr, -1, -1, false, data)
                end
            end,
        })
    end,
})
