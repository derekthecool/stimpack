local function tableMoveFirstToLast(items)
    local firstItem = items[1]
    table.remove(items, 1)
    items[#items + 1] = firstItem
end

-- Shoot, lua 5.1 does not have table.pack and table.unpack

-- Example usage
local myTable = { 1, 2, 3, 4, 5 }

tableMoveFirstToLast(myTable)
print(myTable)
