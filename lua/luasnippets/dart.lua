---@diagnostic disable: undefined-global

local shareable = require('luasnippets.functions.shareable_snippets')

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

    shareable.for_loop_c_style,
    shareable.if_statement_c_style,
    shareable.else_statement_c_style,
    shareable.while_loop_c_style,
    shareable.function_c_style,

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
            { trig = '.map', snippetType = 'autosnippet' },
        },
        fmt([[.map({})]], {
            shareable.lambda(1),
        })
    ),
}

local autosnippets = {}

return snippets, autosnippets
