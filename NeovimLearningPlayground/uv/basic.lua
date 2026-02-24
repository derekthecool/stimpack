local uv = vim.uv

-- Version information
print(uv.version())
print(uv.version_string())

-- Time
print(uv.now())

-- Creating a simple setTimeout wrapper
local function setTimeout(timeout, callback)
    local timer = uv.new_timer()
    timer:start(timeout, 0, function()
        timer:stop()
        timer:close()
        callback()
    end)
    return timer
end

-- Creating a simple setInterval wrapper
local function setInterval(interval, callback)
    local timer = uv.new_timer()
    timer:start(interval, interval, function()
        callback()
    end)
    return timer
end

-- And clearInterval
local function clearInterval(timer)
    timer:stop()
    timer:close()
end

-- -- Code below starts a oneshot timer, commented so everything else can be used with luapad
-- local oneshot_interval = 5000
-- setTimeout(oneshot_interval, function()
--     vim.print('One shot timer with interval of ' .. oneshot_interval .. ' has elapsed')
-- end)

-- -- Code below starts a repeated timer, commented so everything else can be used with luapad
-- local number = 1
-- local timer_test = setInterval(3000, function()
--     number = number + 1
--     vim.print(number)
-- end)

-- File system
print(uv.cwd())

local file_path = 'README.md'

-- -- This function allows you to read file metadata
-- local file_information = uv.fs_stat(file_path, function(err, stats)
--     if err then
--         print('Error:', err)
--         return { err }
--     else
--         print('File size:', stats.st_size)
--         local date = os.date('%Y-%m-%d %H:%M:%S', stats.st_mtime)
--         print('Last modification time:', date)
--         return { stats.st_size, date }
--     end
-- end)

-- This function allows you to read file metadata
local file_information = uv.fs_stat(file_path)
print(file_information)

local file_information_2 = uv.fs_statfs(file_path)
print(file_information_2)

-- DNS
print(uv.getaddrinfo('dereklomax.com'))
print(uv.getnameinfo({ ip = '8.8.8.8' }))

-- Miscellaneous functions
print(uv.exepath())
print(uv.cwd())
print(uv.get_process_title())
print(uv.get_total_memory())
print(uv.get_free_memory())
print(uv.get_constrained_memory())
print(uv.get_available_memory())
print(uv.resident_set_memory())
print(uv.getrusage())
print(uv.available_parallelism())
print(uv.cpu_info())
print(uv.cpumask_size())
print(uv.os_getpid())

-- uv.setuid({id})                                                    *uv.setuid()*
-- print(uv.getuid())
-- print(uv.getgid())

print(uv.clock_gettime('monotonic'))
print(uv.clock_gettime('realtime'))
print(uv.uptime())
-- print(uv.print_all_handles())
-- print(uv.print_active_handles())
print(uv.gettimeofday())
print(uv.interface_addresses())
print(uv.os_uname())
print(uv.os_gethostname())
-- Gets all environment variables
print(uv.os_environ())
print(uv.os_homedir())
print(uv.os_tmpdir())
print(uv.os_get_passwd())
print(uv.os_getpid())
print(uv.os_getppid())
print(string.byte(uv.random(6, nil), 1, -1))
print(uv.random(6):byte(1, -1))
