---@diagnostic disable: undefined-global, missing-parameter
local snippets = {
    ms(
        {
            {
                trig = 'range_luafun',
                snippetType = 'snippet',
            },
        },
        fmt(
            [[
        {}.range({})
        ]],
            {
                i(1, 'luafun'),
                i(2, '10'),
            }
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
