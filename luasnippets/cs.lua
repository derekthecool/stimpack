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
    {
      trig = 'IF',
      descr = 'fast if statement',
    },
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
    {
      trig = 'ELS_EI_F',
      descr = 'fast else if',
    },
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
    {
      trig = 'ELSE',
      descr = 'fast else statement',
    },
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
    {
      trig = 'FOR',
      descr = 'fast for loop',
    },
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

  -- }}}
}

return snippets, autosnippets
