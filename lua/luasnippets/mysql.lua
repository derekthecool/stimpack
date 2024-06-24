---@diagnostic disable: undefined-global, missing-parameter

local shareable = require('luasnippets.functions.shareable_snippets')

local snippets = {
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
