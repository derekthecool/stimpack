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

    ms(
        {
            { trig = 'FUNCTION', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        {} {}({}) {{
            {}
        }}
        ]],
            {
                c(1, {
                    t('void'),
                    t('int'),
                    i(1, 'string'),
                }),
                i(2, 'functionName'),
                i(3, 'args'),
                i(4),
            }
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
