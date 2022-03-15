-- This file is designed to set custom syntax to files in a certain location
-- without an extension
vim.cmd "autocmd BufRead $HOME/.config/neomutt/* setlocal syntax=neomuttrc"

-- Set syntax for files in /tmp/* to have .sh syntax. This is to be used with
-- bash/zsh vi mode editing commands in vim to get auto completion help
-- autocmd BufRead,BufNewFile /tmp/* setlocal syntax=sh
vim.cmd "autocmd BufRead /tmp/zsh* setlocal filetype=sh setlocal syntax=sh"

-- TODO: remap errlogpool into a plugin
-- vim.cmd "au BufNewFile,BufRead *errlogpool*.txt set filetype=errlogpool"
-- vim.cmd "au BufNewFile,BufRead BelleLTE_DataLog*.txt set filetype=mcn_device_logs"
