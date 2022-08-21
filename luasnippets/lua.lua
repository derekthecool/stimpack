---@diagnostic disable: undefined-global

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
          it('{}', function()
              {}
          end)
        end)
    ]] ,
      {
        i(1, 'Test group name '),
        i(2, 'Test name'),
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
        end),
    ]] ,
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
      trig = 'snip',
      descr = 'New luasnip snippet starter',
    },
    fmta(
      [[
      s(
      {
        trig = "<>",
        descr = "<>",
      },
      fmt(
        <>
        <>
        <>,
          {
            <>
          })
       ),
       <>
       ]],
      { i(1), i(2), t('[['), i(3), t(']]'), i(4), i(5) }
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

  s(
    {
      trig = 'insert node',
      descr = 'insert a new insert node',
    },
    fmt(
      [[
      i({}, '{}'),
      {}
      ]],
      {
        i(1, '1'),
        i(2, 'default'),
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
    f(return function()
      {}
    end,
    {{ {} }},
    ),
    {}
    ]] ,
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
        i(2, [[t('new text')]]),
        i(0),
      }
    )
  ),

  -- add dynamic node

  -- add restore node

  --
}

return snippets, autosnippets
