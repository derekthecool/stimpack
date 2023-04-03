local flipper = {}

flipper.toggle = function(input)
    local output = {}
    output.text = input

    local constants = {
        booleanTrueMatch = '[Tt]rue',
        booleanTrueString = 'true',
        booleanFalseMatch = '[Ff]alse',
        booleanFalseString = 'false',
    }

    -- Find the total number of boolean strings
    local _, trueCount = input:gsub(constants.booleanTrueMatch, '')
    local _, falseCount = input:gsub(constants.booleanFalseString, '')
    local totalBooleanCount = trueCount + falseCount

    if totalBooleanCount == 1 then
        output.flipped = true

        -- Replace input string boolean text
        if trueCount == 1 then
            output.text = input:gsub(constants.booleanTrueMatch, constants.booleanFalseString)
        elseif falseCount == 1 then
            output.text = input:gsub(constants.booleanFalseMatch, constants.booleanTrueString)
        end
    else
        output.flipped = false
    end

    return output
end

flipper.toggle_current_line = function()
    local currentLineNumber = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_get_lines(0, currentLineNumber - 1, currentLineNumber, true)
    for key, line in ipairs(lines) do
        local output = flipper.toggle(line)
        lines[key] = output.text
    end
    vim.api.nvim_buf_set_lines(0, currentLineNumber - 1, currentLineNumber, false, lines)
end

vim.keymap.set('n', '<leader>nB', flipper.toggle_current_line, { desc = 'Boolean flipper toggle current line' })

return flipper
