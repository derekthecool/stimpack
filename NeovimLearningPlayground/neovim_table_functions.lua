local sql_types_wanted = { 'sql', 'mysql', 'sqlserver', 'postgresql', 'sqlite' }
for _, sql in pairs(sql_types_wanted) do
    -- luasnip.filetype_set(sql, sql_types_wanted)
    -- luasnip.filetype_extend(sql, sql_types_wanted)
    print(sql)
    print(sql_types_wanted)
    local filtered_table = vim.tbl_filter(function(a)
        return a ~= sql
    end, sql_types_wanted)
    print(filtered_table)
end
