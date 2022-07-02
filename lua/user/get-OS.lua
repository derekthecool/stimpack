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
