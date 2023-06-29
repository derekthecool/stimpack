local path = require('plenary.path')

print(path)

local test = path.new('./scandir.lua')
print(test)
print(test.filename)
local file = test:absolute()
print(file)
print(vim.fs.normalize(file))
