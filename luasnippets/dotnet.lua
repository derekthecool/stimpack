---@diagnostic disable: undefined-global
local snippets = {}

local autosnippets = {
    s(
        'ReadLine',
        fmt(
            [[
        Console.ReadLine()
        ]]   ,
            {}
        )
    ),
}

return snippets, autosnippets
