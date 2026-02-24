-- Adding table items
local items = { 1, 2, 3 }
-- Successful adds list like items
vim.list_extend(items, { 7, 19 })
-- Does not add dictionary like items
vim.list_extend(items, { ['NamedValue'] = true })
print(items)
for _, value in ipairs(items) do
    print(value)
end

local unmapped = {
    1,
    3,
    5,
    7,
    9,
}
print(unmapped)
local mapped = vim.tbl_map(function(unmapped_item)
    return unmapped_item * 3
end, unmapped)
print(mapped)
