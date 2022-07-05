print(os.execute("pwd"))
print(os.getenv("PATH"))
print(os.getenv("GH_TOKEN"))

local handle = io.popen("gh --version")
local result = handle:read("*a")
handle:close()

print(result)
for match in string.gmatch(result, "%w+") do
  print(match)
end
