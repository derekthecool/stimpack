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

    ms(
        {
            { trig = 'shell', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        - script: |
            Write-Host "Powershell version: $($PSVersionTable.PSVersion)"
          displayName: '{Name}'
          shell: pwsh
        ]],
            {
                Name = i(1, 'Name'),
            }
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
