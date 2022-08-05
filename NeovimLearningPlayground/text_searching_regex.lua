local testText = 'This is test text 1234'
print(testText)

-- Set the \v very magic, back slashes need to be escaped
local match = vim.regex('\\v\\d'):match_str(testText)
print(match)

local check = vim.regex('print'):match_line(0, 1)
print(check)

local current_buffer = 0
local start_line = 0
local last_line = -1
local strict_indexing = false
local lines = vim.api.nvim_buf_get_lines(current_buffer, start_line, last_line, strict_indexing)

-- Print the line count in the current buffer
print(string.format('Lines in current buffer = %d', vim.api.nvim_buf_line_count(current_buffer)))

for key, value in pairs(lines) do
    local regex_text = 'match'

    print(key, value)
    local match_start, match_end = vim.regex(regex_text):match_line(0, key)
    print(key, match_start, match_end)

    local match_string_start, match_string_end = vim.regex(regex_text):match_str(value)
    if match_string_start ~= nil and match_string_end ~= nil then
        print(match_string_start, match_string_end)

        -- -1 for namespace ungrouped
        local namespace = -1
        local hl_group = 'Comment'
        -- Set the line to match equal to current line minus one because api is zero indexed
        local highlight_line = key - 1
        vim.api.nvim_buf_add_highlight(
            current_buffer,
            namespace,
            hl_group,
            highlight_line,
            match_string_start,
            match_string_end
        )
    end
end
