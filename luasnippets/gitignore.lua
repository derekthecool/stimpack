---@diagnostic disable: undefined-global
local snippets = {
    s(
        'esp-idf',
        fmt(
            [[
         build/
         sdkconfig
         sdkconfig.old

         compile_commands.json
         ]],
            {}
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
