-- TODO: replace it these vim.cmd calls with lua ASAP

vim.cmd [[
" Set the filetype and also delete any <CR> (or \r) characters
autocmd BufNewFile,BufRead BelleLTE_DataLog*.txt,debug-logs-*.log,debug-logs-*.txt set filetype=mcn_device_logs
]]
