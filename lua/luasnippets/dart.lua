---@diagnostic disable: undefined-global
local snippets = {
    -- Dart
    ms(
        {
            { trig = 'REGREPLACE', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        {}.replaceAll(RegExp(r'{}'),{});
        ]],
            {
                i(1, 'source'),
                i(2, '.*'),
                i(3, [['']]),
            }
        )
    ),

    ms({
        { trig = 'read line', snippetType = 'autosnippet' },
    }, fmt([[stdin.readLineSync()]], {})),
    ms(
        {
            { trig = 'IF', snippetType = 'autosnippet' },
        },
        fmt(
            [[
            if ({}) {{
                {}
            }}
        ]],
            { i(1), i(2) }
        )
    ),

    ms(
        {
            { trig = 'ELS_EI_F', snippetType = 'autosnippet' },
        },
        fmt(
            [[
         else if ({}) {{
             {}
         }}
        ]],
            {
                i(1),
                i(2),
            }
        )
    ),

    ms(
        {
            { trig = 'ELSE', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        else {{
            {}
        }}
        ]],
            {
                i(1),
            }
        )
    ),

    ms(
        {
            { trig = 'FOR', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        for (int {} = 1; {} < {}; {}++) {{
            {}
        }}
        ]],
            {
                i(1, 'i'),
                rep(1),
                i(2, '10'),
                rep(1),
                i(3),
            }
        )
    ),
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
