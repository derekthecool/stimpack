local scan = require('plenary.scandir')
require('luafun.fun')

-- local depth2 = scan.scan_dir('.', { hidden = true, depth = 2 })
-- print(depth2)
-- print(#depth2)
--
-- local depth_full = scan.scan_dir('.', { hidden = true })
-- print(depth_full)
-- print(#depth_full)
--
-- -- Find amount of lua files using luafun library
-- local lua_files = fun.filter(function(a)
--     return a:match('%.lua') ~= nil
-- end, depth_full)
-- fun.each(print, lua_files)
-- print(fun.length(lua_files))
--
-- -- Find amount of lua files by giving better args to scandir
-- local better_lua_files = scan.scan_dir('.', { hidden = true, respect_gitignore = true, search_pattern = '%.lua$' })
-- print(better_lua_files)
-- print(#better_lua_files)
--
-- -- Scan directory of current opened file
-- local current_file_directory = vim.fn.expand('%:h')
-- print(current_file_directory)
-- local depth_full = scan.scan_dir(current_file_directory, { respect_gitignore = true, search_pattern = '.*' })
-- print(depth_full)
-- print(#depth_full)
--
-- -- Get all directories
-- -- local dirs = fun.map(function(a)
-- -- return vim.fs.normalize(a) .. 'test'
-- -- end, scan.scan_dir('.', { respect_gitignore = true, only_dirs = true }))
-- local dirs = scan.scan_dir('.', {
--     respect_gitignore = true,
--     only_dirs = true,
-- })
-- dirs_clean = fun.map(function(a)
--     return vim.fs.normalize(a)
-- end, dirs)
-- print(dirs)
-- print(#dirs)
-- print(dirs_clean)
-- print(#dirs)
--

local directory = MiniMisc.find_root()
print(directory)

-- -- -- Better version to normalize paths in functional style
-- local fun_dirs = fun.map(function(a)
--     return vim.fs.normalize(a)
-- end, scan.scan_dir(directory, { respect_gitignore = true, only_dirs = true })):totable()
-- -- Normal table now
-- print(fun_dirs)
-- print(fun_dirs[1])

print(map)

local files = scan.scan_dir(directory, { hidden = true, respect_gitignore = true })
local all_files = map(function(a)
    return vim.fs.normalize(a)
end, files):totable()
-- print(#all_files)
print(all_files)

print(table.concat(all_files, ','))
