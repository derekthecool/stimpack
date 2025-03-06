---@diagnostic disable: undefined-global, missing-parameter
local shareable = require('luasnippets.functions.shareable_snippets')

local snippets = {
    ms(
        {
            { trig = 'sqlserver select', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        select top 5 from
        ]],
            {}
        )
    ),
    ms(
        {
            { trig = 'sqlserver_date', snippetType = 'snippet',     condition = nil },
            { trig = 'sqlserver_time', snippetType = 'snippet',     condition = nil },
            { trig = 'sqlserver date', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[DATEDIFF({Unit}, {Column}, {DateFunction}) {TimeSpan}]], {
            Unit = c(1, {
                t('SECOND'),
                t('MINUTE'),
                t('HOUR'),
                t('DAY'),
                t('MONTH'),
                t('QUARTER'),
                t('YEAR'),
                t('MILLISECOND'),
                t('MICROSECOND'),
            }),
            Column = i(2, 'TimeColumn'),
            DateFunction = c(3, {
                t('GETUTCDATE()'),
                t('GETDATE()'),
            }),
            TimeSpan = i(4, '<= 5'),
        })
    ),
}

local autosnippets = {}

return snippets, autosnippets
