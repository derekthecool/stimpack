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
                              ]],
      {
        i(1, 'Textbox text'),
      }
    )
  ),

  s(
    'style',
    fmt(
      [[
                              <Style Selector="{}">
                                <Setter Property="{}" Value="{}" />
                              </Style>

                              {}
                              ]],
      {
        i(1, 'TextBlock.h1'),
        i(2, 'FontSize'),
        i(3, '20'),
        i(0),
      }
    )
  ),

  s(
    'button',
    fmt(
      [[
                              <Button Content="{}" Command="{{Binding {}}}" {} />
                              ]],
      {
        i(1),
        i(2),
        i(0),
      }
    )
  ),


  -- s('setter', {t(<Setter Property=%%"),i(1,'FontSize')})
}

local autosnippets = {
  s(
    { trig = '==', wordTrig = false },
    fmt(
      [[
                              ="{}" {}
                              ]],
      {
        i(1),
        i(0),
      }
    )
  ),

  s(
    'row definition',
    fmt(
      [[
                              RowDefinitions="{}" {}
                              ]],
      {
        i(1),
        i(0),
      }
    )
  ),

  s(
    'column definition',
    fmt(
      [[
                              ColumnDefinitions="{}" {}
                              ]],
      {
        i(1),
        i(0),
      }
    )
  ),

  s(
    'grid row',
    fmt(
      [[
                              Grid.Row="{}" {}
                              ]],
      {
        i(1, '1'),
        i(0),
      }
    )
  ),

  s(
    'grid column',
    fmt(
      [[
                              Grid.Column="{}" {}
                              ]],
      {
        i(1, '1'),
        i(0),
      }
    )
  ),

}


return snippets, autosnippets
