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

            Chart.Point(X, Y)
            |> Chart.show
            |> Chart.saveJPG ("test", Width = 600, Height = 600)
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
}

local autosnippets = {
    ms(
        {
            { trig = 'PRINT', snippetType = 'autosnippet' },
            { trig = 'printfn', snippetType = 'snippet' },
            { trig = 'ERRORPRINT', snippetType = 'autosnippet' },
            { trig = 'eprintfn', snippetType = 'snippet' },
        },
        fmt([[{}printf{} "{}"{}]], {
            f(function(args, snip)
                local print_type = ''
                if snip.trigger == 'ERRORPRINT' or snip.trigger == 'eprintfn' then
                    print_type = 'e'
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

    --
}

return snippets, autosnippets
