---@diagnostic disable: undefined-global
local snippets = {}

local autosnippets = {
    s(
        'TODO',
        fmt(
            [[
        TODO: {}, {}
        ]],
            {
                f(function(args, snip)
                    return os.date('%c')
                end, {}),

                i(1, 'Do something here later'),
            }
        )
    ),

    ms(
        {
            {
                trig = [['''']],
                snippetType = 'autosnippet',
            },
        },
        fmt([['{}']], {
            i(1),
        })
    ),

    ms(
        {
            {
                trig = [[""""]],
                snippetType = 'autosnippet',
            },
        },
        fmt([["{}"]], {
            i(1),
        })
    ),
}

return snippets, autosnippets
