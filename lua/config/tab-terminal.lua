---Terminals that live in a tab page of their own. Snacks only knows float and
---split positions, so the terminal is opened inside a fresh tab page instead and
---whatever `:tabnew` and the split leave behind is cleaned up once it shows up.
local M = {}

---@param buf integer?
---@return integer? win first window displaying `buf`, in any tab page
function M.find_win(buf)
    if not (buf and vim.api.nvim_buf_is_valid(buf)) then
        return nil
    end
    return vim.fn.win_findbuf(buf)[1]
end

---@param tab integer tab page handle
---@param scratch integer buffer `:tabnew` created
---@param buf integer the terminal buffer that claimed the tab page
local function tidy(tab, scratch, buf)
    if not vim.api.nvim_tabpage_is_valid(tab) then
        return
    end
    local wins = vim.api.nvim_tabpage_list_wins(tab)
    local terminal_win
    for _, win in ipairs(wins) do
        if vim.api.nvim_win_get_buf(win) == buf then
            terminal_win = win
            break
        end
    end
    if not terminal_win then
        return
    end
    for _, win in ipairs(wins) do
        if win ~= terminal_win then
            pcall(vim.api.nvim_win_close, win, false)
        end
    end
    if
        vim.api.nvim_buf_is_valid(scratch)
        and vim.api.nvim_buf_get_name(scratch) == ''
        and #vim.fn.win_findbuf(scratch) == 0
    then
        pcall(vim.api.nvim_buf_delete, scratch, { force = true })
    end
end

---Run `open` in a new tab page so the terminal it opens has that tab to itself.
---The terminal can show up later than `open` returns (`:ClaudeCodeSelectModel`
---opens it from a picker callback) and Snacks only turns its buffer into a
---terminal after putting it in a window, hence the autocmd.
---@param open fun()
function M.open(open)
    vim.cmd.tabnew()
    local tab = vim.api.nvim_get_current_tabpage()
    local scratch = vim.api.nvim_get_current_buf()
    vim.api.nvim_create_autocmd({ 'TermOpen', 'BufWinEnter' }, {
        desc = 'Give a terminal opened in a new tab page that tab to itself',
        callback = function(ev)
            if not vim.api.nvim_tabpage_is_valid(tab) then
                return true
            end
            if ev.buf == scratch or (ev.event == 'BufWinEnter' and vim.bo[ev.buf].buftype ~= 'terminal') then
                return
            end
            if
                not vim.iter(vim.api.nvim_tabpage_list_wins(tab)):any(function(win)
                    return vim.api.nvim_win_get_buf(win) == ev.buf
                end)
            then
                return
            end
            vim.schedule(function()
                tidy(tab, scratch, ev.buf)
            end)
            return true
        end,
    })
    open()
end

return M
