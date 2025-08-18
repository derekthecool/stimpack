-- Compress log lines from my serilog (csharp logging library) log files
local function set_match_and_color(name, pattern, color)
    vim.api.nvim_set_hl(0, name, color)
    vim.fn.matchadd(name, pattern)
end

set_match_and_color('Conceal', '\\v\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}.\\d{3} -\\d{2}:\\d{2}\\s', { bg = nil })
set_match_and_color('LogType_INF', '\\[INF]', { fg = '#55aa55' })
set_match_and_color('LogType_DBG', '\\[DBG]', { fg = '#55aaff' })
set_match_and_color('LogType_VER', '\\[VER]', { fg = '#dddddd' })
set_match_and_color('LogType_WAR', '\\[WAR]', { fg = '#ffff00' })
set_match_and_color('LogType_ERR', '\\[ERR]', { fg = '#ff8888', bg = '#333333' })
set_match_and_color('LogType_FTL', '\\[FTL]', { fg = '#ff0000', bg = '#333333' })

vim.wo.conceallevel = 2
vim.opt.commentstring = '# %s'
vim.wo.spell = false
vim.opt.wrap = false
