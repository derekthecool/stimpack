---@diagnostic disable: undefined-global

local snippets = {

  -- {{{ Comment XML snippets
  s(
    {
      trig = 'param',
      descr = 'XML parameter comment',
    },
    fmt([[<param name="{}">{}</param>]], {
      i(1),
      i(2),
    })
  ),

  s(
    {
      trig = 'exception',
      descr = 'XML exception comment',
    },
    fmt([[<exception cref="{}">{}</exception>]], {
      i(1, 'System.Exception'),
      i(2),
    })
  ),

  s(
    {
      trig = 'returns',
      descr = 'XML returns comment',
    },
    fmt([[<returns>{}</returns>]], {
      i(1),
    })
  ),

  s(
    {
      trig = 'code',
      descr = 'XML code comment',
    },
    fmt([[<code>{}</code>]], {
      i(1),
    })
  ),
  -- }}}
}

local autosnippets = {

  -- {{{ XML autosnippet starter
  s(
    {
      trig = '///',
      descr = 'XML comment summary',
    },
    fmt(
      [[
    /// <summary>
    /// {}
    /// </summary>
    ]] ,
      {
        i(1),
      }
    )
  ),
  -- }}}

  -- {{{ Fast steno commands to trigger snippets
  s(
    'IF',
    fmt(
      [[
      if ({})
      {{
        {}
      }}
      {}
      ]],
      {
        i(1, 'true'),
        i(2),
        i(0),
      }
    )
  ),

  s(
    'ELS_EI_F',
    fmt(
      [[
      else if ({})
      {{
        {}
      }}
      {}
      ]],
      {
        i(1, 'false'),
        i(2),
        i(0),
      }
    )
  ),

  s(
    'ELSE',
    fmt(
      [[
      else
      {{
        {}
      }}

      {}
      ]],
      {
        i(1),
        i(0),
      }
    )
  ),

  s(
    'FOR',
    fmt(
      [[
      for (int i = {}; i < {}; i++)
      {{
        {}
      }}

      {}
      ]],
      {
        i(1, '0'),
        i(2, '10'),
        i(3),
        i(0),
      }
    )
  ),

  s(
    'FUNCTION',
    fmt(
      [[
      {} {} {}({})
      {{
        {}
      }}

      {}
      ]],
      {
        c(1, {
          t('public'),
          t('private'),
        }),

        c(2, {
          t('int'),
          t('bool'),
          t('string'),
          i(1),
        }),

        --TODO: Add choice-node here
        i(3, 'AwesomeFunction'),

        i(4, 'int params'),
        i(5),
        i(0),
      }
    )
  ),

  s(
    { trig = '(%d+)b', regTrig = true },

    fmt([[ {} {} ]], {
      f(function(args, snip)
        return 'Captured Text: ' .. snip.captures[1] .. '.'
      end, {}),

      t('Derek is cool!'),
    })
  ),

  s(
    {
      trig = ' Derek (%d+) (%w+) ',
      regTrig = true,
      descr = 'test test',
    },
    fmt(
      [[
      {} {}
      ]],
      {
        t(' Derek test: '),

        f(function(args, snip)
          return snip.captures[2] .. ' + ' .. snip.captures[1]
        end, {}),
      }
    )
  ),

  -- }}}
}

return snippets, autosnippets
