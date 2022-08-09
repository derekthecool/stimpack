-- Require the file icons.lua. This is a global table, but deserves its own file
require('stimpack.icons')

-- Create global table that can be accessed from any file
-- This will solve all cross platform path issues
OS = {}

OS['init_lua'] = vim.env.MYVIMRC

if vim.loop.os_uname().sysname == 'Linux' then
  OS['nvim'] = vim.fn.stdpath('config') .. '/'
  OS['OS'] = 'Linux'
  OS['home'] = os.getenv('HOME')
  OS['my_plugins'] = OS['home'] .. '/neovim_plugins'
  OS['snippets'] = string.format('%sluasnippets/', OS['nvim'])
elseif vim.loop.os_uname().sysname == 'Windows_NT' then
  OS['nvim'] = vim.fn.stdpath('config') .. '\\'
  OS['OS'] = 'Windows'
  OS['home'] = os.getenv('USERPROFILE')
  OS['my_plugins'] = OS['home'] .. '\\neovim_plugins'
  OS['snippets'] = string.format('%sluasnippets\\', OS['nvim'])
end

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
