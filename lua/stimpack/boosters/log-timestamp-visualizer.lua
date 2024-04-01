local M = {}

---@class DateTimeTable
---@field year number the current year
---@field month number the current month
---@field day number the current day
---@field hour number the current hour
---@field min number the current min
---@field sec number the current sec
---@field msec number the current msec
---@field tzoffset number the current time zone offset in seconds

---@param line string the input date time string
---@return DateTimeTable
M.parse_time_string = function(line)
    local pattern = '(%d+)%-(%d+)%-(%d+) (%d+):(%d+):(%d+).(%d+) ([+-]%d+):(%d+)'
    local year, month, day, hour, min, sec, msec, tzHour, tzMin = line:match(pattern)

    return {
        year = tonumber(year),
        month = tonumber(month),
        day = tonumber(day),
        hour = tonumber(hour),
        min = tonumber(min),
        sec = tonumber(sec),
        msec = tonumber(msec),
        tzOffset = tonumber(tzHour) * 60 + tonumber(tzMin), -- Time zone offset in minutes
    }
end

---@param dateTimeString1 DateTimeTable
---@param dateTimeString2 DateTimeTable
---@return number the difference in time between the two inputs
M.dateTimeDifferenceSeconds = function(dateTimeString1, dateTimeString2)
    -- Convert both dates to seconds
    local function toSeconds(dt)
        return os.time({
            year = dt.year,
            month = dt.month,
            day = dt.day,
            hour = dt.hour,
            min = dt.min,
            sec = dt.sec,
        }) + dt.msec / 1000 - dt.tzOffset * 60
    end

    local seconds1 = toSeconds(dateTimeString1)
    local seconds2 = toSeconds(dateTimeString2)

    -- Return the difference in seconds
    return seconds2 - seconds1
end

-- Parses all datetime strings in the file and loads virtual text
M.parseFileAndLoadVirtualText = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local previousLine = nil

    -- Clear namespace once before updating virtual texts
    local namespace = vim.api.nvim_create_namespace('log-timestamp-visualizer')
    vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)

    for index, line in ipairs(lines) do
        if index > 1 then -- Skip the first line
            local parsedLine = M.parse_time_string(line)
            local parsedPreviousLine = M.parse_time_string(previousLine)
            if parsedLine and parsedPreviousLine then
                local difference = M.dateTimeDifferenceSeconds(parsedPreviousLine, parsedLine)

                vim.api.nvim_buf_set_extmark(bufnr, namespace, index - 2, 0, {
                    virt_lines_above = true,
                    virt_lines = { { { string.format('TD: %f seconds', difference), 'DevIconPy' } } },
                })
            end
        end
        previousLine = line
    end
end

M.clearVirtualText = function()
    -- Clear namespace
    local namespace = vim.api.nvim_create_namespace('log-timestamp-visualizer')
    vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)
end

vim.keymap.set('n', '<leader>nl', function()
    M.parseFileAndLoadVirtualText()
end, { silent = true, desc = 'parseFileAndLoadVirtualText' })

vim.keymap.set('n', '<leader>nr', function()
    M.clearVirtualText()
end, { silent = true, desc = 'clearVirtualText' })

return M
