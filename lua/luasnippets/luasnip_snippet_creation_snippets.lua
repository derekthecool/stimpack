---@diagnostic disable: undefined-global, missing-parameter
local snippets = {

    s(
        {
            trig = 'snippet file',
            descr = 'Basic start for a snippet file named [ft].lua and located in the snippets directory of my neovim config',
        },

        fmt(
            [[
      ---@diagnostic disable: undefined-global, missing-parameter
      local snippets = {{
          {}
      }}

      local autosnippets = {{
          {}
      }}

      return snippets, autosnippets
      ]],
            { i(1), i(2) }
        )
    ),

    s(
        'luasnip_lambda_node',
        fmt(
            [[
        -- A shortcut for functionNodes that only do very basic string manipulation.
        -- l(lambda, argnodes):
        l(l._1:gsub('{}', '{}'), {{ {} }}),
        ]],
            {
                i(1, 'find'),
                i(2, 'replace'),
                i(3, '1, 2'),
            }
        )
    ),

    s(
        'luasnip_dynamic_lambda_node',
        fmt(
            [[
        -- Pretty much the same as lambda, but it inserts the resulting text as an insertNode, and, as such, it can be quickly overridden.
        -- dynamic_lambda(jump_indx, lambda, node_references)
        dl(l._{}:gsub('{}', '{}'), {{ {} }}),
        ]],
            {
                i(1, 'node_number_to_perform_function_on'),
                i(2, 'find'),
                i(3, 'replace'),
                i(4, 'dependant_nodes --[[ { 1, 2 }]]'),
            }
        )
    ),

    s(
        'luasnip_partial_node',
        fmt(
            [[
        -- Evaluates a function on expand and inserts its value
        ---partial(fn, params...)
        partial({})
        ]],
            {
                i(1, 'os.date, "%Y"'),
            }
        )
    ),

    s(
        'luasnip_nonempty_node',
        fmt(
            [[
        -- Inserts text if the referenced node doesn't contain any text.
        -- nonempty(node_reference, not_empty, empty):
        nonempty({}, "{}", "{}")
        ]],
            {
                i(1, '1'),
                i(2, 'Text to insert if not empty'),
                i(3, 'Text to insert if empty'),
            }
        )
    ),

    s(
        'selected_text',
        f(function(args, snip)
            local res, env = {}, snip.env
            table.insert(res, 'Selected Text (current line is ' .. env.TM_LINE_NUMBER .. '):')
            for _, ele in ipairs(env.LS_SELECT_RAW) do
                table.insert(res, ele)
            end
            return res
        end, {})
    ),

    ms({
        common = { snippetType = 'autosnippet' },
        'test1',
        'test2',
    }, {
        t('a or b (but autotriggered!!)'),
    }),

    s('ls', {
        t({ '\\begin{itemize}', '\t\\item ' }),
        i(1),
        d(2, rec_ls, {}),
        t({ '', '\\end{itemize}' }),
    }),

    s(
        'test',
        fmt([[{}]], {
            d(1, function(args, snip)
                if not snip.rows then
                    snip.rows = 1
                end
                local nodes = {}
                table.insert(nodes, i(1, 'Derek is cool'))

                -- keep track of which insert-index we're at.
                for j = 1, snip.rows do
                    table.insert(nodes, t({ '', string.format('My node: %d', j) }))
                end
                table.insert(nodes, t({ '', 'Derek is awesome' }))
                return sn(nil, nodes)
            end, {}, {
                user_args = {
                    -- Pass the functions used to manually update the dynamicNode as user args.
                    -- The n-th of these functions will be called by dynamic_node_external_update(n).
                    -- These functions are pretty simple, there's probably some cool stuff one could do
                    -- with `ui.input`
                    function(snip)
                        V('Increment row count')
                        snip.rows = snip.rows + 1
                    end,
                    -- don't drop below one.
                    function(snip)
                        V('Decrement row count')
                        snip.rows = math.max(snip.rows - 1, 1)
                    end,
                },
            }),
        })
    ),

    s(
        'tab',
        fmt(
            [[
\begin{{tabular}}{{{}}}
{}
\end{{tabular}}
]],
            {
                i(1, 'c'),
                d(2, tab, { 1 }, {
                    user_args = {
                        -- Pass the functions used to manually update the dynamicNode as user args.
                        -- The n-th of these functions will be called by dynamic_node_external_update(n).
                        -- These functions are pretty simple, there's probably some cool stuff one could do
                        -- with `ui.input`
                        function(snip)
                            V('Increment row count')
                            snip.rows = snip.rows + 1
                        end,
                        -- don't drop below one.
                        function(snip)
                            V('Decrement row count')
                            snip.rows = math.max(snip.rows - 1, 1)
                        end,
                    },
                }),
            }
        )
    ),

    -- {{{ Experiment snippets
    s('extras1', {
        i(1),
        t({ '', '' }),
        m(1, '^ABC$', 'A'),
    }),
    s('extras2', {
        i(1, 'INPUT'),
        t({ '', '' }),
        m(1, l._1:match(l._1:reverse()), 'PALINDROME'),
    }),
    s('extras3', {
        i(1),
        t({ '', '' }),
        i(2),
        t({ '', '' }),
        m({ 1, 2 }, l._1:match('^' .. l._2 .. '$'), l._1:gsub('a', 'e')),
    }),
    s('extras4', { i(1), t({ '', '' }), rep(1) }),
    s('extras5', { p(os.date, '%Y') }),
    s('extras6', { i(1, ''), t({ '', '' }), n(1, 'not empty!', 'empty!') }),
    s('extras7', { i(1), t({ '', '' }), dl(2, l._1 .. l._1, 1) }),
    -- s('extras8', {parse('"$1 is ${2|hard,easy,challenging|}"')}),
    parse('extras8', '"$TM_FILENAME"'),

    s(
        'conditional snippet',
        fmt(
            [[
        {}
        ]],
            {
                t('You are on an even line!'),
            }
        ),

        {
            show_condition = function()
                return true
            end,
            condition = function()
                local line_number = vim.api.nvim_win_get_cursor(0)[1]

                if line_number % 2 == 0 then
                    return true
                else
                    return false
                end
            end,
        }
    ),
    s(
        { trig = 'test (%d+) test', regTrig = true },
        fmt(
            [[
            {}
        ]],
            {
                f(function(args, snip)
                    return snip.captures[1]
                end, {}),
            }
        )
    ),

    s(
        { trig = 'for loop (%d+), (%d+)', regTrig = true },
        fmt(
            [[
        for i={} do
        end
        ]],
            {
                d(1, function(_, snip)
                    return sn(nil, {
                        t(snip.captures[1]),
                        t(', '),
                        t(snip.captures[2]),
                    })
                end, {}),
            }
        )
    ),
    --}}}
}

