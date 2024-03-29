local path = require('plenary.path')

print(path)

local test = path.new('./scandir.lua')
print(test)
print(test.filename)
local file = test:absolute()
print(file)
print(vim.fs.normalize(file))


-- Debugging neotest plenary runner problems on windows today 2024-03-27
print((require('plenary.path').new('./bit.lua')):absolute())
print((require('plenary.path').new('./bit.lua'):parent() / 'test' / 'monkey.txt').filename)
print(require('plenary.path').new('./bit.lua'):parent():parent().filename)
print(require('plenary.path').new('./bit.lua'):parent():parent().filename)
local script_path = debug.getinfo(1, "S").source:sub(2)
print(script_path)
local test_script = (path.new(script_path()):parent():parent() / "run_tests.lua").filename
print(test_script)
