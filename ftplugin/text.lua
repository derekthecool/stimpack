function check_file_contents_for_filetype(pattern)
    local lines = vim.api.nvim_buf_get_lines(0, 0, 100, false)
    for _, line in ipairs(lines) do
        if line:match(pattern) then
            return true
        end
    end
end

vim.defer_fn(function()
    if vim.fn.expand('%:t'):match('errlog[ab]') then
        vim.bo.filetype = 'errloga'
        -- if any of the first 100 lines matches this then also set ft to errloga
        -- 1: 2025-05-23 I (15:37:52.837) device_app: [ 1.0  ] Device ID: 45WYVF
    elseif check_file_contents_for_filetype('^%d+: [0-9-]+ [IEVDW]') then
        vim.bo.filetype = 'errloga'
    end
end, 200)
