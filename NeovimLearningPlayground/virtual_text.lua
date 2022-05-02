-- local match = vim.regex("match")
-- print(match)

local line = vim.api.nvim_get_current_line()
print(line)

local match = vim.regex:match_str(line)
print(match)

-- local match_line = vim.regex:match_line(0, 1)
-- print(match_line)
