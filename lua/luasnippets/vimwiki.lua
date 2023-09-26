---@diagnostic disable: undefined-global

local auxiliary = require('luasnippets.functions.auxiliary')

local snippets = {

    s(
        'footnote',
        fmt([[{}{}{}]], {
            t('['),
            i(1),
            f(function(args, snip)
                return ']'
            end, { 1 }),
        }),
        {
            callbacks = {
                [1] = {
                    [events.leave] = function(node, event_args)
                        local text = string.format('[%s]: ', node:get_text()[1])
                        vim.cmd('normal mm')
                        vim.api.nvim_buf_set_lines(0, -1, -1, false, { text })
                        V('Jumping to end of file to write footnote, position saved at mark m')
                        -- vim.cmd('normal GA')
                        -- vim.api.nvim_win_set_cursor(0,{-1,-1})
                        local esc_key = api.nvim_replace_termcodes('<Esc>', true, false, true)
                        api.nvim_feedkeys(esc_key, 'm', true)
                        -- vim.api.nvim_feedkeys('GA', 'i', false)
                    end,
                },
            },
        }
    ),

    s(
        'footnote',
        fmt(
            [[
        [{}]:{}
        ]],
            {
                i(1, 'reference name'),
                i(2, 'link'),
            }
        )
    ),

    s(
        'selected_text',
        f(function(_, snip)
            local res, env = {}, snip.env
            table.insert(res, 'Selected Text (current line is ' .. env.TM_LINE_NUMBER .. '):')
            for _, ele in ipairs(env.LS_SELECT_RAW) do
                table.insert(res, ele)
            end
            return res
        end, {})
    ),

    s(
        {
            trig = 'link',
            descr = 'Create markdown link [txt](url)',
        },
        fmt(
            [[
            [{}]({})
            {}
            ]],
            {
                i(1),
                f(function()
                    return vim.fn.getreg('+')
                end, {}),
                i(0),
            }
        )
    ),

    s(
        'image',
        fmt([[![{}]({})]], {
            i(1, 'alt text'),
            i(2, 'image path'),
        })
    ),

    s(
        'pandoc header',
        fmt(
            [[
        % {}
        % {}
        % {}

        # {}

        {}
        ]],
            {
                i(1, 'Title'),
                i(2, 'Derek Lomax'),
                f(function()
                    return os.date('%Y-%m-%d')
                end, {}),
                rep(1),
                i(0),
            }
        )
    ),

    -- {{{ hugo snippets
    s(
        'hugo_front',
        fmt(
            [[
      ---
      title: "{}"
      date: {}
      categories: {}
      draft: {}
      ---

      # {}

      {}
      ]],
            {

                f(function()
                    return (vim.fn.expand('%:t'):gsub('-', ' '):gsub('.md', ''))
                end),
                t(os.date('%Y-%m-%dT%H:%M:%S')),
                sn(
                    1,
                    fmt('[\'{}\']', {
                        i(1, 'stenography'),
                    })
                ),

                c(2, {
                    t('true'),
                    t('false'),
                }),

                f(function()
                    return (vim.fn.expand('%:t'):gsub('-', ' '):gsub('.md', ''))
                end),
                i(0),
            }
        )
    ),

    -- }}}

    -- {{{ Mermaid-JS snippets

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

    s(
        'CHANGELOG.md',
        fmt(
            [[
        # {} CHANGELOG

        All notable changes to this project will be documented in this file.
        The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
        and this project adheres to
        [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

        {}
        ]],
            {
                i(1, 'ProjectTitle'),
                i(0),
            }
        )
    ),

    s(
        'CHANGELOG.md item',
        fmt(
            [[
        ## {}

        ### {}

        - {}
        ]],
            {
                i(1, 'Version information'),
                i(2, 'Changed'),
                i(3),
            }
        )
    ),
}

local autosnippets = {

    s(
        '```',
        fmt(
            [[
            ```{}
            {}
            ```
            ]],
            {
                c(1, {
                    t('yaml'),
                    t('sh'),
                    t('powershell'),
                    t('fsharp'),
                    t('csharp'),
                    t('c'),
                    i(1),
                }),
                auxiliary.wrap_selected_text(2),
            }
        )
    ),

    s(
        'dick',
        fmt(
            [[
            {} : {{^}}{}{{^}}
            {}
            ]],
            {
                i(1, 'STKPWHRAO*EUFRPBLTS'),
                i(2),
                i(0),
            }
        )
    ),

    s(
        'TASK',
        fmt('- [ ] {}', {
            i(1),
        })
    ),

    s(
        'FIRST',
        fmt(
            [[
        # {} Notes

        ## Work Objectives

        ### Planned

        - [ ] {}

        ## Rock Progress

        - [FloatingTodoList](FloatingTodoList)
        - [Rocks](../rocks/Rocks.md)

        ## Notes
        ]],
            {
                f(function(args, snip)
                    return os.date('%Y-%m-%d')
                end, {}),
                i(1),
            }
        )
    ),

    s(
        'SECOND',
        fmt(
            [[
        # {}

        {}
        ]],
            {
                f(function(args, snip)
                    return vim.fn
                        .expand('%:t')
                        :gsub('_(%w)', function(a)
                            return a:toupper()
                        end)
                        :gsub('%.md', '')
                end, {}),

                i(1),
            }
        )
    ),
}

return snippets, autosnippets

-- snippet link "Markdown web or file link"
-- [${1:Description}](${2:URL})
-- endsnippet
--
-- snippet flowchartFlowchartJS "Create a flowchart JS markdown starter" b
-- \`\`\`flowchart
-- # ${1:FlowchartTitle}
-- start=>start
-- end=>end
-- op1=>operation: ${2:FirstOperation}
--
-- start->op1
-- \`\`\`
-- endsnippet
--
-- snippet operation_FlowchartJS "Insert flowchart operation" b
-- op${1:Number}=>operation: ${2:Name}
-- endsnippet
--
-- snippet condition_FlowchartJS "Insert flowchart conditional" b
-- cond${1:Number}=>condition: ${2:Name}
-- endsnippet
--
-- snippet subroutine_FlowchartJS "Insert flowchart subroutine" b
-- sub${1:Number}=>subroutine: ${2:Name}
-- endsnippet
--
-- snippet input-output_FlowchartJS "Insert flowchart IO" b
-- io${1:Number}=>inputoutout: ${2:Name}
-- endsnippet
--
-- snippet parallel-task_FlowchartJS "Insert flowchart parallel task" b
-- para${1:Number}=>parallel: ${2:Name}
-- endsnippet
--
-- snippet CHANGELOG-starter "CHANGELOG template from KeepAChangeLog.com" b
-- # ${1:ProjectTitle} CHANGELOG
--
-- All notable changes to this project will be documented in this file.
-- The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
-- and this project adheres to
-- [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
--
-- ## [Unreleased]
--
-- ## [1.0.0] - 2017-06-20
--
-- ### Added
--
-- [Unreleased]: https://github.com/${2:derekthecool}/$1/compare/v1.0.0...HEAD
-- [1.0.0]: https://github.com/$2/$1/compare/v0.3.0...v1.0.0
-- endsnippet
--
-- snippet CollapsibleSectionMarkdown "Create a collapsible section using html hack" b
-- <details>
-- <summary>${1:ClickHereToExpand}</summary>
--
-- ${2:## Section Heading}
--
-- </details>
-- endsnippet
--
-- snippet mermaid-Flowchart "Create a Mermaid-JS Flowchart" b
-- \`\`\`mermaid
-- graph ${1:TD}
--
-- A[Start] --> B{Is it?};
-- B -- Yes --> C[OK];
-- C --> D[Rethink];
-- D --> B;
-- B -- No ----> E[End];
--
-- \`\`\`
-- endsnippet
--
-- snippet mermaid-FlowchartSubgraph "Create a subchart in a Mermaid-JS Flowchart" b
-- \`\`\`mermaid
-- subgraph ${1:name}
--
-- end
-- \`\`\`
-- endsnippet
--
--
-- snippet mermaid-SequenceDiagram "Create a Mermaid-JS Sequence Diagram" b
-- \`\`\`mermaid
-- sequenceDiagram
--
-- %% There are six types of arrows currently supported:
-- %% Type	Description
-- %% ->	Solid line without arrow
-- %% -->	Dotted line without arrow
-- %% ->>	Solid line with arrowhead
-- %% -->>	Dotted line with arrowhead
-- %% -x	Solid line with a cross at the end
-- %% --x	Dotted line with a cross at the end.
-- %% -)	Solid line with an open arrow at the end (async)
-- %% --)	Dotted line with a open arrow at the end (async)
--
-- participant John
-- participant A as Alice
-- John ->> A: Hi
-- A -->> John: Hello
--
-- \`\`\`
-- endsnippet
--
-- snippet mermaid-ClassDiagram "Create a Mermaid-JS Class Diagram" b
-- \`\`\`mermaid
-- classDiagram
--
-- Animal <|-- Duck
-- Animal <|-- Fish
-- Animal <|-- Zebra
-- Animal : +int age
-- Animal : +String gender
-- Animal: +isMammal()
-- Animal: +mate()
-- class Duck{
-- 		+String beakColor
-- 		+swim()
-- 		+quack()
-- }
-- class Fish{
-- 		-int sizeInFeet
-- 		-canEat()
-- }
-- class Zebra{
-- 		+bool is_wild
-- 		+run()
-- }
--
-- \`\`\`
-- endsnippet
--
--
-- snippet mermaid-StateDiagram "Create a Mermaid-JS State Diagram" b
-- \`\`\`mermaid
-- stateDiagram-v2
--
-- [*] --> Still
-- Still --> [*]
--
-- Still --> Moving
-- Moving --> Still
-- Moving --> Crash
-- Crash --> [*]
--
-- \`\`\`
-- endsnippet
--
-- snippet mermaid-Journey "Create a Mermaid-JS Journey Diagram" b
-- \`\`\`mermaid
-- journey
-- title ${1:Journey Title}
--
-- section Go to work
-- 	Make tea: 5: Me
-- 	Go upstairs: 3: Me
-- 	Do work: 1: Me, Cat
-- section Go home
-- 	Go downstairs: 5: Me
-- 	Sit down: 5: Me
--
-- \`\`\`
-- endsnippet
--
-- snippet mermaid-Gantt "Create a Mermaid-JS Gantt Diagram" b
-- \`\`\`mermaid
-- gantt
-- title ${1:Gantt Chart}
--
-- dateFormat  YYYY-MM-DD
-- section Section
-- A task           :a1, 2014-01-01, 30d
-- Another task     :after a1  , 20d
-- section Another
-- Task in sec      :2014-01-12  , 12d
-- another task      : 24d
--
-- \`\`\`
-- endsnippet
--
-- snippet mermaid-Pie "Create a Mermaid-JS Pie Chart" b
-- \`\`\`mermaid
-- pie title ${1:Pie Chart Title}
--
-- "Dogs" : 386
-- "Cats" : 85
-- "Rats" : 15
--
-- \`\`\`
-- endsnippet
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
-- priority -50
--
-- global !p
-- # A overkill(dirty) table with automatic alignment feature
-- def create_table(snip):
-- 	# retrieving single line from current string and treat it like tabstops count
-- 	placeholders_string = snip.buffer[snip.line].strip()
-- 	rows_amount = int(placeholders_string[0])
-- 	columns_amount = int(placeholders_string[1])
--
-- 	prefix_str = "from vimsnippets import display_width;"
--
-- 	# erase current line
-- 	snip.buffer[snip.line] = ""
--
-- 	# create anonymous snippet with expected content and number of tabstops
-- 	anon_snippet_title = "| "
-- 	anon_snippet_delimiter = "|"
-- 	for col in range(1, columns_amount+1):
-- 		sync_rows = [x*columns_amount+col for x in range(rows_amount+1)]
-- 		sync_str = ",".join(["t[{0}]".format(x) for x in sync_rows])
-- 		max_width_str = "max(list(map(display_width, [" + sync_str + "])))"
-- 		cur_width_str = "display_width(t[" + str(col) + "])"
-- 		rv_val = "(" + max_width_str + "-" + cur_width_str + ")*' '"
-- 		anon_snippet_title += "${" + str(col)  + ":head" + str(col)\
-- 			+ "}`!p " + prefix_str + "snip.rv=" + rv_val + "` | "
-- 		anon_snippet_delimiter += ":`!p " + prefix_str + "snip.rv = "\
-- 			+ max_width_str + "*'-'" + "`-|"
--
-- 	anon_snippet_title += "\n"
--
-- 	anon_snippet_delimiter += "\n"
-- 	anon_snippet_body = ""
-- 	for row in range(1, rows_amount+1):
-- 		body_row = "| "
-- 		for col in range(1, columns_amount+1):
-- 			sync_rows = [x*columns_amount+col for x in range(rows_amount+1)]
-- 			sync_str = ",".join(["t[{0}]".format(x) for x in sync_rows])
-- 			max_width_str = "max(list(map(display_width, [" + sync_str + "])))"
-- 			cur_width_str = "display_width(t[" + str(row*columns_amount+col) + "])"
-- 			rv_val = "(" + max_width_str + "-" + cur_width_str + ")*' '"
-- 			placeholder = "R{0}C{1}".format(row, col)
-- 			body_row += "${" + str(row*columns_amount+col)  + ":" + placeholder\
-- 				+ "}`!p " + prefix_str + "snip.rv=" + rv_val + "` | "
--
-- 		body_row += "\n"
-- 		anon_snippet_body += body_row
--
-- 	anon_snippet_table = anon_snippet_title + anon_snippet_delimiter + anon_snippet_body
--
-- 	# expand anonymous snippet
-- 	snip.expand_anon(anon_snippet_table)
-- endglobal
--
-- ###########################
-- # Sections and Paragraphs #
-- ###########################
-- snippet sec "Section" b
-- # ${1:Section Name} #
-- $0
-- endsnippet
--
-- snippet ssec "Sub Section" b
-- ## ${1:Section Name} ##
-- $0
-- endsnippet
--
-- snippet sssec "SubSub Section" b
-- ### ${1:Section Name} ###
-- $0
-- endsnippet
--
-- snippet par "Paragraph" b
-- #### ${1:Paragraph Name} ####
-- $0
-- endsnippet
--
-- snippet spar "Paragraph" b
-- ##### ${1:Paragraph Name} #####
-- $0
-- endsnippet
--
-- ###################
-- # Text formatting #
-- ###################
--
-- snippet * "italics"
-- *${1:${VISUAL}}*$0
-- endsnippet
--
-- snippet ** "bold"
-- **${1:${VISUAL}}**$0
-- endsnippet
--
-- snippet *** "bold italics"
-- ***${1:${VISUAL}}***$0
-- endsnippet
--
-- snippet /* "Comment"
-- <!-- ${1:${VISUAL}} -->$0
-- endsnippet
--
-- ################
-- # Common stuff #
-- ################
-- snippet link "Link to something"
-- [${1:${VISUAL:Text}}](${3:https://${2:www.url.com}})$0
-- endsnippet
--
-- snippet img "Image"
-- ![${1:pic alt}](${2:path}${3/.+/ "/}${3:opt title}${3/.+/"/})$0
-- endsnippet
--
-- snippet ilc "Inline Code" i
-- \`${1:${VISUAL}}\`$0
-- endsnippet
--
-- snippet qq "Codeblock" bA
-- ```
-- ${1}
-- ```
-- $0
-- endsnippet
--
-- snippet qy "Codeblock" bA
-- ```yaml
-- $0
-- ```
-- endsnippet
--
-- snippet refl "Reference Link"
-- [${1:${VISUAL:Text}}][${2:id}]$0
--
-- [$2]:${4:https://${3:www.url.com}} "${5:$4}"
-- endsnippet
--
-- snippet fnt "Footnote"
-- [^${1:${VISUAL:Footnote}}]$0
--
-- [^$1]:${2:Text}
-- endsnippet
