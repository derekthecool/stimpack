-- Using os.execute
print(os.getenv("PATH"))
print(os.getenv("GH_TOKEN"))

-- Using popen
local handle = io.popen("gh --version")
local result = handle:read("*a")
handle:close()
print(result)

-- Using telescope.utils.get_os_command_output
local stdout, ret, stderr = require('telescope.utils').get_os_command_output {
  "git",
  "rev-parse",
  "--is-inside-work-tree",
}
print(stdout, ret, stderr)


stdout, ret, stderr = require('telescope.utils').get_os_command_output {
  "git",
  "status",
}
print(stdout, ret, stderr)

---Function to return telescope.utils command runner
---@param command_table input table of command to run, each word in a separate string
---@return table
local function execute(command)
  local output = {}
  output.stdout, output.ret, output.stderr = require('telescope.utils').get_os_command_output(command)
  return output
end

local a = execute({ "git", "--version" })
print(a.stdout)
print(a.ret)
print(a.stderr)
print(execute({ "git" }).stderr)

print(vim.fn.jobstart("git"))
