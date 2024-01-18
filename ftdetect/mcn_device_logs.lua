-- Define the patterns to match
local patterns_to_match = {
    'MTpub',
    'tcpreceive',
    'MTrecv',
    'MQTT',
    'FA:',
    'F1:',
}

-- Function to determine if a line should be folded
function mcn_fold_lines()
    local total_lines = vim.api.nvim_buf_line_count(0)

    local matching_lines = {}

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for index, line in ipairs(lines) do
        -- local fold = true

        for _, pattern in ipairs(patterns_to_match) do
            if string.find(line, pattern) then
                table.insert(matching_lines, index + 1)
            end
        end
    end

    local fold_start = 0
    fold_points = {}
    for i = 1, #matching_lines do
        -- fold_end = matching_lines[i] - 2
        -- vim.cmd(string.format("%d,%d fold", fold_start, fold_end))
        -- fold_start = fold_end + 1
        local fold_end = matching_lines[i] - 1
        if math.abs(fold_start - fold_end) >= 5 then
            table.insert(fold_points, { fold_start, fold_end })

            vim.cmd(string.format('%d,%d fold', fold_start, fold_end))
        end
        fold_start = matching_lines[i]
    end

    vim.print(matching_lines)
    vim.print(fold_points)
end

-- -- Execute fold_lines when the buffer is loaded
-- vim.api.nvim_exec(
--     [[
--     augroup fold_lines
--         autocmd!
--         autocmd BufReadPost * lua fold_lines()
--     augroup END
-- ]],
--     false
-- )

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { 'BelleLTE_DataLog*.txt', 'debug-logs-*.log', 'debug-logs-*.txt' },
    callback = function()
        vim.opt.filetype = 'mcn_device_logs'

        -- Disable animations
        vim.b.minianimate_disable = true

        -- Easily start searching for any of these items
        vim.keymap.set('n', '<leader>nm', function()
            local search_string = table.concat(patterns_to_match, '|')
            vim.cmd(string.format('\v%s', search_string))
        end, { silent = true, desc = 'mcn search' })

        -- TODO: move this to a stimpack booster with custom options to make it easy to scan any file

        vim.keymap.set('n', '<leader>lL', function()
            -- Create namespace and clear it so old errors go away
            local namespace = vim.api.nvim_create_namespace('LogErrorChecker')
            local buffer_number = 0
            vim.api.nvim_buf_clear_namespace(buffer_number, namespace, 0, -1)

            -- Check every line for similar errors
            -- Match this one
            -- 2023-06-12 12:36:21.555 -06:00 [DBG] +CME ERROR: 4
            -- Don't match this one
            -- 2023-06-12 12:36:21.557 -06:00 [DBG] TelitParser_ResultCodes-+CME ERROR: 4,13,curr_part=0,total_part=1    T:(12:33:22)
            local lines = vim.api.nvim_buf_get_lines(buffer_number, 0, -1, false)
            local diagnostic_error_list = {}
            for linenumber, line in ipairs(lines) do
                local error = line:match('%+CME ERROR: (%d+)$')
                if error then
                    -- vim.notify('error = ' .. (error or 'nil'), vim.log.levels.INFO, { title = 'Stimpack Notification' })
                    local diagnostic_message = {
                        bufnr = buffer_number,
                        lnum = linenumber - 1,
                        col = 0,
                        severity = vim.diagnostic.severity.ERROR,
                        source = 'LogErrorChecker',
                        message = string.format('CME Error %s', error),
                        user_data = {},
                    }
                    table.insert(diagnostic_error_list, diagnostic_message)
                end
            end
            vim.diagnostic.set(namespace, buffer_number, diagnostic_error_list, {})
        end, { silent = true, desc = 'LogErrorChecker find CME errors', buffer = true })
    end,
    group = vim.api.nvim_create_augroup('mcn_device_logs', { clear = true }),
})
