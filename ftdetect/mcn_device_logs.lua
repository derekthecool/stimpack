-- Define the patterns to match
-- local log_level = vim.diagnostic.severity.ERROR
local patterns_to_match = {
    { pattern = 'MTpub',                                  level = vim.diagnostic.severity.INFO },
    { pattern = 'tcpreceive',                             level = vim.diagnostic.severity.INFO },
    { pattern = 'MTrecv',                                 level = vim.diagnostic.severity.INFO },
    { pattern = 'MQTT',                                   level = vim.diagnostic.severity.INFO },
    { pattern = 'FA:',                                    level = vim.diagnostic.severity.INFO },
    { pattern = 'F1:',                                    level = vim.diagnostic.severity.INFO },
    { pattern = 'writeid',                                level = vim.diagnostic.severity.INFO },
    { pattern = 'CME Error',                              level = vim.diagnostic.severity.ERROR },
    { pattern = 'PA30B?V01[._]01B%d%d %d%d%d%d',          level = vim.diagnostic.severity.INFO },
    { pattern = 'AT start.*AT#MQ',                        level = vim.diagnostic.severity.INFO },

    -- Fota
    { pattern = 'enter rsfota',                           level = vim.diagnostic.severity.INFO },
    { pattern = 'AT%+STRTO=PA30,8',                       level = vim.diagnostic.severity.INFO },
    { pattern = '%+ACK:STRTO.*FOTA',                      level = vim.diagnostic.severity.INFO },
    { pattern = 'Content-Range: bytes',                   level = vim.diagnostic.severity.INFO },
    { pattern = 'TrackerPa23ReportSTHFS:',                level = vim.diagnostic.severity.INFO },
    { pattern = 'send %(fota.redstone.net.cn%) complete', level = vim.diagnostic.severity.INFO },
}

local function log_lsp_scanner(input_patterns)
    V('Scanning patterns')
    -- Create namespace and clear it so old errors go away
    local source = 'LogErrorChecker'
    local namespace = vim.api.nvim_create_namespace(source)
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
        for _, pattern_input_item in pairs(input_patterns) do
            local match_found = line:match(pattern_input_item.pattern)

            if match_found then
                local diagnostic_message = {
                    bufnr = buffer_number,
                    lnum = linenumber - 1,
                    col = 0,
                    severity = pattern_input_item.level,
                    source = source,
                    -- message = string.format('CME Error %s', match_found),
                    message = '',
                    user_data = {},
                }
                table.insert(diagnostic_error_list, diagnostic_message)
            end
        end
    end
    vim.diagnostic.set(namespace, buffer_number, diagnostic_error_list, {})
end

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

vim.api.nvim_create_autocmd({ 'BufRead' }, {
    pattern = { 'BelleLTE_DataLog*.txt', 'debug-logs-*.log', 'debug-logs-*.txt' },
    callback = function()
        vim.opt.filetype = 'mcn_device_logs'

        if vim.b.did_run then
            -- Exit early if command has already run
            return
        end

        vim.b.did_run = 1

        -- Disable animations
        vim.b.minianimate_disable = true

        -- Easily start searching for any of these items
        vim.keymap.set('n', '<leader>nm', function()
            local function startSearch(text)
                -- Escape any special characters in the search text
                -- local escapedText = vim.fn.escape(text, '/')
                -- Construct the search command
                local searchCommand = '/\\v' .. text .. '\n'
                -- Send the search command
                vim.fn.feedkeys(searchCommand, 'n')
            end
            local search_string = table.concat(patterns_to_match, '|')
            -- vim.cmd(string.format('\\v(%s)', search_string))
            startSearch(search_string)
        end, { silent = true, desc = 'mcn search' })

        -- TODO: move this to a stimpack booster with custom options to make it easy to scan any file

        vim.keymap.set('n', '<leader>lL', function()
            log_lsp_scanner(patterns_to_match)
        end, { silent = true, desc = 'LogErrorChecker find CME errors', buffer = true })

        log_lsp_scanner(patterns_to_match)
    end,
    group = vim.api.nvim_create_augroup('mcn_device_logs', { clear = true }),
})
