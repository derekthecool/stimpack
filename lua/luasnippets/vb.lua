---@diagnostic disable: undefined-global
local snippets = {
    ms(
        {
            { trig = 'IF', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
    If {Condition} Then
        {Code}
    End If
    ]],
            {
                Condition = i(1, 'index Mod 2 = 0'),
                Code = i(2),
            }
        )
    ),

    ms(
        {
            { trig = 'Console.WriteLine', snippetType = 'snippet', condition = conds.line_begin },
            { trig = 'PRINT', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        Console.WriteLine({Text})
        ]],
            {
                Text = i(1, '"Hello world"'),
            }
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
