-- 2022-07-15 10:30:30.585 -06:00 [DBG] ExtBootloader, fota udpate return 2
vim.b.current_syntax = 'mcn_device_logs'

vim.wo.conceallevel = 2

-- Basic regex matches
vim.fn.matchadd('log_linenumber', '\\d\\+:')
vim.fn.matchadd('log_string', '".+\\{-}"')
vim.fn.matchadd('log_number', '0x[0-9a-fA-F]*\\|\\[<[0-9a-f]\\+>\\]\\|\\<\\d[0-9a-fA-F]*')
vim.fn.matchadd('log_date', '\\(Jan\\|Feb\\|Mar\\|Apr\\|May\\|Jun\\|Jul\\|Aug\\|Sep\\|Oct\\|Nov\\|Dec\\) [ 0-9]\\d *')
vim.fn.matchadd('log_date', '\\d\\{4}-\\d\\d-\\d\\d')
vim.fn.matchadd('log_time', '\\d\\d:\\d\\d:\\d\\d\\.\\d\\{3}\\s-\\d\\+:\\d\\+')

-- Section custom to Micron Device Log files
vim.fn.matchadd('log_error', '\\[\'Warning:data, or topic is empty;please check your report or data conversion\\]')
vim.fn.matchadd('log_error', 'ERROR')
vim.fn.matchadd('log_error', 'ERROR')
vim.fn.matchadd('log_error', 'Error encoding.*')
vim.fn.matchadd('ATcommand', '\\v(AT|at)[+#].*')
vim.fn.matchadd('ATcommandOK', 'OK')
vim.fn.matchadd('log_keywords', '+RESP.*')
vim.fn.matchadd('FA', 'FA:[^,]\\+')
vim.fn.matchadd('FA_post', 'FA:[^,]\\+, \\zs.*')
vim.fn.matchadd('log_keywords', 'MTrecv:.*')
vim.fn.matchadd('log_keywords', 'MTpub:.*')
vim.fn.matchadd('debugInit', '+EIND: 128')
vim.fn.matchadd('debugInit', 'AT+TRDEBUG')
vim.fn.matchadd('debugInit', '+TRDEBUG:ON')
vim.fn.matchadd('log_hexBlobs', '{\\w\\+}')

-- Set the highlight colors used
vim.api.nvim_set_hl(0, 'log_string', { link = 'String' })
vim.api.nvim_set_hl(0, 'log_number', { link = 'Number' })
vim.api.nvim_set_hl(0, 'log_date', { link = 'Type' })
vim.api.nvim_set_hl(0, 'log_time', { link = 'Type' })
vim.api.nvim_set_hl(0, 'log_error', { link = 'Error' })
vim.api.nvim_set_hl(0, 'log_debug', { link = 'Directory' })
vim.api.nvim_set_hl(0, 'log_info', { link = 'SpecialKey' })
vim.api.nvim_set_hl(0, 'log_keywords', { link = 'Directory' })
vim.api.nvim_set_hl(0, 'log_linenumber', { link = 'MoreMsg' })
vim.api.nvim_set_hl(0, 'ATcommand', { bg = '#5fd700', fg = '#000000' })
vim.api.nvim_set_hl(0, 'ATcommandOK', { bg = '#000ff0', fg = '#00FF00' })
vim.api.nvim_set_hl(0, 'DebugInit', { bg = '#0000FF', fg = '#FFFFFF' })
vim.api.nvim_set_hl(0, 'log_hexBlobs', { fg = '#aaccff' })
vim.api.nvim_set_hl(0, 'FA', { fg = '#552255' })
vim.api.nvim_set_hl(0, 'FA_post', { fg = '#5566cc' })

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
