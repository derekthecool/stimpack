local log_diagnostic_reaper = {}

log_diagnostic_reaper.setup = function(opts) end

log_diagnostic_reaper.reap = function()
    -- Create namespace and clear it so old errors go away
    local namespace_name = 'stimpack-log-diagnostic-reaper'
    local namespace = vim.api.nvim_create_namespace(namespace_name)
    local buffer_number = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_clear_namespace(buffer_number, namespace, 0, -1)

    -- Check every line for similar errors
    -- Match this one
    -- 2023-06-12 12:36:21.555 -06:00 [DBG] +CME ERROR: 4
    -- Don't match this one
    -- 2023-06-12 12:36:21.557 -06:00 [DBG] TelitParser_ResultCodes-+CME ERROR: 4,13,curr_part=0,total_part=1    T:(12:33:22)
    local lines = vim.api.nvim_buf_get_lines(buffer_number, 0, -1, false)
    local diagnostic_list = {}
    for linenumber, line in ipairs(lines) do
        local error = line:match('%+CME ERROR: (%d+)$')
        if error then
            local diagnostic_message = {
                bufnr = buffer_number,
                lnum = linenumber - 1,
                col = 0,
                severity = vim.diagnostic.severity.ERROR,
                source = namespace_name,
                message = string.format('CME Error %s', error),
                user_data = {},
            }
            table.insert(diagnostic_list, diagnostic_message)
        end
    end
    vim.diagnostic.set(namespace, buffer_number, diagnostic_list, {})
end

return log_diagnostic_reaper
