---@diagnostic disable: undefined-global, missing-parameter

local shareable = require('luasnippets.functions.shareable_snippets')

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

  - pwsh: |
      cd ./WebApi/
      dotnet test
    displayName: 'dotnet test'
    ]],
            {}
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