local autosnippets = {
    -- This massive snippet is used to create snippets
    -- It features several choice nodes with a simple and complex version
    s(
        'snip snip',
        fmt(
            [=[
      ms(
          {{
            {}
          }},
        fmt(
          [[
          {}
          ]],
          {{
            {}
          }}{}
        )
      ),
      ]=],
            {
                c(1, {
                    sn(
                        1,
                        fmt(
                            [[
              {{
                trig = '{}', snippetType = '{}',
              }}
              ]],
                            {
                                r(1, 'snippet_trigger'),
                                c(2, {
                                    t('snippet'),
                                    t('autosnippet'),
                                }),
                            }
                        )
                    ),

                    sn(
                        1,
                        fmt([['{}']], {
                            r(1, 'snippet_trigger'),
                        })
                    ),
                }),
                r(2, 'snippet_format'),
                r(3, 'snippet_nodes'),
                c(4, {
                    t(''),
                    sn(
                        nil,
                        fmt(
                            [[
                    ,
                    {{
                    -- Special callback functions to run. Use the index of the node to run it at or -1 to run before all nodes
                    callbacks = {{
                        [-1] = {{
                            -- Write needed using directives before expanding snippet so positions are not messed up
                            [events.pre_expand] = function()
                                add_csharp_using_statement_if_needed('NLua')
                            end,
                        }},
                    }},

                    -- For storing items for restore nodes
                    stored = {{
                        ['snippet_trigger'] = i(1, 'trigger'),
                        ['snippet_format'] = i(2),
                        ['snippet_nodes'] = i(3),
                    }},
                    }}

                    ]],
                            {}
                        )
                    ),
                }),
            }
        ),
        {
            stored = {
                ['snippet_trigger'] = i(1, 'trigger'),
                ['snippet_format'] = i(2),
                ['snippet_nodes'] = i(3),
            },
        }
    ),

    ms(
        {
            { trig = 'snip snap' },
        },
        fmt(
            [[
        {{ trig = '{}', snippetType = '{}', }},
        ]],
            {
                i(1, 'trigger'),
                c(2, {
                    t('snippet'),
                    t('autosnippet'),
                }),
            }
        )
    ),

    s(
        'snip simple',
        fmt([[s('{}', t('{}')),]], {
            i(1),
            i(2),
        })
    ),

    s(
        'snippet node',
        fmt(
            [[
            sn({},
                {}
            )
            ]],
            {
                c(1, {
                    t('nil'),
                    i(1, 'jump index'),
                }),
                c(2, {

                    -- Version that includes the fmt function
                    sn(
                        nil,
                        fmt(
                            [[
                            fmt(
                            {}
                            {}
                            {},
                            {{
                                {}
                            }}
                            )
                      ]],
                            {
                                t('[['),
                                i(1),
                                t(']]'),
                                i(2),
                            }
                        )
                    ),

                    -- Version where you just create your table of nodes
                    sn(
                        nil,
                        fmt(
                            [[
                      {{
                          {}
                      }}
                      ]],
                            {
                                i(1),
                            }
                        )
                    ),
                }),
            }
        )
    ),

    s(
        {
            trig = 'text node',
            descr = 'insert a text node',
        },
        fmt(
            [[
      t('{}'),
      {}
      ]],
            {
                i(1, 'text'),
                i(0),
            }
        )
    ),

    -- This snippet supports a choice between just insert position or position and place holder text
    s(
        {
            trig = 'insert node',
            descr = 'insert a new insert node',
        },
        fmt(
            [[
      i({}),
      {}
      ]],
            {
                c(1, {
                    sn(nil, {
                        -- i(1, '1'),
                        r(1, 'insert_node', i(1, '1')),
                        t([[, ']]),
                        i(2, 'default'),
                        t([[']]),
                    }),
                    sn(nil, {
                        r(1, 'insert_node', i(1, '1')),
                    }),
                }),
                i(0),
            }
        )
    ),

    s(
        -- This node is not a real node. It is just easier to remember by calling it this.
        'format node',
        fmta(
            [[
        fmt(
          <>
          <>
          <>,
          {
              <>
          })
        ]],
            {
                t('[['),
                i(1),
                t(']]'),
                i(2),
            }
        )
    ),

    s(
        {
            trig = 'function node',
            descr = 'insert a function node',
        },
        fmt(
            [[
      f(function(args, snip)
        {}
      end,
      {{ {} }}),
      {}
      ]],
            {
                i(1),
                i(2, ''),
                i(0),
            }
        )
    ),

    s(
        'choice node',
        fmt(
            [[
      c({},
      {{
        {}
      }}),
      {}
      ]],
            {
                i(1, 'node number'),
                sn(
                    2,
                    fmt([[{}('{}'),]], {
                        t('t'),
                        i(1, 'new text'),
                    })
                ),
                i(0),
            }
        )
    ),

    -- dynamic node
    -- The most glorious node of luasnip. You can use this to create anything!
    s(
        'dynamic node',
        fmt(
            [[
      d({}, function(args, snip)
          local nodes = {{}}

          -- Add nodes for snippet
          table.insert(nodes, t('Add this node'))
          {}

        return sn(nil, nodes)
       end,
        {{ {} }}
       {}),
      ]],
            {
                i(1, '1'),
                i(2),
                i(3, '1'),
                c(4, {
                    t(''),
                    sn(
                        nil,
                        fmt(
                            [[
                                , {{
                                        user_args = {{
                                            -- Pass the functions used to manually update the dynamicNode as user args.
                                            -- The n-th of these functions will be called by dynamic_node_external_update(n).
                                            -- These functions are pretty simple, there's probably some cool stuff one could do
                                            -- with `ui.input`
                                            function(snip)
                                                snip.rows = snip.rows + 1
                                            end,
                                            -- don't drop below one.
                                            function(snip)
                                                snip.rows = math.max(snip.rows - 1, 1)
                                        end,
                                    }},
                                }}
                   ]],
                            {}
                        )
                    ),
                }),
            }
        )
    ),

    -- end lua snip functions
}

return snippets, autosnippets
