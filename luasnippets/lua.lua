---@diagnostic disable: undefined-global

local my_treesitter_functions = require('stimpack.my-treesitter-functions')
local shiftwidth = vim.bo.shiftwidth
local shiftwidth_match_string = string.rep(' ', shiftwidth)

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
    s(
        'highlight',
        fmt(
            [[
        vim.api.nvim_set_hl(0, '{}', {{ bg = '#{}', fg = '#{}' }})
        ]],
            {
                i(1, 'ColorColumn'),
                i(2, 'FF99CC'),
                i(3, 'CCCCCC'),
            }
        )
    ),

    s(
        'lines',
        fmt(
            [[
         local lines = vim.api.nvim_buf_get_lines(0, 0,-1, false)
         for _, line in ipairs(lines) do
             {}
         end
         ]],
            {
                i(1),
            }
        )
    ),

    s(
        'nvimget cursor',
        fmt([[vim.api.nvim_win_get_cursor({})]], {
            i(1, '0'),
        })
    ),
    s(
        'nvimset cursor',
        fmt([[vim.api.nvim_win_set_cursor({}, {})]], {
            i(1, '0'),
            i(1, 'location tuple {line, column}'),
        })
    ),

    s(
        'get current line',
        fmt(
            [[
        vim.api.nvim_get_current_line()
        ]],
            {}
        )
    ),

    s(
        'autocommand',
        fmt(
            [[
        local {} = vim.api.nvim_create_augroup('{}', {{ clear = true }})
        vim.api.nvim_create_autocmd(
            '{}',
            {{ pattern = {{ '{}' }}, command = '{}', group = {} }}
        )
        ]],
            {
                i(1, 'autocommandGroupName'),
                rep(1),
                i(2, 'Event'),
                i(3, 'File pattern'),
                i(4, 'Command'),
                rep(1),
            }
        )
    ),
    s(
        'map',
        fmt(
            [[
        vim.keymap.set('{}', '{}', '{}', {{ silent = true }})
        ]],
            {
                i(1, 'mode'),
                i(2, 'lhs'),
                i(3, 'rhs'),
            }
        )
    ),

    -- }}}

    s(
        'module',
        fmt(
            [[
        local {} = {{}}

        {}

        return {}
        ]],
            {
                i(1, 'M'),
                i(2),
                rep(1),
            }
        )
    ),

    s(
        'plugin',
        fmt(
            [[
        return {{
            '{}',
            dependencies = {{
                {}
            }},
            -- event = 'VeryLazy',
            -- cmd = {{{{""}}}},
            -- lazy = true,
            -- ft = "cs",
            -- cond = (1 == 1) -- decide to load plugin or not
            -- priority = 50, --default 50
            -- config = {{
            --
            -- }},
        }}
        ]],
            {
                i(1),
                i(2),
            }
        )
    ),

    s(
        'metaset',
        fmt([[setmetatable({}, {})]], {
            i(1, 'tableToSetMetaTableOn'),
            i(2, 'metaTable'),
        })
    ),
}

local autosnippets = {

    s(
        'INCLUDE',
        fmt(
            [[
        require('{}')
        ]],
            {
                i(1),
            }
        )
    ),

    -- TODO: possible enhancement check if inside lua table with treesitter field table_constructor
    s(
        'TABLE',
        fmt(
            [[
        = {{
            {}
        }}
        ]],
            {
                i(1),
            }
        )
    ),

    s(
        'KEY',
        fmt(
            [[
        {} = {},
        ]],
            {
                i(1, 'key'),
                i(2, 'value'),
            }
        )
    ),

    -- {{{ Neovim command and API snippets
    s(
        'VIM.NOTIFY',
        fmt([[vim.notify('{}', {}, {{ title = '{}' }})]], {
            i(1, 'Notify text'),
            c(2, {
                t('vim.log.levels.INFO'),
                t('vim.log.levels.ERROR'),
                t('vim.log.levels.TRACE'),
                t('vim.log.levels.WARN'),
                t('vim.log.levels.DEBUG'),
                t('vim.log.levels.OFF'),
            }),
            i(3, 'Stimpack Notification'),
        })
    ),
    -- }}}

    -- {{{ Fast steno commands to trigger snippets
    s(
        'IF',
        fmt(
            [[
            if {} then
                {}
            end

            {}]],
            {
                i(1),
                i(2),
                i(0),
            }
        )
    ),

    s(
        { trig = shiftwidth_match_string .. 'ELS_EI_F', regTrig = true, wordTrig = false },
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
        { trig = shiftwidth_match_string .. 'ELSE', regTrig = true, wordTrig = false },
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

    s(
        'FUNCTION',
        fmt(
            [[
        {}function{}({})
          {}
        end

        {}
        ]],
            {
                c(1, {
                    t(''),
                    t('local '),
                }),

                c(2, {
                    sn(nil, {
                        t(' '),
                        i(1, 'FunctionName'),
                    }),
                    t(''),
                }),

                i(3),
                i(4),
                i(0),
            }
        )
    ),

    -- TODO: Call different function than pairs if two arguments are used
    s(
        { trig = '(%w+),? (%w+) FOR', regTrig = true },
        fmt(
            [[
        for {} do
            {}
        end

        {}
        ]],
            {
                d(1, function(args, snip)
                    -- Check for numeric for loop, only lower bound needs to be number
                    if snip.captures[1]:match('%d+') then
                        return sn(nil, {
                            t('i='),
                            t(snip.captures[1]),
                            t(', '),
                            t(snip.captures[2]),
                        })
                    elseif snip.captures[1]:match('i?pairs') then
                        return sn(nil, {
                            t(string.format('k, v in %s(%s)', snip.captures[1], snip.captures[2])),
                        })
                    else
                        return sn(nil, {
                            i(1),
                            t('in'),
                            i(2),
                        })
                    end
                end, { 1 }),
                i(2),
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
        describe('{} --', function()
          {}
        end)

        {}
    ]],
            {
                i(1, 'Test group name '),
                d(2, function()
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
        'nvimcommand',
        fmt(
            [[
            vim.api.nvim_cmd({{ cmd = '{}', args = {{ '{}' }} }}, {{}})
            ]],
            {
                i(1, 'command'),
                i(2),
            }
        )
    ),

    s(
        'TEST',
        fmt(
            [[
            it('{}', function()
                {}
            end)
            ]],
            {
                i(1),
                i(2),
            }
        )
    ),

    s(
        'ASSERT',
        fmt(
            [[
        assert.{}({})
        ]],
            {
                c(1, {
                    t('are.same'),
                    t('is.same'),
                    t('are_not.equals'),
                    t('are_not.equal'),
                    t('is_not.equal'),
                    t('truthy'),
                    t('is.truthy'),
                    t('True'),
                    t('is_true'),
                    t('falsy'),
                    t('is.falsy'),
                    t('has_error(function() end)'),
                    t('has_no_errors(function() end)'),
                    t('are.unique'),
                }),
                i(2),
            }
        )
    ),

    -- }}}

    -- Luasnip functions

    s(
        'snip snip',
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

    -- add dynamic node
    s(
        'dynamic node',
        fmt(
            [[
      d({}, function(args, snip)
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

return snippets, autosnippets
