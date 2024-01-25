---@diagnostic disable: undefined-global
local snippets = {
    ms(
        {
            { trig = 'PRINT', snippetType = 'autosnippet' },
        },
        fmt(
            [[
          print({});
         ]],
            {
                i(1),
            }
        )
    ),

    ms(
        {
            { trig = 'ERRORPRINT', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        stderr.writeln({});
        ]],
            {
                i(1),
            }
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
