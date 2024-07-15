---@diagnostic disable: undefined-global, missing-parameter

local shareable = require('luasnippets.functions.shareable_snippets')

local snippets = {
    ms(
        {
            { trig = 'azure_steps', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
steps:
  # Only checkout the latest commit. This repo is massive!
  - checkout: self
    fetchDepth: 1

  - task: UseDotNet@2
    displayName: 'Install .NET Core SDK'
    inputs:
      version: 8.x

  - task: PowerShell@2
    inputs:
      targetType: 'inline'
      script: |
        Write-Host "Hello World"
        Install-Module PS2EXE
      pwsh: true

  - task: DotNetCoreCLI@2
    displayName: 'dotnet restore'
    inputs:
      command: 'restore'
      projects: './Wallaby_Tools/Wallaby_Tools.sln'
      feedsToUse: 'select'

  - task: DotNetCoreCLI@2
    displayName: 'dotnet test'
    inputs:
      command: 'test'
      arguments: '-c Release'
      projects: './Wallaby_Tools/Wallaby_Tools.sln'
      testRunTitle: 'BelleXAdbLibrary xUnit Tests'
    ]],
            {}
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
