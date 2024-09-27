---@diagnostic disable: undefined-global

local my_treesitter_functions = require('stimpack.my-treesitter-functions')
local auxiliary = require('luasnippets.functions.auxiliary')
local shareable = require('luasnippets.functions.shareable_snippets')

function ImmutableRecordProperty(index)
    return sn(
        index,
        fmt([[public {Type} {Name} {{ get; init; }}]], {
            Type = i(1, 'int'),
            Name = i(2, 'MyProperty'),
        })
    )
end

function Namespace(index)
    return sn(
        index,
        fmt([[namespace {NamespaceFinder};]], {
            NamespaceFinder = c(1, {
                f(function(args, snip)
                    -- Get csharp namespace
                    local cwd = vim.fs.normalize(vim.fn.getcwd())
                    local full_file = vim.fs.normalize(vim.fn.expand('%:p'))
                    local just_file_name = vim.fs.normalize(vim.fn.expand('%:t'))
                    local namespace = full_file
                        :gsub(cwd .. OS.separator, '')
                        :gsub(OS.separator .. just_file_name, '')
                        :gsub(OS.separator, '.')
                    return namespace
                end, {}),

                i(1, 'CustomNamespace'),
            }),
        })
    )
end

local snippets = {

    ms(
        {
            { trig = 'mqtt',                          snippetType = 'snippet', condition = conds.line_begin },
            { trig = 'MQTTNet_example',               snippetType = 'snippet', condition = conds.line_begin },
            { trig = 'nuget_library_example_mqttnet', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
    // MQTTNet example setup https://www.nuget.org/packages/MQTTnet/5.0.0.1214-RC
    var mqttFactory = new MqttFactory();
    using var mqttClient = mqttFactory.CreateMqttClient();
    var mqttClientOptions = new MqttClientOptionsBuilder().WithTcpServer("{MqttBroker}", 1883).Build();

    // Setup message handling before connecting so that queued messages
    // are also handled properly. When there is no event handler attached all
    // received messages get lost.
    mqttClient.ApplicationMessageReceivedAsync += e =>
    {{
        Console.WriteLine($"Received mqtt message with length: {{e.ApplicationMessage.Payload.Length}}, on topic: {{e.ApplicationMessage.Topic}}");
        return Task.CompletedTask;
    }};

    await mqttClient.ConnectAsync(mqttClientOptions, CancellationToken.None);

    var mqttSubscribeOptions = mqttFactory
        .CreateSubscribeOptionsBuilder()
        .WithTopicFilter(
            topic: "{Topic}",
            qualityOfServiceLevel: MQTTnet.Protocol.MqttQualityOfServiceLevel.ExactlyOnce
        )
        .Build();

    await mqttClient.SubscribeAsync(mqttSubscribeOptions, CancellationToken.None);
    Console.WriteLine("MQTT client subscribed to topic.");
        ]],
            {
                MqttBroker = i(1, '192.168.1.1'),
                Topic = i(2, 'mqtt topic'),
            }
        )
    ),

    ms(
        {
            { trig = 'asp_verbose_request_middleware', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
// Middleware to log request details
app.Use(
    async (context, next) =>
    {
        context.Request.EnableBuffering(); // Allow multiple reads of the request body

        // Read the request body
        string bodyContent;
        using (
            var reader = new StreamReader(
                context.Request.Body,
                System.Text.Encoding.UTF8,
                leaveOpen: true
            )
        )
        {
            bodyContent = await reader.ReadToEndAsync();
            context.Request.Body.Position = 0; // Reset the request body stream position
        }

        // Log the full request details
        var logger = context.RequestServices.GetService<ILogger<Program>>();
        logger?.LogInformation("Request URI: {Uri}", context.Request.GetDisplayUrl());
        logger?.LogInformation("Request Headers: {Headers}", context.Request.Headers);
        logger?.LogInformation("Request Body: {Body}", bodyContent);

        await next.Invoke(); // Call the next middleware
    }
);
        ]],
            {},
            { delimiters = '[]' }
        )
    ),

    ms({ { trig = 'read line', snippetType = 'autosnippet' } }, fmt([[Console.ReadLine()]], {}), {
        callbacks = {
            [-1] = {
                -- Write needed using directives before expanding snippet so positions are not messed up
                [events.pre_expand] = function()
                    auxiliary.insert_include_if_needed('System')
                end,
            },
        },
    }),
    ms(
        {
            { trig = 'new record', snippetType = 'autosnippet' },
        },
        fmt([[new {RecordName} {{{Details}}};]], {
            RecordName = i(1, 'MyRecord'),
            Details = i(2),
        })
    ),

    ms(
        {
            { trig = 'LAMBDA', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[{variable}  => {repVariable}]], {
            variable = i(1, 'x'),
            repVariable = rep(1),
        })
    ),

    ms(
        {
            { trig = 'ASSERT', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[{}]], {
            d(1, function(args, snip)
                local nodes = {}

                -- Assert.Equal(expected: "", actual: command.Runcommand.RcUpdateFileURL);
                -- Assert.Matches(expectedRegex: new Regex(@$"^AT\+STRTO.*{UpdatePath}"), actualString: command.Runcommand.CallTransferNumber);
                -- Assert.EndsWith(expectedEndString: $"{commandId:X4}$", actualString: command.Runcommand.CallTransferNumber);
                local twoArgAssertTypes = {
                    { Name = 'Equal',      Param1Name = 'expected',            Param2Name = 'actual' },
                    { Name = 'Matches',    Param1Name = 'expectedRegex',       Param2Name = 'actualString' },
                    { Name = 'EndsWith',   Param1Name = 'expectedEndString',   Param2Name = 'actualString' },
                    { Name = 'StartsWith', Param1Name = 'expectedStartString', Param2Name = 'actualString' },
                }

                for _, value in pairs(twoArgAssertTypes) do
                    local snippet = sn(
                        nil,
                        fmt([[Assert.{AssertType}({ExpectedArgName}: {Arg1}, {ActualArgName}: {Arg2}]], {
                            AssertType = t(value.Name),
                            ExpectedArgName = t(value.Param1Name),
                            Arg1 = i(1),

                            ActualArgName = t(value.Param1Name),
                            Arg2 = i(2),
                        })
                    )
                    table.insert(nodes, snippet)
                end

                return sn(nil, c(1, nodes))
            end, {}),
        })
    ),

    ms(
        {
            { trig = 'TEST', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
        {xUnitTestType}
        public void {TestName}({Arguments})
        {{
            {Code}
        }}
        ]],
            {
                xUnitTestType = c(1, {
                    t('[Fact]'),
                    sn(
                        nil,
                        fmt(
                            [[
                            [Theory]
                            [InlineData({InputTestData})]
                            ]],
                            {
                                InputTestData = i(1, '"Text"'),
                            }
                        )
                    ),
                }),

                TestName = i(2, 'MyTest_ShouldPassWhen'),
                Arguments = i(3),
                Code = i(4),
            }
        )
    ),

    ms(
        {
            { trig = 'inline', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        [InlineData({Items})]
        ]],
            {
                Items = i(1, 'inline data'),
            }
        )
    ),

    ms(
        {
            { trig = 'list list', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[List<{Type}>]], {
            Type = i(1, 'int'),
        })
    ),

    ms(
        {
            { trig = '"""', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
        $"""
        {Content}
        """;
        ]],
            {
                Content = i(1),
            }
        )
    ),

    ms(
        {
            { trig = 'task task', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[Task<{Type}>]], {
            Type = i(1, 'string'),
        })
    ),

    ms(
        {
            { trig = 'asp_serilog_setup', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
var logger = new LoggerConfiguration()
    .ReadFrom.Configuration(builder.Configuration)
    .Enrich.FromLogContext()
    .CreateLogger();

// Clear default log providers
builder.Logging.ClearProviders();
builder.Logging.AddSerilog(logger);
        ]],
            {}
        )
    ),

    ms(
        {
            { trig = 'json_settings', snippetType = 'snippet', condition = conds.line_begin },
            { trig = 'asp_json',      snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
        // https://www.meziantou.net/configuring-json-options-in-asp-net-core.htm
        // Set the JSON serializer options
        builder.Services.Configure<Microsoft.AspNetCore.Http.Json.JsonOptions>(options =>
        {
            options.SerializerOptions.PropertyNameCaseInsensitive = false;
            options.SerializerOptions.PropertyNamingPolicy = null;
            options.SerializerOptions.WriteIndented = true;
        });
        ]],
            {},
            { delimiters = '[]' }
        )
    ),

    ms(
        {
            { trig = 'asp_task_runner', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
// In Program.cs
// Register the hosted service
builder.Services.AddHostedService<FotaProcessor>();
namespace DatabaseWebApi.FotaProcessor;

// In class file
public class FotaProcessor : IHostedService, IDisposable
{
    private readonly ILogger<FotaProcessor> _logger;
    private readonly ISqlDataAccess _db;
    private Timer? _timer;
    private int _updateIntervalMinutes;

    public FotaProcessor(ILogger<FotaProcessor> logger, ISqlDataAccess db)
    {
        _logger = logger;
        _db = db;
        _updateIntervalMinutes = 5;
    }

    public Task StartAsync(CancellationToken cancellationToken)
    {
        _logger.LogInformation(
            $"Fota processor task timer initialized, will run every {_updateIntervalMinutes} minutes"
        );

        _timer = new Timer(DoWork, null, TimeSpan.Zero, TimeSpan.FromMinutes(1));

        return Task.CompletedTask;
    }

    private void DoWork(object? state)
    {
        _logger.LogInformation("Scheduled Task is running.");
        // Add your scheduled task logic here
    }

    public Task StopAsync(CancellationToken cancellationToken)
    {
        _logger.LogInformation("Scheduled Task Service is stopping.");

        _timer?.Change(Timeout.Infinite, 0);

        return Task.CompletedTask;
    }

    public void Dispose()
    {
        _timer?.Dispose();
    }
}
        ]],
            {},
            { delimiters = '[]' }
        )
    ),

    ms(
        {
            { trig = 'API API',          snippetType = 'autosnippet', condition = conds.line_begin },
            { trig = 'map_api_endpoint', snippetType = 'snippet',     condition = conds.line_begin },
        },
        fmt(
            [[
        app.<APIVerb>(
        "<APIPath>",
        async (<APIInput>) =>>
        {
            try
            {
                return Results.Ok(<OKAPIReturn>);
            }
            catch (Exception ex)
            {
                string errorMessage = $"Error with API function {MethodBase.GetCurrentMethod()}";
                app.Logger.LogError(ex, errorMessage);
                return Results.Problem(errorMessage);
            }
        }
    )
    .WithOpenApi()
    .WithTags("<OpenApiTags>")
    .WithSummary("<OpenApiSummary>")
    .WithDescription("<OpenApiDescription>");
        ]],
            {
                APIVerb = c(1, {
                    t('MapGet'),
                    t('MapPost'),
                    t('MapPut'),
                    t('MapDelete'),
                }),
                APIPath = i(2, '/api/path/{id}'),
                APIInput = i(3, '[FromBody]string text'),
                OKAPIReturn = i(4, 'true'),
                OpenApiTags = i(5, 'CreateNewItems'),
                OpenApiSummary = i(6, 'Summary of API features'),
                OpenApiDescription = i(7, 'This API endpoint does....'),
            },
            {
                delimiters = '<>',
            }
        )
    ),

    s(
        'lua NLua starter',
        fmt(
            [[
            // Create new lua state and open libs so print and other functions can be used
            Lua L = new Lua(openLibs: true);
            // Load CLRPackage to let lua load csharp namespaces and functions
            L.LoadCLRPackage();

            L.DoFile("test.lua");
            LuaFunction f = L.GetFunction("TestFunction");
            if (f != null)
            {{
                var result = f.Call(5);
                Console.WriteLine(result.GetValue(0));
            }}
        ]],
            {}
        ),
        {
            callbacks = {
                [-1] = {
                    -- Write needed using directives before expanding snippet so positions are not messed up
                    [events.pre_expand] = function()
                        auxiliary.insert_include_if_needed('NLua')
                    end,
                },
            },
        }
    ),

    s(
        'regex matches',
        fmt(
            [[
        var matches = Regex.Matches({}, @"{}")
                           .Cast<Match>()
                           .Select(match => {})
                           .Distinct();
        ]],
            {
                i(1),
                i(2, '.*'),
                i(3, 'match'),
            }
        ),
        {
            callbacks = {
                [-1] = {
                    -- Write needed using directives before expanding snippet so positions are not messed up
                    [events.pre_expand] = function()
                        auxiliary.insert_include_if_needed({
                            'System.Linq',
                            'System.Text.RegularExpressions',
                        })
                    end,
                },
            },
        }
    ),

    s(
        'prop',
        fmt(
            [[
      {} {} {} {{ get; set; }}
      ]],
            {
                c(1, {
                    t('public'),
                    t('private'),
                }),
                i(2, 'int'),
                i(3, 'Name'),
            }
        )
    ),

    s(
        'event',
        fmt(
            [[
      public event EventHandler<{}>? {};

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
    s('transform', {
        i(1, 'TestTestTest'),
        t({ '', '' }),
        -- lambda nodes accept an l._1,2,3,4,5, which in turn accept any string transformations.
        -- This list will be applied in order to the first node given in the second argument.
        l(
            l._1:gsub('^.', function(s)
                return s:lower()
            end),
            1
        ),
    }),

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
                i(2, 'variableNameWithLoweredFirstChar'),
                rep(1),
                l(
                    l._1:gsub('^.', function(s)
                        return s:upper()
                    end),
                    2
                ),
                rep(2),
                rep(2),
                i(0),
            }
        )
    ),

    s(
        'enum',
        fmt(
            [[
        enum {}
        {{
            {}
        }}
        ]],
            {
                i(1, 'Enum1'),
                i(2),
            }
        )
    ),

    s(
        'read lines',
        fmt(
            [[
        var Lines = new List<string>();
        var Line = "";
        while((Line = Console.ReadLine()) != null)
        {{
            Lines.Add(Line);
        }}
        ]],
            {}
        ),
        {
            callbacks = {
                [-1] = {
                    -- Write needed using directives before expanding snippet so positions are not messed up
                    [events.pre_expand] = function()
                        auxiliary.insert_include_if_needed({ 'System', 'System.Collections.Generic' })
                    end,
                },
            },
        }
    ),

    s(
        'clash of code snippet starter',
        fmt(
            [[
        using System;
        using System.Linq;
        using System.Text.RegularExpressions;
        using System.Collections.Generic;

        {}

        {}

        Console.WriteLine({});
        ]],
            {
                c(1, {
                    t('var Line = Console.ReadLine();'),
                    t({
                        'var Lines = new List<string>();',
                        'var Line="";',
                        'while((Line = Console.ReadLine()) != null)',
                        '{',
                        '    Lines.Add(Line);',
                        '}',
                    }),
                }),
                i(2),
                i(3),
            }
        )
    ),

    s(
        'range',
        fmt(
            [[
        Enumerable.Range({}, {})
        ]],
            {
                i(1, '1'),
                i(2, '50'),
            }
        )
    ),

    s(
        'date',
        fmt(
            [[
        DateTime.Now;
        ]],
            {}
        )
    ),

    ms(
        {
            {
                trig = 'http sync',
                snippetType = 'snippet',
            },
        },
        fmt(
            [[
        string GetChuckNorisQuote()
        {
            using var client = new HttpClient(
                new HttpClientHandler
                {
                    AutomaticDecompression = DecompressionMethods.GZip | DecompressionMethods.Deflate
                }
            );
            var response = client.GetAsync("https://api.chucknorris.io/jokes/random").Result;
            response.EnsureSuccessStatusCode();
            var output = response.Content.ReadAsStringAsync().Result;
            var joke = JsonSerializer.Deserialize<ChuckNorrisJoke>(output);

            return joke?.value;
        }
        ]],
            {},
            {
                delimiters = [[`']],
            }
        )
    ),

    ms(
        {
            {
                trig = 'timer',
                snippetType = 'snippet',
            },
        },
        fmt(
            [[
        Timer timer = new Timer
        {{
            Interval = TimeSpan.FromSeconds({}).Milliseconds,
            AutoReset = true,
            Enabled = true
        }};

        // Function callback lambda
        timer.Elapsed += (sender, e) =>
        {{
            Console.WriteLine("Timer elapsed at: " + e.SignalTime);
        }};
        ]],
            {
                i(1, '3'),
            }
        )
    ),

    ms(
        {
            {
                trig = 'range',
                snippetType = 'snippet',
            },
        },
        fmt(
            [[
        Enumerable.Range({}, {}){}
        ]],
            {
                i(1, '0'),
                i(2, '10'),
                i(3),
            }
        )
    ),

    ms(
        {
            { trig = 'public override',   snippetType = 'snippet' },
            { trig = 'tostring override', snippetType = 'snippet' },
        },
        fmt(
            [[
        public override string ToString()
        {{
            return $"{}";
        }}
        ]],
            {
                i(1),
            }
        )
    ),

    shareable.for_loop_c_style,
}

local autosnippets = {

    ms(
        {
            { trig = 'PRINT',      snippetType = 'autosnippet' },
            { trig = 'ERRORPRINT', snippetType = 'autosnippet' },
        },
        fmt([[Console{}.WriteLine({});]], {

            f(function(args, snip)
                if snip.trigger == 'ERRORPRINT' or snip.trigger == 'Console.Error.WriteLine' then
                    return '.Error'
                end
            end, {}),
            c(1, {
                sn(
                    1,
                    fmt([[$"{Text}"]], {
                        Text = i(1),
                    })
                ),
                i(1),
            }),
        })
    ),

    -- s(
    --     'ERRORPRINT',
    --     fmt(
    --         [[
    --   Console{}.WriteLine($"{}");
    --   ]],
    --         {
    --             f(function(args, snip)
    --                 if snip.trigger == 'ERRORPRINT' or snip.trigger == 'Console.Error.WriteLine' then
    --                     return '.Error'
    --                 end
    --             end, {}),
    --
    --             i(1),
    --         }
    --     )
    -- ),

    s(
        'FRMAT',
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
        fmt([[{{{}}}]], {
            i(1),
        })
    ),

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

    ms(
        {
            { trig = 'record property', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
        {Property}
        ]],
            {
                Property = c(1, {
                    ImmutableRecordProperty(1),
                    sn(
                        1,
                        fmt(
                            [=[
            [JsonPropertyName("{JsonField}")]
            {RecordProperty}
            ]=],
                            {
                                JsonField = i(1, 'Name'),
                                RecordProperty = ImmutableRecordProperty(2),
                            }
                        )
                    ),
                }),
            }
        )
    ),

    ms(
        {
            { trig = 'json property', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt('[JsonPropertyName("{}")]', {
            i(1, 'Name'),
        })
    ),

    ms(
        {
            { trig = 'record',        snippetType = 'snippet',     condition = conds.line_begin },
            { trig = 'record record', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        public record {Name}
        {{
            {ImmutableRecordPropertyValue}
            {More}
        }}
        ]],
            {
                Name = i(1, 'MyRecord'),
                ImmutableRecordPropertyValue = ImmutableRecordProperty(2),
                More = i(3),
            }
        )
    ),

    s(
        'CLASS',
        fmt(
            [[
        {NamespaceItem}

        {}{} {ClassOrRecord} {}
        {{
            {}
        }}
        ]],
            {
                NamespaceItem = Namespace(1),

                c(2, {
                    t('public'),
                    t('private'),
                }),

                c(3, {
                    t(''),
                    t(' static'),
                }),

                ClassOrRecord = c(4, {
                    t('class'),
                    t('record'),
                }),

                f(function(args, snip)
                    return vim.fn.expand('%:p:t:r')
                end, { 3 }),

                i(5),
            }
        )
    ),

    s(
        'CONSTRUCTOR',
        fmt(
            [[
        {}({})
        {{
            {}
        }}
        ]],
            {
                f(function(args, snip)
                    local class_information = my_treesitter_functions.cs.get_class_name()
                    return string.format('%s %s', class_information.modifier, class_information.class)
                end, {}),
                i(1),
                i(2),
            }
        )
    ),

    s(
        'FREACH',
        fmt(
            [[
            foreach(var item in {})
            {{
                  {}
            }}
            ]],
            {
                i(1),
                i(2),
            }
        )
    ),

    s(
        'TRY',
        fmt(
            [[
            try
            {{
                {WrappedText}
            }}
            catch (Exception ex)
            {{
                {HandleException}
            }}
            ]],
            {
                WrappedText = auxiliary.wrap_selected_text(1),
                HandleException = i(2, 'Console.Error.WriteLine(ex.Message);'),
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
        { trig = 'CALL', wordTrig = false },
        fmt([[({});]], {
            i(1),
        })
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

                i(2, 'async Task'),

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
