-- https://github.com/neovim/neovim/issues/1380
-- That example showed how to create a vim command, I don't need it but it is a good example
-- vim.api.nvim_command("command! -nargs=0 Watch call luaeval('WatchFile(_A[1], _A[2])', [bufnr('%'), expand('%:p')])")
local w = vim.loop.new_fs_poll()
local formatted_tail_string = '👀📄👀'
WatchFileJumpToEnd = formatted_tail_string

local function on_change(bufNr, filePath)
    vim.api.nvim_command('checktime ' .. bufNr)
    w:stop()
    WatchFile(bufNr, filePath)
end

function WatchFile(bufNr, filePath)
    w:start(
        filePath,
        1000,
        vim.schedule_wrap(function(...)
            on_change(bufNr, filePath)

            -- Jump to end of line
            if WatchFileJumpToEnd == formatted_tail_string then
                -- Lua API method to jump to end of file
                vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(0), 0 })
            end
        end)
    )
end

function ToggleFileWatchTailing()
    if WatchFileJumpToEnd == formatted_tail_string then
        WatchFileJumpToEnd = ''
    else
        WatchFileJumpToEnd = formatted_tail_string
    end
end

local fileWatcherSettings = vim.api.nvim_create_augroup('FileWatcherSettings', { clear = true })
-- vim.api.nvim_create_autocmd("BufRead *", { command = "Watch", group = fileWatcherSettings })
vim.api.nvim_create_autocmd('BufRead *', {
    callback = function()
        WatchFile(vim.api.nvim_get_current_buf(), vim.fn.expand('%:p'))
    end,
    group = fileWatcherSettings,
})
