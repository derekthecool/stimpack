-- Compress log lines from my serilog (csharp logging library) log files
-- 2022-07-18 11:04:07.346 -06:00 [INF]
vim.api.nvim_set_hl(0, 'conceallLogLine', { bg = nil })
vim.cmd([[
syntax match  conceallLogLine '\v\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}.\d{3} -\d{2}:\d{2}\s' conceal
]])

vim.wo.conceallevel = 2
