local hex_strings = {}

hex_strings.is_valid_hex_string = function(input)
    local valid_letters = (input:match('^[0-9a-fA-F]+$') ~= nil)
    local valid_length = #input % 2 == 0
    V(valid_letters, valid_length)
    return valid_letters and valid_length
end

hex_strings.convert_hex_string_to_bytes = function(input)
    if not hex_strings.is_valid_hex_string(input) then
        return nil
    end

    local output = ''
    for i = 1, #input, 2 do
        local hexStringToNumber = tonumber(input:sub(i, i + 1), 16)
        output = output .. string.char(hexStringToNumber)
    end

    return output
end

hex_strings.convert_bytes_to_hex_string = function(input) end

-- End pure functions, start neovim mappings
hex_strings.hex_string_to_bytes = function()
    local current_word = vim.fn.expand('<cword>')

    local output = hex_strings.convert_hex_string_to_bytes(current_word)

    if not output then
        return
    end

    -- There is trouble when trying to set binary text to clipboard
    -- vim.fn.setreg('', output)

    V(string.format('Copied string: %s to clipboard', output))
end

vim.keymap.set('n', '<leader>nh', hex_strings.hex_string_to_bytes, { desc = 'Hex strings: string to bytes' })

return hex_strings
