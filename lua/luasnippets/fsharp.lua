---@diagnostic disable: undefined-global

local auxiliary = require('luasnippets.functions.auxiliary')

local snippets = {
    s(
        'measure',
        fmt(
            [=[
            /// {}
            [<Measure>] type {}
            ]=],
            {
                i(2, 'Description of the unit: gold'),
                i(1, 'G'),
            }
        )
    ),
    s(
        'plot from fsx script',
        fmt(
            [[
            #r "nuget: Plotly.NET, 3.0.0"
            #r "nuget: Plotly.NET.ImageExport, 3.0.0"

            open Plotly.NET
            open Plotly.NET.ImageExport

            let X = [1..100]
            let Y = X |> Seq.map(fun value -> value * value * value)

            // Can plot a xy tuple by using named parameter: xy
            Chart.Point(X, Y)
            |> Chart.withTemplate ChartTemplates.dark
            |> Chart.withTitle ("My graph")
            |> Chart.withXAxisStyle ("Time")
            |> Chart.withYAxisStyle ("Units")
            |> Chart.withSize (1400.0, 800.0)
            |> Chart.show
         ]],
            {}
        )
    ),

    s(
        'plot single stack with shared axis',
        fmt(
            [[
        [ Chart.Line(X, Y1) |> Chart.withYAxisStyle ("Y1")
        Chart.Line(X, Y2) |> Chart.withYAxisStyle ("Y2") ]
        |> Chart.SingleStack(Pattern = StyleParam.LayoutGridPattern.Coupled)
        |> Chart.withLayoutGridStyle (YGap = 0.1, XGap = 0.8)
        |> Chart.withTitle ("AFE4404 PPG Sensor Values")
        |> Chart.withXAxisStyle ("Time")
        |> Chart.withSize (1400.0, 800.0)
        |> Chart.show
        ]],
            {}
        )
    ),

    s(
        'read line',
        fmt(
            [[
        Console.ReadLine()
        ]],
            {}
        )
    ),

    s(
        'match',
        fmt(
            [[
        match {} with
        | {} -> {}
        | _ -> {}
        ]],
            {
                i(1, 'variable'),
                i(2, 'item'),
                i(3),
                i(4),
            }
        )
    ),

    s(
        'module',
        fmt(
            [[
        module {}

        {}
        ]],
            {
                f(function(args, snip)
                    local just_file_name = vim.fn.expand('%:t:r')
                    return just_file_name
                end, {}),
                i(1),
            }
        )
    ),

    s(
        'transpose',
        fmt(
            [[
        /// https://stackoverflow.com/a/43287398/9842112
        let rec transpose matrix =
        match matrix with
        | [] :: _ -> []
        | _ -> List.map List.head matrix :: transpose (List.map List.tail matrix)
        ]],
            {}
        )
    ),

    s(
        'selenium',
        fmt(
            [[
        #r "nuget: Selenium.WebDriver"
        #r "nuget: Selenium.Support"
        #r "nuget: WebDriverManager"

        open System
        open OpenQA.Selenium
        open OpenQA.Selenium.Chrome
        open OpenQA.Selenium.Firefox
        open WebDriverManager
        open WebDriverManager.DriverConfigs.Impl

        DriverManager().SetUpDriver(new FirefoxConfig()) |> ignore
        let driver = new FirefoxDriver()

        driver.Navigate().GoToUrl("https://www.selenium.dev/selenium/web/web-form.html")
        let textfield = driver.FindElement(By.Id("my-text-id"))
        textfield.SendKeys("Derek was here")
        ]],
            {}
        )
    ),

    s(
        'serial',
        fmt(
            [[
        #r "nuget: System.IO.Ports"

        open System
        open System.IO.Ports

        // Open serial port
        let OpenPort () =
            let port = new SerialPort("COM4", 115200, Ports.Parity.None, 8, Ports.StopBits.Two)
            port.Open()
            port.DtrEnable <- true
            port.RtsEnable <- true
            port.ReadTimeout <- 1000
            port

        let port = OpenPort()
        ]],
            {}
        )
    ),

    s(
        'script',
        fmt(
            [[
        // https://learn.microsoft.com/en-us/dotnet/fsharp/tools/fsharp-interactive/

        // Start timing
        #time

        ]],
            {}
        )
    ),

    ms(
        {
            {
                trig = 'clash',
                snippetType = 'autosnippet',
            },
        },
        fmt(
            [[
        open System
        Seq.initInfinite(fun _->Console.ReadLine())
        |>Seq.takeWhile(fun x->x<>null)
        |>Seq.skip {}
        |> {}
        ]],
            {
                i(1, '1'),
                i(2, 'Seq.map'),
            }
        )
    ),

    ms(
        {
            { trig = 'webapi starter',      snippetType = 'snippet' },
            { trig = 'api starter',         snippetType = 'snippet' },
            { trig = 'Program api starter', snippetType = 'snippet' },
        },
        fmt(
            [[
        open System
        open System.Collections.Generic
        open System.IO
        open System.Linq
        open System.Threading.Tasks
        open Microsoft.AspNetCore
        open Microsoft.AspNetCore.Builder
        open Microsoft.AspNetCore.Hosting
        open Microsoft.AspNetCore.HttpsPolicy
        open Microsoft.Extensions.Configuration
        open Microsoft.Extensions.DependencyInjection
        open Microsoft.Extensions.Hosting
        open Microsoft.Extensions.Logging

        let builder = WebApplication.CreateBuilder()

        let app = builder.Build()

        // app.UseHttpsRedirection()
        // app.UseAuthorization()
        // app.MapControllers()

        app.Run()
        ]],
            {}
        )
    ),

    ms(
        {
            {
                trig = 'mqtt',
                snippetType = 'snippet',
            },
        },
        fmt(
            [[
        // Mqtt starter using https://github.com/dotnet/MQTTnet
        // MQTT Configuration
        let mqttOptions =
            (new MqttClientOptionsBuilder())
                .WithTcpServer("192.168.100.35", 1883) // Replace with your MQTT broker details
                .Build()

        let mqttFactory = new MqttFactory()
        let mqttClient = mqttFactory.CreateMqttClient()

        let result =
            async {{
                try
                    let! mqttConnectResultTask = Async.AwaitTask(mqttClient.ConnectAsync(mqttOptions))
                    let mqttConnectResult = mqttConnectResultTask
                    Console.WriteLine()
                    printfn "Connected to mqtt broker"

                    let topic = "bellel/imei/+"
                    let! subTask = Async.AwaitTask(mqttClient.SubscribeAsync(topic, MqttQualityOfServiceLevel.AtLeastOnce))
                    printfn "Subscribed to topic: %s" topic

                    return Ok()
                with ex ->
                    printfn "Failed to connect to the MQTT broker: %A" ex.Message
                    return Error ex
            }}
            |> Async.RunSynchronously

        // MQTT Message Received Handler
        mqttClient.add_ApplicationMessageReceivedAsync (fun args ->
            try
                let topic = args.ApplicationMessage.Topic
                Task.FromResult("Bye-bye")
            with :? IOException as ex ->
                // Handle socket closure or write errors
                printfn "Socket error occurred while writing to TCP client: %s" ex.Message
                Task.FromResult("Bye-bye"))
        ]],
            {}
        )
    ),

    ms(
        {
            { trig = 'raise', snippetType = 'snippet' },
        },
        fmt(
            [[
        raise (System.Exception($"{}"))
        ]],
            {
                i(1, 'Error with something'),
            }
        )
    ),

    ms(
        {
            { trig = 'TRY', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        try
            {}
        with
        | :? System.DivideByZeroException as ex ->
            printfn "Caught DivideByZeroException: %s" ex.Message
        | ex ->
            printfn "Caught an unexpected exception: %s" ex.Message
            raise ex // Rethrow the exception if it's not a DivideByZeroException
        ]],
            {
                i(1),
            }
        )
    ),
}

