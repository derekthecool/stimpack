local function NavigationFloatingWin()
    -- get the editor's max width and height
    local width = vim.api.nvim_get_option('columns')
    local height = vim.api.nvim_get_option('lines')

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')

    local opts = {
        relative = 'editor',
        width = 10,
        height = 5,
        row = 1,
        col = width,
    }

    -- create a new floating window, centered in the editor
    local win = vim.api.nvim_open_win(buf, true, opts)
    return win
end

local win = vim.api.nvim_get_current_win()
local floating_win = NavigationFloatingWin()
if vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_set_current_win(win)
end

local floating_windows = vim.api.nvim_create_augroup('floating_windows', { clear = true })
vim.api.nvim_create_autocmd('CursorMoved', {
    pattern = { '*.lua' },
    callback = function()
        local buf
        if vim.api.nvim_win_is_valid(floating_win) then
            buf = vim.api.nvim_win_get_buf(floating_win)
        else
            vim.api.nvim_del_augroup_by_id(floating_windows)
            return
        end
        local line = vim.api.nvim_win_get_cursor(0)
        -- Possible show the node under cursor by copying this command from the treesitter play ground
        -- https://github.com/nvim-treesitter/playground/blob/2b81a018a49f8e476341dfcb228b7b808baba68b/lua/nvim-treesitter-playground/hl-info.lua#L81
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, { string.format('%d, %d', line[1], line[2]), 'test' })
    end,
    group = floating_windows,
})
