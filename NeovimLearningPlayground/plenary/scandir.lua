local scan = require('plenary.scandir')
local fun = require('luafun.fun')

local depth2 = scan.scan_dir('.', { hidden = true, depth = 2 })
print(depth2)
print(#depth2)

local depth_full = scan.scan_dir('.', { hidden = true })
print(depth_full)
print(#depth_full)

-- Find amount of lua files using luafun library
local lua_files = fun.filter(function(a)
    return a:match('%.lua') ~= nil
end, depth_full)
fun.each(print, lua_files)
print(fun.length(lua_files))

-- Find amount of lua files by giving better args to scandir
local better_lua_files = scan.scan_dir('.', { hidden = true, respect_gitignore = true, search_pattern = '%.lua$' })
print(better_lua_files)
print(#better_lua_files)
