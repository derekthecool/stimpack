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

  s(
    {
      trig = ';l',
      name = 'fast option',
    },

    fmt([[ - [{}] ]], {
      -- return option "plugin"
      d(1, function()
        local options = { ' ', 'x', '-', '=', '_', '!', '+', '?' }
        for i = 1, #options do
          options[i] = t(options[i])
        end
        return sn(nil, {
          c(1, options),
        })
      end),
    })
  ),
}

return snippets, autosnippets
