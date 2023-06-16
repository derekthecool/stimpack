---@diagnostic disable: undefined-global
local snippets = {

    s(
        'combo box',
        fmt([[<ComboBox {} ItemsSource="{{Binding {}}}" />]], {
            i(1),
            i(2, 'ItemsSourceName'),
        })
    ),

    s(
        'grid',
        fmt(
            [[
        <Grid  ColumnDefinitions="{}" RowDefinitions="{}" >
          {}
        </Grid>
        ]],
            {
                i(1, '*,*,*'),
                i(2, '*,*,*'),
                i(3),
            }
        )
    ),

    s(
        'data grid',
        fmt(
            [[
        <DataGrid Name="{}" Items="{{Binding {}}}" AutoGenerateColumns="True" CanUserReorderColumns="True" CanUserResizeColumns="True" CanUserSortColumns="True"/>
        ]],
            {
                i(1, 'MyDataGrid'),
                i(2, 'ListSource'),
            }
        )
    ),

    s(
        'styles',
        fmt(
            [[
        <Styles xmlns="https://github.com/avaloniaui" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml">
            <Style Selector="{}">
            <Setter Property="{}" Value="{}" />
            </Style>
        </Styles>
        ]],
            {
                i(1, 'TextBlock.h1'),
                i(2, 'FontSize'),
                i(3, '20'),
            }
        )
    ),

    s(
        'style',
        fmt(
            [[
            <Style Selector="{}">
              <Setter Property="{}" Value="{}" />
            </Style>{}
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
        'Class',
        fmt([[Class="{}"]], {
            i(1, 'h1'),
        })
    ),

    s(
        'button',
        fmt(
            [[
                              <Button Content="{}" Command="{{Binding {}}}" {} />
                              ]],
            {
                i(1),
                i(2, 'ButtonFunctionName'),
                i(0),
            }
        )
    ),

    s(
        'output type',
        fmt([[<OutputType>{}</OutputType>]], {
            i(1, 'WinExe'),
        })
    ),
    s(
        'target framework',
        fmt([[<TargetFramework>{}</TargetFramework>]], {
            i(1, 'net6.0'),
        })
    ),

    s(
        'nullable',
        fmt([[<Nullable>{}</Nullable>]], {
            c(1, {
                t('enable'),
                t('disable'),
            }),
        })
    ),
    s(
        'icon',
        fmt([[<ApplicationIcon>{}</ApplicationIcon>]], {
            i(1, 'Path to ico file'),
        })
    ),
    s(
        'trim mode',
        fmt([[<TrimMode>{}</CopyUsed>]], {
            i(1, 'copyused'),
        })
    ),
    s(
        'com support',
        fmt([[<BuiltInComInteropSupport>{}</BuiltInComInteropSupport>]], {
            i(1, 'true'),
        })
    ),
}

local autosnippets = {

    s(
        'setter',
        fmt([[<Setter Property="{}" Value="{}" />]], {
            i(1, 'FontSize'),
            i(2, '20'),
        })
    ),

    s(
        'binding',
        fmt([[{{Binding {}}}]], {
            i(1, 'ItemSource'),
        })
    ),

    s(
        {
            trig = 'text box',
            descr = 'Simple textbox',
        },
        fmt(
            [[
            <TextBox {} Text="{}" />
            ]],
            {
                i(1),
                i(2, 'text'),
            }
        )
    ),

    s(
        {
            trig = 'text block',
            descr = 'Simple textblock',
        },
        fmt(
            [[
            <TextBlock {} Text="{}" />{}
            ]],
            {
                i(1),
                i(2, 'text'),
                i(0),
            }
        )
    ),

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
        { trig = '[Gg]rid [Rr]ow', regTrig = true, wordTrig = false },
        fmt([[Grid.Row="{}" {}]], {
            i(1, '1'),
            i(0),
        })
    ),

    s(
        { trig = '[Gg]rid [Cc]olumn', regTrig = true, wordTrig = false },
        fmt([[Grid.Column="{}" {}]], {
            i(1, '1'),
            i(0),
        })
    ),

    s(
        'comment',
        fmt(
            [[
        <!-- {} -->
        ]],
            {
                i(1),
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
      ]],
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
      ]],
            {
                c(1, {
                    fmt([[<PackageReference Include="{}" Version="{}" />]], {
                        i(1),
                        i(2),
                    }),
                    -- Database
                    t('<PackageReference Include="Microsoft.EntityFrameworkCore" Version="7.0.0-rc.2.22472.11" />'),
                    t('<PackageReference Include="Dapper" Version="2.0.123" />'),
                    t('<PackageReference Include="MySqlConnector" Version="2.2.5" />'),
                    -- This version sucks and only works with MySQL, it fails for MariaDB
                    -- t('<PackageReference Include="MySql.Data" Version="8.0.31" />'),
                    t('<PackageReference Include="Microsoft.Data.SqlClient" Version="5.1.0" />'),
                    -- -- Helps to get items from appSettings.json
                    t('<PackageReference Include="Microsoft.Extensions.Configuration" Version="8.0.0-preview.1.23110.8" />'),
                    -- Networking
                    t('<PackageReference Include="M2MqttDotnetCore" Version="1.1.0" />'),
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
