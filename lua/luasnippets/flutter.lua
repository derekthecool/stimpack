---@diagnostic disable: undefined-global, missing-parameter

local width = function(index)
    return sn(
        index,
        fmt([[width: {},]], {
            i(1),
        })
    )
end

local height = function(index)
    return sn(
        index,
        fmt([[height: {},]], {
            i(1),
        })
    )
end

local alignment = function(index)
    return sn(
        index,
        fmt([[alignment: alignment.{},]], {
            c(1, {
                t('topRight'),
                t('topLeft'),
                t('center'),
                t('topCenter'),
                t('centerLeft'),
                t('bottomLeft'),
                t('centerRight'),
                t('bottomRight'),
                t('bottomCenter'),
            }),
        })
    )
end

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
          fit: StackFit.{},
          alignment: Alignment.{},
          children: <Widget>[
            {}
          ],
        ),
        ]],
            {
                c(1, {
                    t('loose'),
                    t('expand'),
                    t('passthrough'),
                }),
                alignment(2),
                i(3),
            }
        )
    ),

    ms(
        {
            { trig = 'alignment', snippetType = 'snippet' },
            { trig = 'alignment alignment', snippetType = 'autosnippet' },
        },
        fmt([[{}]], {
            alignment(1),
        })
    ),

    ms(
        {
            { trig = 'width', snippetType = 'snippet' },
            { trig = 'width width', snippetType = 'autosnippet' },
        },
        fmt([[{}]], {
            width(1),
        })
    ),

    ms(
        {
            { trig = 'height', snippetType = 'snippet' },
            { trig = 'height height', snippetType = 'autosnippet' },
        },
        fmt([[{}]], {
            height(1),
        })
    ),

    ms(
        {
            { trig = 'container', snippetType = 'snippet' },
            { trig = 'container container', snippetType = 'autosnippet' },
        },
        fmt(
            [[
          Container(
            {}
            {}
            decoration: BoxDecoration(
              shape: BoxShape.{},
              color: Colors.{},
            ),
          ),
        ]],
            {
                width(1),
                height(2),
                c(3, {
                    t('circle'),
                    t('square'),
                }),
                i(4),
            }
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
