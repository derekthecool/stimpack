---@diagnostic disable: undefined-global
local snippets = {}

local autosnippets = {
    s(
        'FIRST',
        fmt([[{}]], {
            c(1, {
                sn(
                    nil,
                    fmt([[{}: {}]], {
                        i(1, 'item'),
                        i(2, 'value'),
                    })
                ),

                sn(
                    nil,
                    fmt(
                        [[
                {}:
                  - {}
                ]],
                        {
                            i(1, 'item'),
                            i(2, 'value'),
                        }
                    )
                ),
            }),
        })
    ),
}

return snippets, autosnippets
