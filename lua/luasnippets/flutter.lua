---@diagnostic disable: undefined-global, missing-parameter
local snippets = {

    ms(
        {
            { trig = 'CLASS', snippetType = 'autosnippet' },
        },
        fmt(
            [[{}
        ]],
            {
                d(1, function(args, snip)
                    local nodes = {}

                    -- Add nodes for snippet
                    table.insert(
                        nodes,
                        sn(
                            1,
                            fmt(
                                [[
                class {} extends StatelessWidget {{
                  @override
                  Widget build(BuildContext context) {{
                    return {}
                  }}
                }}
                 ]],
                                {

                                    i(1, 'ClassName'),
                                    i(2, 'Text("Test");'),
                                }
                            )
                        )
                    )

                    table.insert(
                        nodes,
                        sn(
                            1,
                            fmt(
                                [[
                class _{}State extends State<{}> {{
                  // State variables items here
                  {}

                  @override
                  Widget build(BuildContext context) {{
                    return {}
                  }}
                }}

                class {} extends StatefulWidget {{
                  @override
                  State<{}> createState() => _{}State();
                }}
                 ]],
                                {

                                    rep(1),
                                    i(1, 'MyStatefulWidgetClass'),
                                    i(2),
                                    i(3, 'Text("Test");'),
                                    rep(1),
                                    rep(1),
                                    rep(1),
                                }
                            )
                        )
                    )

                    return sn(nil, { c(1, nodes) })
                end, {}),
            }
        )
    ),

    ms(
        {
            { trig = 'column', snippetType = 'snippet' },
            { trig = 'column column', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        Column(
          crossAxisAlignment: CrossAxisAlignment.{},
          mainAxisSize: MainAxisSize.{},
          children: <Widget>[
            {}
          ],
        )
        ]],
            {
                c(1, {
                    t('end'),
                    t('start'),
                    t('center'),
                    t('stretch'),
                    t('baseline'),
                }),
                c(2, {
                    t('min'),
                    t('max'),
                }),
                i(3, 'Text("Test"),'),
            }
        )
    ),

    ms(
        {
            { trig = 'text', snippetType = 'snippet' },
            { trig = 'text text', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        Text("{}")
        ]],
            {
                i(1, 'Test text'),
            }
        )
    ),

    ms(
        {
            { trig = 'row', snippetType = 'snippet' },
            { trig = 'row row', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        Row(
          children: <Widget>[
            {}
          ],
          )
        ]],
            {
                i(1),
            }
        )
    ),

    ms(
        {
            { trig = 'stack', snippetType = 'snippet' },
            { trig = 'stack stack', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        Stack(
          children: <Widget>[
            {}
          ],
        ),
        ]],
            {
                i(1),
            }
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
