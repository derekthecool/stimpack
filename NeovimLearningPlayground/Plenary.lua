local Job = require('plenary.job')

Job:new({
    command = 'powershell',
    args = { '-Command', [[Get-ChildItem -Recurse -n -Filter "*_spec.lua"]] },
    cwd = [[D:\Programming\neovim\dvp.nvim]],
    on_exit = function(j, return_val)
        print(return_val)
        print(j:result())
    end,
}):sync() -- or start()
