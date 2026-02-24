-- Specify properties to filter by
for key, value in pairs(vim.fn.getbufinfo({ bufloaded = 1, buflisted = 1 })) do
    print(_, value)
    print(value.name)
end

-- No filter
for key, value in pairs(vim.fn.getbufinfo()) do
    print(_, value)
    print(value.name)
end

-- Get a single buffer item like this
print(vim.fn.getbufinfo('')[1].name)

-- Get name of current file
local current_file = vim.fn.expand('%:p')

-- Get information on current buffer
print(vim.fn.getbufinfo(current_file))

-- Empty table returned when it does not match any buffers
local file_not_found = vim.fn.getbufinfo('file not found')
local is_table_empty = false
if next(file_not_found) == nil then
    is_table_empty = true
end
print(file_not_found, type(file_not_found), is_table_empty)
