---@diagnostic disable: undefined-global, missing-parameter

local shareable = require('luasnippets.functions.shareable_snippets')

local snippets = {
    ms(
        {
            { trig = 'GitHub_action_steps', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
    steps:
      - name: Check out repository code
        uses: actions/checkout@v3
    ]],
            {}
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
