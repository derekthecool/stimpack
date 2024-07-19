---@diagnostic disable: undefined-global, missing-parameter

local shareable = require('luasnippets.functions.shareable_snippets')

local snippets = {

    s(
        'mermaid flowchart',
        fmt(
            [[
      ```mermaid
      flowchart {}

      {}
      ```
      ]],
            {
                c(1, {
                    t('TD'),
                    t('BT'),
                    t('LR'),
                    t('RL'),
                }),

                c(2, {
                    sn(
                        nil,
                        fmt(
                            [[
                    read
                    parse
                    {}
                    output

                    read --> parse --> {} -->{} output
                    ]],
                            {
                                i(1, 'calculate'),
                                rep(1),
                                i(2),
                            }
                        )
                    ),
                    i(1),
                }),
            }
        )
    ),

    ms(
        {
            {
                trig = '====',
                wordTrig = false,
                snippetType = 'autosnippet',
            },
        },
        fmt([[{}{} {}]], {
            t(' '),
            c(2, {
                t('-->'),
                t('---'),
                sn(
                    nil,
                    fmt([[-- {} -->]], {
                        i(1, 'yes'),
                    })
                ),
                sn(
                    nil,
                    fmt([[-- {} --]], {
                        i(1, 'yes'),
                    })
                ),
                sn(
                    nil,
                    fmt([[-. {} .--]], {
                        i(1, 'yes'),
                    })
                ),
                t('-.->'),
                t('==>'),
                sn(
                    nil,
                    fmt([[== {} ==>]], {
                        i(1, 'yes'),
                    })
                ),
                t('~~~'),
                t('--o'),
                t('--x'),
                t('o--o'),
                t('<-->'),
                t('x--x'),
            }),
            i(1),
        }, {
            trim_empty = false,
        })
    ),

    ms(
        {
            {
                trig = 'mermaid subgraph',
                snippetType = 'snippet',
            },
        },
        fmt(
            [[
        subgraph {}
            direction {}
            {}
        end
        ]],
            {
                i(1, 'SubgraphName'),
                c(2, {
                    t('TB'),
                    t('BT'),
                    t('RL'),
                    t('LR'),
                }),
                i(3, 'NodesInSubgraph'),
            }
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
