---@diagnostic disable: undefined-global, missing-parameter

local shareable = require('luasnippets.functions.shareable_snippets')

local snippets = {
    ms({
        { trig = 'date_difference_mysql', snippetType = 'snippet', condition = nil },
    }, {
        sn(
            nil,
            fmt('DATEDIFF(CURRENT_DATE, {DateColumn}) AS DaysInHopper', {
                DateColumn = i(1, 'DateColumn'),
            })
        ),
    }),

    ms(
        {
            { trig = 'case_mysql', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        CASE
            WHEN {Condition}
            THEN {Value}
            ELSE {OtherValue}
        END
        ]],
            {
                Condition = i(1, 'l.Value REGEXP "[0-9]{5,10}"'),
                Value = i(2, 'true'),
                OtherValue = i(3, 'false'),
            }
        )
    ),

    ms(
        {
            { trig = 'REGREPLACE', snippetType = 'autosnippet', condition = nil },
            { trig = 'regex_replace_mysql', snippetType = 'snippet', condition = nil },
            { trig = 'regexp_replace_mysql', snippetType = 'snippet', condition = nil },
        },
        fmt([[REGEXP_REPLACE({Source}, '{Pattern}', '{Replacement}')]], {
            Source = i(1, 'Source'),
            Pattern = i(2, '[0-9]+_([abc]+)'),
            Replacement = i(3, '\\\\1'),
        })
    ),

    ms(
        {
            { trig = 'REGMATCH', snippetType = 'autosnippet', condition = nil },
            { trig = 'ALLREGMATCH', snippetType = 'autosnippet', condition = nil },
            { trig = 'regex_mysql', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        REGEXP '{Pattern}'
        ]],
            {
                Pattern = i(1, '[0-9]{1,3},2025'),
            }
        )
    ),

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
