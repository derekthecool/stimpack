---@diagnostic disable: undefined-global, missing-parameter

local shareable = require('luasnippets.functions.shareable_snippets')

local function step(index)
    return sn(
        index,
        fmt(
            [[
        - pwsh: |
            {Code}
            displayName: '{Name}'
        ]],
            {
                Code = i(1),
                Name = i(2, 'StepName'),
            }
        )
    )
end

local snippets = {
    ms(
        {
            { trig = 'AzurePipelines', snippetType = 'snippet' },
        },
        fmt(
            [[
trigger:
  branches:
    include:
    - '*'

pool:
  vmImage: 'ubuntu-latest'

steps:
  - task: UseDotNet@2
    displayName: 'Install .NET Core SDK'

  {Step}
    ]],
            { Step = step(1) }
        )
    ),

    ms({
        { trig = 'Azurestep', snippetType = 'snippet', condition = nil },
    }, step(1)),
}

local autosnippets = {}

return snippets, autosnippets
