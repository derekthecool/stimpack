local M = {}

M.save_paragraph = function()
    -- Prompt for name of file
    vim.fn.input('Name of output file: ')

    -- Select paragraph
    -- vim.api.nvim_feedkeys('vip<esc>', 'n', true)
    -- TODO: (Derek Lomax) 1/18/2024 3:14:48 PM, Use this filter better to extract all important Micron log data
    -- g/\(\d atd\d\+\|MTpub\|MTrecv\|SOCKET_\|-#CALL\|CONNECTED\)/y A
    -- g/\(+RESP:ST...\|\d atd\d\+\|MTpub\|MTrecv\|SOCKET_\|-#CALL\|CONNECTED\)/y A

    V(vim.fn.getreg('+'))
end

return M
