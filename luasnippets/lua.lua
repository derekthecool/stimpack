---@diagnostic disable: undefined-global

local my_treesitter_functions = require('stimpack.my-treesitter-functions')

local snippets = {

    -- {{{ Snippets to help create luasnip snippets
    s(
        {
            trig = 'snippet file',
            descr = 'Basic start for a snippet file named [ft].lua and located in the snippets directory of my neovim config',
        },

        fmt(
            [[
      ---@diagnostic disable: undefined-global
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

    -- }}}

    -- {{{ Neovim command and API snippets

    -- }}}
}

local autosnippets = {

    -- {{{ Neovim command and API snippets
    s('VIM.NOTIFY', fmt([[vim.notify({})]], { i(1, 'Notify text') })),
    -- }}}

    -- {{{ Fast steno commands to trigger snippets
    s(
        'IF',
        fmt(
            [[
    if {} then
       {}
    end]],
            {
                i(1),
                i(2),
            }
        )
    ),

    s(
        'ELS_EI_F',
        fmt(
            [[
        elseif {} then
          {}
        ]],
            {
                i(1),
                i(2),
            }
        )
    ),

    s(
        'ELSE',
        fmt(
            [[
        else
           {}
        ]],
            {
                i(1),
            }
        )
    ),

    -- TODO: Call different function than pairs if two arguments are used
    s(
        'FOR',
        fmt(
            [[
        for i={}, {} do
            {}
        end

        {}
        ]],
            {
                i(1, '1'),
                i(2, '100'),
                i(3),
                i(0),
            }
        )
    ),

    s(
        'FOREACH',
        fmt(
            [[
        for {} in pairs({}) do
            {}
        end

        {}
        ]],
            {
                i(1, 'item'),
                i(2, 'table'),
                i(3),
                i(0),
            }
        )
    ),

    s(
        'WHILE',
        fmt(
            [[
        while({}) do
            {}
        end

        {}
        ]],
            {
                i(1, 'condition'),
                i(2),
                i(0),
            }
        )
    ),

    s(
        'FORMAT',
        fmt(
            [[
      string.format('{}',{})
      {}
      ]],
            {
                i(1),
                i(2),
                i(0),
            }
        )
    ),

    s(
        'PRINT',
        fmt(
            [[
      print({})
      {}
      ]],
            { i(1), i(0) }
        )
    ),

    s(
        { trig = 'DESCRIBE', descr = 'Plenary test group' },
        fmt(
            [[
        describe('{}', function()
          {}
        end)

        {}
    ]],
            {
                i(1, 'Test group name '),
                d(2, function(args)
                    local test_snippet = fmt(
                        [[
          it('{}', function()
              {}
          end)
          ]],
                        {
                            i(1, 'Test name'),
                            i(2),
                        }
                    )

                    -- TODO: dynamic may not be the way to go. I may need just normal choice version
                    local runtimepath_add_in = fmt(
                        [[
          before_each(function()
            -- Run time path is not getting loaded automatically, so modify it before each test
            --
            -- Project directory tree view:
            -- lua/
            -- ├── string-calculator
            -- │   ├── init.lua
            -- │   └── string-calculator-function.lua
            -- └── tests
            --     └── string-calculator
            --         └── string-calculator_spec.lua
            --
            -- Our test files are the '_spec.lua' files. So adding the directory 4 levels up will set our runtimepath properly.

            local path_to_plugin = debug.getinfo(1).source:match("@(.*)/.*/.*/.*/.*"):gsub('"', "")
            vim.cmd('set runtimepath+=' .. path_to_plugin)
            print(string.format("Adding: %s to neovim runtimepath because plenary tests fail without this", path_to_plugin))
          end)
          ]],

                        {}
                    )

                    return sn(
                        nil,
                        {
                            c(1, {
                                t('new text'),
                                runtimepath_add_in,
                            }),
                        }

                        -- test_snippet
                    )
                end, { 1 }),

                i(3),
            }
        )
    ),

    s(
        { trig = 'TEST', descr = 'Single Plenary test' },
        fmt(
            [[
        it('{}', function()
            {}
        end)
    ]],
            {
                i(1, 'Test name'),
                i(2),
            }
        )
    ),

    -- }}}

    -- Luasnip functions

    s(
        {
            trig = 'snip snip',
            descr = 'New luasnip snippet starter',
        },
        fmt(
            [=[
      s(
        '{}',
        fmt(
          [[
          {}
          ]],
          {{
            {}
          }}
        )
      ),
      {}
      ]=],
            {
                c(1, {
                    i(1, 'short snippet trigger'),
                    sn(
                        1,
                        fmt(
                            [[
              {{
                trig = '{}',
                regTrig = {},
                descr = '{}',
              }}
              ]],
                            {
                                i(1, 'long snippet trigger'),
                                c(2, {
                                    t('true'),
                                    t('false'),
                                }),
                                i(3, 'description'),
                            }
                        )
                    ),
                }),
                i(2),
                i(3),
                i(0),
            }
        )
    ),

    s(
        {
            trig = 'long snippet trigger',
            regTrig = true,
            descr = 'description',
        },
        fmt(
            [[
      {}
      ]],
            {
                t('text'),
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
                        i(1, '1'),
                    }),
                    sn(nil, {
                        i(1, '1'),
                        t([[, ']]),
                        i(2, 'default'),
                        t([[']]),
                    }),
                }),
                i(0),
            }
        )
    ),

    -- Needs work
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
                i(2, 'node_number'),
                i(0),
            }
        )
    ),

    s(
        {
            trig = 'choice node',
            descr = 'insert a choice node',
        },
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
                i(2, [[t('new text'),]]),
                i(0),
            }
        )
    ),

    s('trig', {
        t('text: '),
        i(1),
        t({ '', 'copy: ' }),
        d(2, function(args)
            -- the returned snippetNode doesn't need a position; it's inserted
            -- "inside" the dynamicNode.
            return sn(nil, {
                -- jump-indices are local to each snippetNode, so restart at 1.
                i(1, args[1]),
            })
        end, { 1 }),
    }),

    -- add dynamic node
    s(
        'dynamic node',
        fmt(
            [[
      d({}, function(args)
        return sn(nil,{{
          {}
        }}) end,
        {{ {} }}
       )
       {}
      ]],
            {
                i(1, '1'),
                i(2),
                i(3, '1'),
                i(0),
            }
        )
    ),

    -- end lua snip functions

    s(
        'var var',
        fmt(
            [[
      {}
      ]],
            {
                f(function()
                    return my_treesitter_functions.lua.get_recent_var()
                end, {}),
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

    --}}}
}

return snippets, autosnippets
