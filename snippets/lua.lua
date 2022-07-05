---@diagnostic disable: undefined-global
local snippets = {

  -- {{{ Snippets to help create luasnip snippets
  s(
    {
      trig = "snippet file",
      descr = "Basic start for a snippet file named [ft].lua and located in the snippets directory of my neovim config",
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
      ]], { i(1), i(2) })
  ),

  s(
    {
      trig = "snip",
      descr = "New luasnip snippet starter",
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
      { i(1), i(2), t '[[', i(3), t ']]', i(4), i(5) })
  ),
  -- }}}

  s(
    {
      trig = "TM",
      descr = "Test all TM values",
    },

    f(function(_, snip)
      return " snip.env.TM_FILENAME = " .. snip.env.TM_FILENAME
          .. " snip.env.TM_DIRECTORY = " .. snip.env.TM_DIRECTORY
          .. " snip.env.TM_LINE_INDEX = " .. snip.env.TM_LINE_INDEX
          .. " snip.env.TM_FILEPATH = " .. snip.env.TM_FILEPATH
          .. " snip.env.TM_LINE_NUMBER = " .. snip.env.TM_LINE_NUMBER
          .. " snip.env.TM_CURRENT_WORD = " .. snip.env.TM_CURRENT_WORD
    end, {})
  ),


}

local autosnippets = {

  -- Fast if statement for steno input
  s('IF',

    fmt(
      [[
    if {} then
       {}
    end
    ]] ,
      {
        i(1), i(2)
      })
  ),

  s(
    {
      trig = ";l",
      name = "fast option",
    },

    fmt([[ - [{}] ]], {
      -- return option "plugin"
      d(1, function()
        local options = { " ", "x", "-", "=", "_", "!", "+", "?" }
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
