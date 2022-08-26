---@diagnostic disable: undefined-global

local my_treesitter_functions = require('stimpack.my-treesitter-functions')

local snippets = {

  -- {{{ clang format disable block
  s(
    {
      trig = 'clangf',
      descr = 'Comment string to disable clang formatting',
    },
    fmt(
      [[
      // clang-format off
      {}
      // clang-format on
      ]],
      { i(1) }
    )
  ),
  -- }}}

  -- {{{ easy strtok
  s(
    {
      trig = 'strtok_ez',
      descr = 'Easily use strtok with a for loop',
    },
    fmt(
      [[
      for (char *p = strtok({}, ","); p != NULL; p = strtok(NULL, ","))
      {{
        returnValue += atoi(p);
      }}
      {}
      ]],
      { i(1, 'InputStringToParse'), i(2) }
    )
  ),
  -- }}}
}

local autosnippets = {

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
}

return snippets, autosnippets
