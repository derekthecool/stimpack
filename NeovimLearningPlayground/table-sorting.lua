local list = {
    2,
    5,
    1,
    99,
    10,
    8,
    4,
}

table.sort(list)
print(list)

local boolTest = 6 < 10
print(boolTest, 5 > 1)

-- Sort in reverse order
table.sort(list, function(a, b)
    return a > b
end)
print(list)

local complicated_table = {
    { a = 0, name = 'a' },
    { a = 2, name = 'aaa' },
    { a = 4, name = 'aaaaa' },
    { a = 14, name = 'aaaaaaaaaaaaaaa' },
    { a = 3, name = 'aaaa' },
    { a = 8, name = 'aaaaaaaaa' },
    { a = 11, name = 'aaaaaaaaaaaa' },
    { a = 5, name = 'aaaaaa' },
    { a = 22, name = 'aaaaaaaaaaaaaaaaaaaaaaa' },
    { a = 6, name = 'aaaaaaa' },
    { a = 24, name = 'aaaaaaaaaaaaaaaaaaaaaaaaa' },
    { a = 7, name = 'aaaaaaaa' },
    { a = 10, name = 'aaaaaaaaaaa' },
    { a = 15, name = 'aaaaaaaaaaaaaaaa' },
    { a = 16, name = 'aaaaaaaaaaaaaaaaa' },
    { a = 1, name = 'aa' },
    { a = 17, name = 'aaaaaaaaaaaaaaaaaa' },
    { a = 18, name = 'aaaaaaaaaaaaaaaaaaa' },
    { a = 32, name = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' },
    { a = 19, name = 'aaaaaaaaaaaaaaaaaaaa' },
    { a = 30, name = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' },
    { a = 9, name = 'aaaaaaaaaa' },
    { a = 20, name = 'aaaaaaaaaaaaaaaaaaaaa' },
    { a = 23, name = 'aaaaaaaaaaaaaaaaaaaaaaaa' },
    { a = 26, name = 'aaaaaaaaaaaaaaaaaaaaaaaaaaa' },
    { a = 27, name = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaa' },
    { a = 12, name = 'aaaaaaaaaaaaa' },
    { a = 28, name = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaa' },
    { a = 31, name = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' },
    { a = 33, name = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' },
    { a = 25, name = 'aaaaaaaaaaaaaaaaaaaaaaaaaa' },
    { a = 29, name = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' },
    { a = 34, name = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' },
    { a = 21, name = 'aaaaaaaaaaaaaaaaaaaaaa' },
    { a = 35, name = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' },
    { a = 36, name = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' },
}

-- Sorting using table.sort will fail with error 'attempt to compare two table values'
--table.sort(complicated_table)
print(complicated_table)

table.sort(complicated_table, function(a,b) return a.a > b.a end)
print(complicated_table)

table.sort(complicated_table, function(a,b) return #b.name > #a.name end)
print(complicated_table)
