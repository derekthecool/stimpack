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
    shareable.shell_variable_reference,
    shareable.shell_variable_brackets,

    ms({
        { trig = 'read line', snippetType = 'autosnippet' },
    }, fmt([[stdin.readLineSync()]], {})),

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

    ms(
        {
            { trig = '.fold', snippetType = 'autosnippet' },
        },
        fmt([[.fold({}, {})]], {
            i(1, 'initial_value'),
            shareable.lambda(2),
        })
    ),
}

local autosnippets = {}

return snippets, autosnippets
