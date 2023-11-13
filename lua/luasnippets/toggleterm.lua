---@diagnostic disable: undefined-global
local snippets = {
    ms(
        {
            { trig = 'test', snippetType = 'snippet' },
        },
        fmt(
            [[
          test test test
         ]],
            {}
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
