-- Create global table that can be accessed from any file
-- This will solve all cross platform path issues
OS = {}

if vim.loop.os_uname().sysname == ('Linux') then
  OS['OS'] = 'Linux'
  OS['home'] = os.getenv('HOME')
  OS['nvim'] = string.format('%s/.config/nvim/', os.getenv('HOME'))
  OS['snippets'] = string.format('%s/snippets/', OS['nvim'])
elseif vim.loop.os_uname().sysname == ('Windows_NT') then
  OS['OS'] = 'Windows'
  OS['home'] = os.getenv('USERPROFILE')
  OS['nvim'] = string.format('%s\\nvim\\', os.getenv('LOCALAPPDATA'))
  OS['snippets'] = string.format('%s\\snippets\\', OS['nvim'])
end

---Function to return telescope.utils command runner
---@param command string the single string input command
---@return table the table has the fields stdout,ret,and stderr
function Execute(command)

  -- Format the input string to a table splitting on any space chars
  local formatted_command, output = {}, {}
  for match in string.gmatch(command, "[^%s]+") do
    table.insert(formatted_command, match)
  end

  output.stdout, output.ret, output.stderr = require('telescope.utils').get_os_command_output(formatted_command)
  return output
end