local autosnippets = {
    ms(
        {
            { trig = 'PRINT',      snippetType = 'autosnippet' },
            { trig = 'printfn',    snippetType = 'snippet' },
            { trig = 'ERRORPRINT', snippetType = 'autosnippet' },
            { trig = 'eprintfn',   snippetType = 'snippet' },
            { trig = 'FRMAT',      snippetType = 'autosnippet' },
            { trig = 'sprintf',    snippetType = 'snippet' },
        },
        fmt([[{}printf{} "{}"{}]], {
            f(function(args, snip)
                local print_type = ''
                if snip.trigger == 'ERRORPRINT' or snip.trigger == 'eprintfn' then
                    print_type = 'e'
                elseif snip.trigger == 'FRMAT' or snip.trigger == 'sprintf' then
                    print_type = 's'
                end
                return print_type
            end, {}),
            c(3, {
                t('n'),
                t(''),
            }),

            i(1, '%d'),
            auxiliary.printf_style_dynamic_formatter(2, 1, ' '),
        })
    ),

    s(
        'IF',
        fmt(
            [[
        if {} then
            {}
        ]],
            {
                i(1, 'true'),
                i(2),
            }
        )
    ),

    s(
        'ELS_EI_F',
        fmt(
            [[
        elif {} then
            {}
        ]],
            {
                i(1, 'true'),
                i(2),
            }
        )
    ),

    s(
        'ELSE',
        fmt(
            [[
        else
            {}
        ]],
            {
                i(1),
            }
        )
    ),

    s(
        'WHILE',
        fmt(
            [[while {} do
            {}
        ]],
            {
                i(1),
                i(2),
            }
        )
    ),

    ms(
        {
            { trig = 'TEST', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        [<Fact>]
        let ``{}`` () =
            {}
        ]],
            {
                i(1, 'Test name'),
                i(2),
            }
        )
    ),

    ms(
        {
            { trig = 'ASSERT', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        Assert.{}({})
        ]],
            {
                c(1, {
                    t('Equal'),
                    t('True'),
                }),
                i(2),
            }
        )
    ),

    ms(
        {
            { trig = 'FOR', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        for {} in {} .. {} do
            {}
        ]],
            {
                i(1, 'i'),
                i(2, '1'),
                i(3, '10'),
                i(4),
            }
        )
    ),

    --
}

return snippets, autosnippets
