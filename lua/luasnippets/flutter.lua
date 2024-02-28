---@diagnostic disable: undefined-global, missing-parameter

local shareable = require('luasnippets.functions.shareable_snippets')

local color = function(index)
    return d(index, function(args, snip)
        local nodes = {
            sn(
                nil,
                fmt([[Color.fromARGB(0x{}, 0x{}, 0x{}, 0x{})]], {
                    i(1, 'FF'),
                    i(2, 'FF'),
                    i(3, 'FF'),
                    i(4, 'FF'),
                })
            ),

            sn(
                nil,
                fmt([[Color.fromARGB({},{},{},{})]], {
                    i(1, '255'),
                    i(2, '255'),
                    i(3, '255'),
                    i(4, '255'),
                })
            ),

            sn(
                nil,
                fmt([[Color.fromRGBO({},{},{},{})]], {
                    i(1, '255'),
                    i(2, '255'),
                    i(3, '255'),
                    i(4, '0.80'),
                })
            ),

            sn(
                nil,
                fmt([[Color()]], {
                    i(1, '0xAARRGGBB'),
                })
            ),
        }

        -- -- Add nodes for snippet
        -- table.insert(nodes, t('Add this node'))

        local choices = c(1, nodes)

        return sn(index, { choices })
    end, {})
end

-- local lambda = function(index)
--     return sn(
--         index,
--         fmt(
--             [[
--          ({}) {{
--              {}
--          }}
--          ]],
--             {
--                 i(1),
--                 i(2),
--             }
--         )
--     )
-- end

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
        fmt([[alignment: Alignment.{},]], {
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
            { trig = 'widget',        snippetType = 'snippet' },
            { trig = 'widget widget', snippetType = 'autosnippet' },
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
            { trig = 'widgetted', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        {}(
          {}
        ),
        ]],
            {
                i(1, 'ListTile'),
                i(2),
            }
        )
    ),

    ms(
        {
            { trig = 'column',        snippetType = 'snippet' },
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
            { trig = 'text',      snippetType = 'snippet' },
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
            { trig = 'row',     snippetType = 'snippet' },
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
            { trig = 'stack',       snippetType = 'snippet' },
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
            { trig = 'alignment',           snippetType = 'snippet' },
            { trig = 'alignment alignment', snippetType = 'autosnippet' },
        },
        fmt([[{}]], {
            alignment(1),
        })
    ),

    ms(
        {
            { trig = 'width',       snippetType = 'snippet' },
            { trig = 'width width', snippetType = 'autosnippet' },
        },
        fmt([[{}]], {
            width(1),
        })
    ),

    ms(
        {
            { trig = 'height',        snippetType = 'snippet' },
            { trig = 'height height', snippetType = 'autosnippet' },
        },
        fmt([[{}]], {
            height(1),
        })
    ),

    ms(
        {
            { trig = 'container',           snippetType = 'snippet' },
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

    ms(
        {
            { trig = 'set state', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        setState(() {{
            {};
        }});
        ]],
            {
                i(1, 'counter++'),
            }
        )
    ),

    ms(
        {
            { trig = 'LAMBDA', snippetType = 'autosnippet' },
        },
        fmt([[{}]], {
            shareable.lambda(1),
        })
    ),

    ms(
        {
            { trig = 'on pressed', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        onPressed: {},
        ]],
            { shareable.lambda(1) }
        )
    ),

    ms(
        {
            { trig = 'main', snippetType = 'snippet' },
        },
        fmt(
            [[
        import 'package:flutter/material.dart';

        void main() {
          runApp(const <>());
        }

        class <> extends StatelessWidget {
          const <>({super.key});

          @override
          Widget build(BuildContext context) {
            return MaterialApp(
              title: '<>',
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                colorSchemeSeed: Colors.<>,
                useMaterial3: true,
              ),
              theme: ThemeData(
                colorSchemeSeed: Colors.<>,
                useMaterial3: true,
              ),
              themeMode: ThemeMode.system,
              home: const <>,
            );
          }
        }
        ]],
            {
                i(1, 'MyApp'),
                rep(1),
                rep(1),
                i(2, 'Title'),
                i(3, 'deepPurple'),
                rep(3),
                i(4, 'MyWidgetsHere'),
            },
            {
                delimiters = '<>',
            }
        )
    ),

    ms(
        {
            { trig = 'scaffold',          snippetType = 'snippet' },
            { trig = 'scaffold scaffold', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(<>),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <<Widget>>[
                <>
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: <>,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        );
        ]],
            {
                i(1, 'Title'),
                i(2),
                shareable.lambda(3),
            },
            {
                delimiters = '<>',
            }
        )
    ),

    ms(
        {
            { trig = 'color color', snippetType = 'autosnippet' },
        },
        fmt([[color: {}]], {
            color(1),
        })
    ),

    -- Testing
    ms(
        {
            { trig = 'TEST', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[

        ]],
            {}
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
