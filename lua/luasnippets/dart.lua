---@diagnostic disable: undefined-global

local shareable = require('luasnippets.functions.shareable_snippets')

local snippets = {
    ms(
        {
            { trig = 'CLASS', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        class {ClassName} {{
          const {RepeatClassName}({{{ConstructorPropertyInitializer}}});

          {PropertiesCreatedFromConstructorInputDynamicNode}
        }}
        ]],
            {
                ClassName = i(1, 'ClassName'),
                RepeatClassName = rep(1),
                ConstructorPropertyInitializer = i(2, 'this.name, required this.age'),
                PropertiesCreatedFromConstructorInputDynamicNode = d(3, function(args, snip)
                    local nodes = {}

                    -- Add nodes for snippet
                    -- table.insert(nodes, t('Add this node'))

                    local constructor_inputs = vim.split(args[2][1], ',')
                    for _, item in pairs(constructor_inputs) do
                        local trimmed_item = (item:gsub('.*this%.', ''))
                        local new_snippet = sn(
                            nil,
                            fmt(
                                [[

                                final {DataType} {Property};

                                ]],
                                {
                                    DataType = i(1, 'String'),
                                    Property = t(trimmed_item),
                                }
                            )
                        )
                        table.insert(nodes, new_snippet)
                    end

                    return sn(nil, nodes)
                end, { 1, 2 }),
            }
        )
    ),

    ms(
        {
            { trig = 'REGREPLACE', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        {}.replaceAll(RegExp(r'{}'),'{}');
        ]],
            {
                i(1, 'source'),
                i(2, '.*'),
                i(3),
            }
        )
    ),

    ms(
        {
            { trig = 'REGMATCH', snippetType = 'autosnippet' },
        },
        fmt([[RegExp(r'{Pattern}').firstMatch({Source});]], {
            Pattern = i(1, '.*'),
            Source = i(2, 'source'),
        })
    ),

    ms(
        {
            { trig = 'ALLREGMATCH', snippetType = 'autosnippet' },
        },
        fmt([[RegExp(r'{}').allMatches({}).map((x) => x.group(0));]], {
            i(1, '.*'),
            i(2, 'input'),
        })
    ),

    ms({
        { trig = 'read line', snippetType = 'autosnippet' },
    }, fmt([[stdin.readLineSync()]], {})),

    ms(
        {
            { trig = 'PRINT', snippetType = 'autosnippet' },
            { trig = 'print_print', snippetType = 'snippet' },
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
            { trig = '.map', snippetType = 'snippet' },
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

    shareable.for_loop_c_style,
    shareable.if_statement_c_style,
    shareable.else_statement_c_style,
    shareable.while_loop_c_style,
    shareable.function_c_style,
    shareable.shell_variable_reference,
    shareable.shell_variable_brackets,
}

local autosnippets = {}

return snippets, autosnippets
