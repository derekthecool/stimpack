-- Require the file icons.lua. This is a global table, but deserves its own file
require('stimpack.icons')

-- Create global table that can be accessed from any file
-- This will solve all cross platform path issues
OS = {}

---The file system path separator for the current platform.
OS.separator = '/'
if OS.OS == 'Windows' then
    OS.separator = '\\'
end

---Split string into a table of strings using a separator.
---Found here https://www.reddit.com/r/neovim/comments/su0em7/comment/hx96ur0/?utm_source=share&utm_medium=web3x
---@param inputString string The string to split.
---@param sep string The separator to use.
---@return table table A table of strings.
OS.split = function(inputString, sep)
    local fields = {}

    local pattern = string.format('([^%s]+)', sep)
    local _ = string.gsub(inputString, pattern, function(c)
        fields[#fields + 1] = c
    end)

    return fields
end

---Joins arbitrary number of paths together.
---Found here https://www.reddit.com/r/neovim/comments/su0em7/comment/hx96ur0/?utm_source=share&utm_medium=web3x
---@vararg <string> The paths to join.
---@return string
OS.join_path = function(...)
    local args = { ... }
    if #args == 0 then
        return ''
    end

    local all_parts = {}
    if type(args[1]) == 'string' and args[1]:sub(1, 1) == OS.separator then
        all_parts[1] = ''
    end

    for _, arg in ipairs(args) do
        arg_parts = OS.split(arg, OS.separator)
        vim.list_extend(all_parts, arg_parts)
    end
    return vim.fs.normalize(table.concat(all_parts, OS.separator))
end

if vim.loop.os_uname().sysname == 'Linux' then
    OS['OS'] = 'Linux'
    OS['home'] = vim.fs.normalize(os.getenv('HOME'))
    OS['plover'] = OS.join_path(OS['home'], '.config', 'plover ')
    OS['executable_extension'] = ''
    OS['executable_extension_alt'] = ''
elseif vim.loop.os_uname().sysname == 'Windows_NT' then
    OS['OS'] = 'Windows'
    OS['home'] = vim.fs.normalize(os.getenv('USERPROFILE'))
    OS['plover'] = OS.join_path(os.getenv('LOCALAPPDATA'), 'plover')
    OS['executable_extension'] = '.exe'
    OS['executable_extension_alt'] = '.cmd'
end

OS['init_lua'] = vim.fs.normalize(vim.env.MYVIMRC)
OS['nvim'] = vim.fs.normalize(vim.fn.stdpath('config'))
OS['my_plugins'] = OS.join_path(OS['home'], 'neovim_plugins')
OS['snippets'] = OS.join_path(OS.nvim, 'luasnippets')
OS['stimpack'] = OS.join_path(OS.nvim, 'lua', 'stimpack')

---Function to return telescope.utils command runner
---@param command string the single string input command
---@return table the table has the fields stdout,ret,and stderr
function Execute(command)
    -- Format the input string to a table splitting on any space chars
    local formatted_command, output = {}, {}
    for match in string.gmatch(command, '[^%s]+') do
        table.insert(formatted_command, match)
    end

    output.stdout, output.ret, output.stderr = require('telescope.utils').get_os_command_output(formatted_command)
    return output
end

---This function extracts the package name of the current lua file. The files
---need to be named with names like telescope-settings.lua. The search returns
---all text before the '-settings'.
---@param nameOfCurrentFileToExtractPackageNamFrom any
---@return string|number
function GetPackageNameFromCurrentFile(nameOfCurrentFileToExtractPackageNamFrom)
    return string.match(nameOfCurrentFileToExtractPackageNamFrom, '(%w+)-settings.lua')
end

-- Helpful function to print tables nicely instead of the address
function P(table_to_print)
    print(vim.inspect(table_to_print))
end

-- Helpful function to print tables nicely to the vim.notify function
function V(...)
    for key, value in ipairs({ ... }) do
        vim.notify(vim.inspect(value), vim.log.levels.INFO, { title = 'Stimpack notification (' .. key .. ')' })
    end
end
