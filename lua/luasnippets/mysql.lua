---@diagnostic disable: undefined-global, missing-parameter

local shareable = require('luasnippets.functions.shareable_snippets')

local snippets = {
    ms(
        {
            { trig = 'left', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
         LEFT({String}, {Length})
         ]],
            {
                String = i(1, 'string'),
                Length = i(2, '50'),
            }
        )
    ),
    ms(
        {
            { trig = 'round', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        ROUND({Number}, {Places})
        ]],
            {
                Number = i(1, 'number'),
                Places = i(2, '3'),
            }
        )
    ),
    ms(
        {
            { trig = 'time', snippetType = 'snippet', condition = nil },
            { trig = 'now', snippetType = 'snippet', condition = nil },
        },
        fmt([[NOW() - INTERVAL {Days} DAY]], {
            Days = i(1, '5'),
        })
    ),
    ms(
        {
            { trig = 'find_in_set', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
    -- Mysql list like variable
    set @devices = '355286087415903,355286087354342';

    -- Can use in where clauses
    find_in_set(IMEI, @devices)
    ]],
            {}
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
