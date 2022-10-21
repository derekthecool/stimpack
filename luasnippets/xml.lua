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

    s(
        'item group',
        fmt(
            [[
      <ItemGroup>
        {}
      </ItemGroup>
      ]]     ,
            {
                i(1),
            }
        )
    ),

    s(
        'package reference',
        fmt(
            [[
      {}
      ]]     ,
            {
                c(1, {
                    fmt([[<PackageReference Include="{}" Version="{}" />]], {
                        i(1),
                        i(2),
                    }),
                    -- Database
                    t('<PackageReference Include="Microsoft.EntityFrameworkCore" Version="7.0.0-rc.2.22472.11" />'),
                    t('<PackageReference Include="Dapper" Version="2.0.123" />'),
                    t('<PackageReference Include="MySql.Data" Version="8.0.31" />'),
                    -- Networking
                    t('<PackageReference Include="M2Mqtt" Version="4.3.0" />'),
                    -- Encoding
                    t('<PackageReference Include="Newtonsoft.Json" Version="13.0.2-beta2" />'),
                    t('<PackageReference Include="Google.Protobuf" Version="3.21.7" />'),
                    t('<PackageReference Include="Google.Protobuf.Tools" Version="3.21.7" />'),
                    -- Local device IO
                    t('<PackageReference Include="sharpadbclient" Version="2.3.23" />'),
                    -- Logging
                    t('<PackageReference Include="Serilog" Version="4.3.0" />'),
                    t('<PackageReference Include="Serilog.Sinks.File" Version="5.0.1-dev-00947" />'),
                    t('<PackageReference Include="Serilog.Sinks.RollingFile" Version="3.3.1-dev-00771" />'),
                    t('<PackageReference Include="Serilog.Sinks.Async" Version="1.5.0" />'),
                    t('<PackageReference Include="Serilog.Sinks.Console" Version="4.1.1-dev-00896" />'),
                    t('<PackageReference Include="Serilog.Sinks.MicrosoftTeams" Version="0.2.1" />'),
                }),
            }
        )
    ),
}

return snippets, autosnippets
