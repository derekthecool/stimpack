-- Persistent PSScriptAnalyzer formatter for conform.nvim.
--
-- Spawning pwsh per format costs ~2s on Windows; instead keep one pwsh running
-- scripts/psformat-server.ps1 and talk to it with newline-delimited JSON:
--   request:  {"text": "<buffer contents>"}
--   response: {"ok": true, "text": "..."} | {"ok": false, "err": "..."}
-- The server prints {"ready":true} once warmed up; requests are answered in order.

local M = {}

---@alias psformat.callback fun(err: string?, text: string?)

local state = {
    ---@type vim.SystemObj?
    proc = nil,
    buf = '',
    ---@type psformat.callback[]
    pending = {},
}

M.settings_path = string.format('%s/Atelier/pwsh/PSScriptAnalyzerSettings.psd1', OS.home)

local function script_path()
    return vim.fs.joinpath(vim.fn.stdpath('config'), 'scripts', 'psformat-server.ps1')
end

---Fail every in-flight request (server died or could not be written to).
---@param err string
local function fail_pending(err)
    local pending = state.pending
    state.pending = {}
    for _, cb in ipairs(pending) do
        cb(err)
    end
end

---Handle one complete JSON line from the server.
---@param line string
local function handle_line(line)
    local ok, msg = pcall(vim.json.decode, line)
    if not ok or type(msg) ~= 'table' or msg.ready then
        return
    end
    local cb = table.remove(state.pending, 1)
    if not cb then
        return
    end
    if msg.ok then
        cb(nil, msg.text)
    else
        cb(msg.err or 'Invoke-Formatter failed')
    end
end

---Accumulate stdout chunks and dispatch each complete line.
---@param data string?
local function on_stdout(_, data)
    if not data then
        return
    end
    state.buf = state.buf .. data
    for line in state.buf:gmatch('([^\n]*)\n') do
        vim.schedule(function()
            handle_line(line)
        end)
    end
    state.buf = state.buf:match('[^\n]*$')
end

---Start the server if it is not already running.
function M.start()
    if state.proc then
        return
    end
    state.buf = ''
    state.proc = vim.system(
        { 'pwsh', '-NoLogo', '-NoProfile', '-NonInteractive', '-File', script_path(), M.settings_path },
        { stdin = true, stdout = on_stdout },
        function()
            state.proc = nil
            vim.schedule(function()
                fail_pending('PSScriptAnalyzer format server exited')
            end)
        end
    )
end

function M.stop()
    if state.proc then
        state.proc:kill(15)
    end
end

---Format `text` via the server.
---@param text string
---@param cb psformat.callback
function M.request(text, cb)
    M.start()
    table.insert(state.pending, cb)
    local ok, err = pcall(state.proc.write, state.proc, vim.json.encode({ text = text }) .. '\n')
    if not ok then
        table.remove(state.pending)
        cb(tostring(err))
    end
end

---conform.nvim `format` function for a custom formatter.
---@param lines string[]
---@param callback fun(err: string?, lines: string[]?)
function M.conform_format(_, _, lines, callback)
    M.request(table.concat(lines, '\n'), function(err, text)
        if err then
            return callback(err)
        end
        local trimmed = text:gsub('%s+$', ''):gsub('\r', '')
        callback(nil, vim.split(trimmed, '\n', { plain = true }))
    end)
end

---Prewarm on the first ps1 buffer and stop the server on exit.
function M.setup()
    local group = vim.api.nvim_create_augroup('psformat', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = 'ps1',
        once = true,
        desc = 'Prewarm the PSScriptAnalyzer format server',
        callback = M.start,
    })
    vim.api.nvim_create_autocmd('VimLeavePre', { group = group, callback = M.stop })
end

return M
