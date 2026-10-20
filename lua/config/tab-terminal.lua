---Terminals that live in a tab page of their own. Snacks only knows float and
---split positions, so the terminal is opened inside a fresh tab page instead and
---whatever `:tabnew` leaves behind is cleaned up once the terminal shows up.
---
---A terminal has to be opened at the size it will keep: Snacks starts the job as
---soon as the window exists, so a window that is grown afterwards resizes the pty
---under a TUI that has already drawn itself. Claude survives that badly -- text
---comes back erased and the next render stays inside the old, smaller geometry.
---Hence `position = 'current'` at every call site, and `leave()` instead of a hide
---that would close the window and force the whole thing to be rebuilt.
local M = {}

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

---Claim a new tab page for a terminal that is about to open. The terminal can show
---up later than the call that opens it returns (`:ClaudeCodeSelectModel` opens it
---from a picker callback) and Snacks only turns its buffer into a terminal after
---putting it in a window, hence the autocmd.
function M.claim()
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
end

---Run `open` in a tab page of its own.
---@param open fun()
function M.open(open)
    M.claim()
    open()
end

---Step out of a terminal's tab page back to the one it was opened from, leaving the
---terminal window -- and so the size the running program drew itself at -- alone.
function M.leave()
    local previous = vim.fn.tabpagenr('#')
    if previous > 0 and previous ~= vim.fn.tabpagenr() and previous <= vim.fn.tabpagenr('$') then
        vim.cmd(previous .. 'tabnext')
    elseif vim.fn.tabpagenr('$') > 1 then
        vim.cmd.tabprevious()
    end
end

return M
