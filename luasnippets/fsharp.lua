---@diagnostic disable: undefined-global
local snippets = {
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
         ]]  ,
            {}
        )
    ),

    s(
        'read line',
        fmt(
            [[
        Console.ReadLine()
        ]]   ,
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
        ]]   ,
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
        ]]   ,
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
        ]]   ,
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
        ]]   ,
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
        ]]   ,
            {}
        )
    ),
}

local autosnippets = {
    s(
        'PRINT',
        fmt([[printfn "{}" {}]], {
            i(1, '%d'),
            i(2, 'variable'),
        })
    ),

    s(
        'IF',
        fmt(
            [[
        if {} then
            {}
        ]]   ,
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
        ]]   ,
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
        ]]   ,
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
        ]]   ,
            {
                i(1),
                i(2),
            }
        )
    ),

    s(
        '\\',
        fmt([[{}]], {
            c(1, {
                -- https://learn.microsoft.com/en-us/dotnet/standard/base-types/character-classes-in-regular-expressions
                t('(?# Letter, Uppercase)\\p{Lu}'),
                t('(?# Letter, Lowercase)\\p{Ll}'),
                t('(?# Letter, Titlecase)\\p{Lt}'),
                t('(?# Letter, Modifier)\\p{Lm}'),
                t('(?# Letter, Other)\\p{Lo}'),
                t('(?# All letter characters. This includes the Lu, Ll, Lt, Lm, and Lo characters.)\\p{L}'),
                t('(?# Mark, Nonspacing)\\p{Mn}'),
                t('(?# Mark, Spacing Combining)\\p{Mc}'),
                t('(?# Mark, Enclosing)\\p{Me}'),
                t('(?# All combining marks. This includes the Mn, Mc, and Me categories.)\\p{M}'),
                t('(?# Number, Decimal Digit)\\p{Nd}'),
                t('(?# Number, Letter)\\p{Nl}'),
                t('(?# Number, Other)\\p{No}'),
                t('(?# All numbers. This includes the Nd, Nl, and No categories.)\\p{N}'),
                t('(?# Punctuation, Connector)\\p{Pc}'),
                t('(?# Punctuation, Dash)\\p{Pd}'),
                t('(?# Punctuation, Open)\\p{Ps}'),
                t('(?# Punctuation, Close)\\p{Pe}'),
                t('(?# Punctuation, Initial quote (may behave like Ps or Pe depending on usage))\\p{Pi}'),
                t('(?# Punctuation, Final quote (may behave like Ps or Pe depending on usage))\\p{Pf}'),
                t('(?# Punctuation, Other)\\p{Po}'),
                t('(?# All punctuation characters. This includes the Pc, Pd, Ps, Pe, Pi, Pf, and Po categories.)\\p{P}'),
                t('(?# Symbol, Math)\\p{Sm}'),
                t('(?# Symbol, Currency)\\p{Sc}'),
                t('(?# Symbol, Modifier)\\p{Sk}'),
                t('(?# Symbol, Other)\\p{So}'),
                t('(?# All symbols. This includes the Sm, Sc, Sk, and So categories.)\\p{S}'),
                t('(?# Separator, Space)\\p{Zs}'),
                t('(?# Separator, Line)\\p{Zl}'),
                t('(?# Separator, Paragraph)\\p{Zp}'),
                t('(?# All separator characters. This includes the Zs, Zl, and Zp categories.)\\p{Z}'),
                t('(?# Other, Control A.K.A. non printables)\\p{Cc}'),
                t('(?# Other, Format)\\p{Cf}'),
                t('(?# Other, Surrogate)\\p{Cs}'),
                t('(?# Other, Private Use)\\p{Co}'),
                t('(?# Other, Not Assigned or Noncharacter)\\p{Cn}'),
                t('(?# All other characters. This includes the Cc, Cf, Cs, Co, and Cn categories.)\\p{C}'),
                t('\\d'),
                t('\\d+'),
                t('\\d*'),
                t('\\w'),
                t('\\w+'),
                t('\\w*'),
                t('\\s'),
                t('\\s+'),
                t('\\s*'),
                -- My awesome regexes with descriptions
                t('?# Non vowels, uses range subtraction)[a-zA-Z-[aeiouAEIOU]]'),
            }),
        })
    ),
}

return snippets, autosnippets
