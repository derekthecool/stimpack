---@diagnostic disable: undefined-global

local my_treesitter_functions = require('stimpack.my-treesitter-functions')

local snippets = {

  s(
    'prop',
    fmt(
      [[
      {} {} {} {{ get; set; }}
      ]],
      {
        c(1,
          {
            t('public'),
            t('private'),
          }),
        i(2, 'int'),
        i(3),
      }
    )
  ),


  s(
    'event',
    fmt(
      [[
      public event EventHandler<{}> {};

      protected virtual void On{}({} e)
      {{
          {}?.Invoke(this, e);
      }}
      ]],
      {
        i(1, 'string'),
        i(2, 'EventName'),
        rep(2),
        rep(1),
        rep(2),
      }
    )
  ),


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

  -- Avalonia snippets
  s(
    'prop Avalonia',
    fmt(
      [[
        private {} {};
        public {} {}
        {{
            get => {};
            set => this.RaiseAndSetIfChanged(ref {}, value);
        }}

        {}
      ]],
      {
        i(1, 'int'),
        i(2, 'variableName'),
        rep(1),
        i(3, 'VariableName'),
        rep(2),
        rep(2),
        i(0),
      }
    )
  ),


}

local autosnippets = {

  s(
    'PRINT',
    fmt(
      [[
      Console.WriteLine($"{}");
      ]],
      {
        i(1),
      }
    )
  ),

  s(
    'FORMAT',
    fmt(
      [[
      $"{}"
      ]],
      {
        i(1),
      }
    )
  ),

  s(
    '{{',
    fmt(
      [[{{{}}}]],
      {
        i(1),
      }
    )
  ),

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

  -- s(
  --   'FOR',
  --   fmt(
  --     [[
  --     for (int i = {}; i < {}; i++)
  --     {{
  --       {}
  --     }}
  --
  --     {}
  --     ]],
  --     {
  --       i(1, '0'),
  --       i(2, '10'),
  --       i(3),
  --       i(0),
  --     }
  --   )
  -- ),

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

  -- TODO: Add switch statement that gets all enum values if applicable

  --[[ switch (DeviceTypeEnum)
            {
                case DeviceTypeEnum.unknown:
                    break;
                case DeviceTypeEnum.BelleX:
                    break;
                case DeviceTypeEnum.BelleW:
                    break;
                default:
                    break;
            } ]]

  s(
    { trig = '(%d+)b', regTrig = true },

    fmt([[ {} {} ]], {
      f(function(_, snip)
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

        f(function(_, snip)
          return snip.captures[2] .. ' + ' .. snip.captures[1]
        end, {}),
      }
    )
  ),

  s(
    'var var',
    fmt(
      [[
      {}
      ]],
      {
        f(function()
          local variable = my_treesitter_functions.cs.get_recent_var()
          return variable
        end, {}),
      }
    )
  ),

  -- }}}
}

return snippets, autosnippets
