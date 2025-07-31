---@diagnostic disable: undefined-global, missing-parameter

local shareable = require('luasnippets.functions.shareable_snippets')

local snippets = {
    ms(
        {
            { trig = 'mermaid_rounded_box', snippetType = 'snippet', condition = nil },
        },
        fmt('{Name}([{Text}])', {
            Name = i(1, 'RoundedBox'),
            Text = i(2, 'This is the text'),
        })
    ),

    ms(
        {
            { trig = 'mermaid_edged_box', snippetType = 'snippet', condition = nil },
            { trig = 'mermaid_node_in_subroutine', snippetType = 'snippet', condition = nil },
        },
        fmt('{Name}[[{Text}]]', {
            Name = i(1, 'NodeInSubRoutine'),
            Text = i(2, 'This is the text'),
        })
    ),

    ms(
        {
            { trig = 'mermaid_cylinder', snippetType = 'snippet', condition = nil },
        },
        fmt('{Name}[({Text})]', {
            Name = i(1, 'Cylinder'),
            Text = i(2, 'This is the text'),
        })
    ),

    ms(
        {
            { trig = 'mermaid_circle', snippetType = 'snippet', condition = nil },
        },
        fmt('{Name}(({Text}))', {
            Name = i(1, 'Circle'),
            Text = i(2, 'This is the text'),
        })
    ),

    ms(
        {
            { trig = 'mermaid_asymmetric', snippetType = 'snippet', condition = nil },
        },
        fmt('{Name}>{Text}]', {
            Name = i(1, 'Asymmetric'),
            Text = i(2, 'This is the text'),
        })
    ),

    ms(
        {
            { trig = 'mermaid_rhombus', snippetType = 'snippet', condition = nil },
        },
        fmt('{Name}{{{Text}}}', {
            Name = i(1, 'Asymmetric'),
            Text = i(2, 'This is the text'),
        })
    ),

    ms(
        {
            { trig = 'mermaid_if', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [=[
        {Name}{{{Condition}}}
        {NameRep} -->|{LeftText}| {Left}
        {NameRep} -->|{RightText}| {Right}
        ]=],
            {
                Name = i(1, 'IfConditionDescription'),
                Condition = i(2, 'Meets these conditions?'),
                NameRep = rep(1),
                LeftText = i(3, 'Yes'),
                Left = i(4, 'YesCode'),
                RightText = i(5, 'No'),
                Right = i(6, 'NoCode'),
            }
        )
    ),

    ms(
        {
            { trig = 'mermaid_markdown', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [=[
        MarkdownText["`* Line one
        * Line two
        * Line three`"]
        ]=],
            {}
        )
    ),

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
