---@diagnostic disable: undefined-global, missing-parameter

local shareable = require('luasnippets.functions.shareable_snippets')

local snippets = {
    ms(
        {
            { trig = 'on', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        on:
          # On every push
          push:
            # Only on these branches
            branches:
              - 'releases/**'
            # Only on these paths or specific files
            paths:
              - '**.ps1'
            # Only on these tags
            tags:
              - 'v1.**'

          # Enable manual triggered runs
          workflow_dispatch:

          # Run workflow on UTC schedule: https://crontab.guru/
          schedule:
            - cron: '30 5 * * 1,3'

          # Run after another workflow
          # To check if the workflow was successful use this block above the steps command
          # if: ${{{{ github.event.workflow_run.conclusion == 'success' }}}}
          workflow_run:
            workflows: ['Name of workflow']
            types:
              - completed
        ]],
            {}
        )
    ),
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

    ms(
        {
            { trig = 'GitHub',         snippetType = 'snippet', condition = nil },
            { trig = 'actions',        snippetType = 'snippet', condition = nil },
            { trig = 'GitHub_actions', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        ---
        name: {Name}

        # Manual trigger, and upon every commit
        on: [workflow_dispatch, push]

        permissions: read-all

        # Set powershell 7 as default shell
        defaults:
          run:
            shell: pwsh

        # Run on every OS
        jobs:
          test:
            runs-on: ${{ matrix.os }}

            strategy:
              matrix:
                os: [ubuntu-latest, macos-latest, windows-latest]

            steps:
              - name: Checkout code
                uses: actions/checkout@v4

              - name: Setup dotnet
                uses: actions/setup-dotnet@v4

              - name: Run Pester Tests
                run: |
                  Invoke-Pester -Path './' -Passthru -Output Detailed
        ]],
            {
                Name = i(1, 'Workflow Name'),
            }
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
