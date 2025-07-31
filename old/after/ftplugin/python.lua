-- Use a to delay to load this later. Something is over writing the value.
vim.defer_fn(function()
    vim.bo.textwidth = 300
end, 2000)
