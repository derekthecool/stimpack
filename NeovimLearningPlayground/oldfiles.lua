local output = table
for _, file in ipairs(vim.v.oldfiles) do
    local file_stat = vim.loop.fs_stat(file)
    if file_stat and file_stat.type == 'file' and not vim.tbl_contains(results, file) and file ~= current_file then
        table.insert(output, file)
    end
end

print(vim.v.oldfiles)
print(output)

