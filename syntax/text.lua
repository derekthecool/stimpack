-- TODO: replace it these vim.cmd calls with lua ASAP

-- Compress log lines from my serilog log files
-- 2022-07-18 11:04:07.346 -06:00 [INF]
vim.cmd [[
syntax match  conceallLogLine '\v\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}.\d{3} -\d{2}:\d{2}\s' conceal

setlocal conceallevel=2
hi conceallLogLine guibg=NONE
]]
