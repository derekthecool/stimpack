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
}

return snippets, autosnippets
