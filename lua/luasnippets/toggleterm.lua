---@diagnostic disable: undefined-global
local snippets = {
    ms(
        {
            { trig = 'test', snippetType = 'snippet' },
        },
        fmt(
            [[
             I want snippets in toggle term
         ]],
            {}
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
