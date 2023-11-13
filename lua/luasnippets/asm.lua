---@diagnostic disable: undefined-global
local snippets = {
    ms(
        {
            { trig = 'move', snippetType = 'snippet' },
        },
        fmt(
            [[
        mov {}, {}
        ]],
            {
                i(1, 'rdi'),
                i(2, 'rax'),
            }
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
