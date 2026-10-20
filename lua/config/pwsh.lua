---Finding a PowerShell 7 that Neovim can actually spawn.
---
---A Microsoft Store install puts an execution alias on the PATH -- a reparse point
---that `executable('pwsh')` reports as not executable and that `jobstart()` refuses
---outright with E475 -- and keeps the real binary in `WindowsApps`, a directory that
---cannot be listed. `LazyVim.terminal.setup('pwsh')` only looks at the PATH, so it
---quietly falls back to Windows PowerShell 5.1 and every terminal opens in it.
---
---`cmd.exe` can follow the alias, so ask it where pwsh lives and hand that path to
---everything that spawns one. `$PSHOME` moves with every PowerShell update, so the
---answer is cached and re-checked rather than looked up on every start.
local M = {}

local cache = vim.fs.joinpath(vim.fn.stdpath('cache'), 'pwsh-path.txt')
local resolved

---@return string? path the remembered pwsh, if it is still there
local function from_cache()
    local ok, lines = pcall(vim.fn.readfile, cache)
    local path = ok and lines[1] or nil
    if path and path ~= '' and vim.fn.executable(path) == 1 then
        return path
    end
end

---@return string? path
local function discover()
    -- Anything but a Store install is on the PATH and needs no help.
    if vim.fn.executable('pwsh') == 1 then
        return 'pwsh'
    end
    if vim.fn.has('win32') == 0 or vim.fn.executable('cmd.exe') == 0 then
        return nil
    end
    local home = vim.trim(vim.fn.system({ 'cmd.exe', '/c', 'pwsh', '-NoProfile', '-NoLogo', '-Command', '$PSHOME' }))
    if vim.v.shell_error ~= 0 or home == '' then
        return nil
    end
    local exe = vim.fs.joinpath(home, 'pwsh.exe')
    if vim.fn.executable(exe) == 1 then
        pcall(vim.fn.writefile, { exe }, cache)
        return exe
    end
end

---The pwsh to spawn, or nil when Neovim cannot reach one.
---@return string?
function M.exe()
    if resolved == nil then
        resolved = from_cache() or discover() or false
    end
    return resolved or nil
end

---The same path as `exe()`, quoted when it has to survive being parsed back out of a
---string option like `shell`.
---@return string?
function M.quoted()
    local exe = M.exe()
    if exe and exe:find(' ', 1, true) then
        return '"' .. exe .. '"'
    end
    return exe
end

return M
