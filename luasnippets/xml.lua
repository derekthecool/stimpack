---@diagnostic disable: undefined-global
local snippets = {
  s(
    {
      trig = 'textblock',
      descr = 'Simple textblock',
    },

    fmt(
      [[
      <TextBlock Text="{}" />
      ]],
      {
        i(1, 'Textblock text'),
      }
    )
  ),

  s(
    {
      trig = 'textbox',
      descr = 'Simple textbox',
    },

    fmt(
      [[
    <TextBox Text="{}" />
    ]] ,
      {
        i(1, 'Textbox text'),
      }
    )
  ),
}

local autosnippets = {}

return snippets, autosnippets
