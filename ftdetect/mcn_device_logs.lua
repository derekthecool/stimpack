vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { 'BelleLTE_DataLog*.txt', 'debug-logs-*.log', 'debug-logs-*.txt' },
    callback = function()
        vim.opt.filetype = 'mcn_device_logs'

        -- Disable animations
        vim.b.minianimate_disable = true

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
