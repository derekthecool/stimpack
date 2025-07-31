local M = {}

M.crush_current_line = function(buffer)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)

    print(string.format('crush buffer number is = %d', buffer))
    print(string.format('Line is = %s, cursor is = %d,%d', vim.inspect(lines), cursor[1], cursor[2]))
    -- lines[1] = lines[1]:gsub('^wwww', 'xxxx')
    local replacement = lines
    vim.api.nvim_buf_set_lines(buffer, cursor[1], cursor[1], false, replacement)
end

return M
