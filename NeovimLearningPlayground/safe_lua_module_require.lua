-- As seen from Chris@machine https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/toggleterm.lua
local status_ok, package = pcall(require, "telescope")
if not status_ok then
  return
end
print(status_ok, package)

-- Test with not saving to variable and with a package that can't be found
if not pcall(require, "elescope") then
  print("Package load fail")
end
