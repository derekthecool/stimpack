---@diagnostic disable: undefined-global

local powershell_foreground_highlights = {
    t('Gray'),
    t('Green'),
    t('Yellow'),
    t('Red'),
    t('Blue'),
    t('Cyan'),
    t('Magenta'),
    t('White'),
    t('Black'),
    t('DarkBlue'),
    t('DarkGreen'),
    t('DarkCyan'),
    t('DarkRed'),
    t('DarkMagenta'),
    t('DarkYellow'),
    t('DarkGray'),
}
local powershell_background_highlights = {
    t('Black'),
    t('DarkGreen'),
    t('DarkYellow'),
    t('DarkRed'),
    t('DarkBlue'),
    t('DarkCyan'),
    t('DarkMagenta'),
    t('Gray'),
    t('DarkGray'),
    t('Blue'),
    t('Green'),
    t('Cyan'),
    t('Red'),
    t('Magenta'),
    t('Yellow'),
    t('White'),
}

local function PesterTest(index)
    return sn(
        index,
        fmt(
            [[
    Describe {{
        It '{TestDescription}' {{
            {Assertion}
        }}
    }}
    ]],
            {
                TestDescription = i(1, 'This test does ....'),
                Assertion = i(2, '$(Get-ChildItem).Count | Should -Be 42'),
            }
        )
    )
end

local snippets = {

    ms(
        {
            { trig = 'ENUM', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
enum {Name} {{
    {Items}
}}
        ]],
            {
                Name = i(1, 'MyEnum'),
                Items = i(2, 'Item1'),
            }
        )
    ),

    ms(
        {
            { trig = 'CLASS', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
class {ClassName} {{
    [{PropertyType}]${PropertyName}

    {RepeatClassName}([{RepeatPropertyType}]${RepeatPropertyName}) {{
        $this.{RepeatPropertyName} = ${RepeatPropertyName}
    }}
}}
        ]],
            {

                ClassName = i(1, 'MyClass'),
                PropertyType = i(2, 'string'),
                PropertyName = i(3, 'PropertyName'),
                RepeatClassName = rep(1),
                RepeatPropertyType = rep(2),
                RepeatPropertyName = rep(3),
            }
        )
    ),

    ms(
        {
            { trig = 'pester_mock', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
        # Mock git to intercept and inspect the call
        Mock git {{}}

        # Command to run
        dot 'git' 'status'

        # Assert that git was called with 'status' only
        Assert-MockCalled git -Exactly 1 -Scope It -ParameterFilter {{ $Args -contains 'status' -and $Args.Contains('git') -eq $false }}
        ]],
            {}
        )
    ),

    ms(
        {
            { trig = 'FILE_TEST', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        BeforeAll {{
            . $PSScriptRoot/{Filename}
        }}

        {Test}
        ]],
            {
                Filename = i(1, './Script.ps1'),
                Test = PesterTest(1),
            }
        )
    ),

    s(
        'list',
        fmt('${} = New-Object System.Collections.Generic.List[string]', {
            i(1),
        })
    ),

    s(
        'script',
        fmt(
            [[
        <#
        .Name
           {}
        .Synopsis
           {}
        .DESCRIPTION
           {}
        .EXAMPLE
           Example of how to use this cmdlet
        .EXAMPLE
           Another example of how to use this cmdlet
        .INPUTS
           Inputs to this cmdlet (if any)
        .OUTPUTS
           Output from this cmdlet (if any)
        .NOTES
           General notes
        .COMPONENT
           The component this cmdlet belongs to
        .ROLE
           The role this cmdlet belongs to
        .FUNCTIONALITY
           The functionality that best describes this cmdlet
        #>
        [CmdletBinding(DefaultParameterSetName='Parameter Set 1',
            SupportsShouldProcess=$true,
            PositionalBinding=$false,
            HelpUri = 'http://www.microsoft.com/',
            ConfirmImpact='Medium')]
        [Alias()]
        [OutputType([String])]
        Param
        (
            [Parameter(Mandatory=$true,
                ValueFromPipeline=$true,
                ValueFromPipelineByPropertyName=$true,
                ValueFromRemainingArguments=$false)]
            [ValidateNotNull()]
            [ValidateNotNullOrEmpty()]
            # Checks to make sure path is valid first
            # [ValidateScript({{Test-Path $_}})]
            # [ValidateLength(1,5)]
            # [ValidatePattern('match this regex .*')]
            # [ValidateCount(0,5)]
            # [ValidateSet('sun', 'moon', 'earth')]
            # [Alias('p1','test','anothername')]
            ${}
        )

        Begin
        {{
            {}
        }}
        Process
        {{
            if ($pscmdlet.ShouldProcess("Target", "Operation"))
            {{
                {}
            }}
        }}
        End
        {{
            {}
        }}
        ]],
            {
                f(function(args, snip)
                    return vim.fn.expand('%:t')
                end, {}),
                i(1, 'Short script description'),
                i(2, 'Long script description'),
                i(3, 'param1'),
                i(4, 'echo "start code"'),
                i(5, 'echo "perform code"'),
                i(6, 'echo "end code"'),
            }
        )
    ),

    ms(
        {
            { trig = 'param', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
        param (
            [Parameter()]
            [{Type}]${Name}
        )
        ]],
            {
                Type = i(1, 'string'),
                Name = i(2, 'MyParam'),
            }
        )
    ),

    -- s(
    --     'param',
    --     fmt(
    --         [[
    -- {}[Parameter(
    --     Mandatory=${},
    --     ValueFromPipeline=$true,
    --     ValueFromPipelineByPropertyName=$true,
    --     ValueFromRemainingArguments=$false,
    --     Position=0,
    --     ParameterSetName='Parameter Set 1')]
    -- [{}]${}
    --     ]],
    --         {
    --             c(1, {
    --                 t(''),
    --                 t(','),
    --             }),
    --
    --             c(2, {
    --                 t('true'),
    --                 t('false'),
    --             }),
    --             c(3, {
    --                 t('switch'),
    --                 i(1, 'WriteYourOwnType'),
    --                 t('string'),
    --                 t('int32'),
    --             }),
    --             i(4, 'VariableName'),
    --         }
    --     )
    -- ),

    s(
        'get-date',
        fmt(
            [[
     Get-Date -Format "{}"
        ]],
            {
                i(1, 'yyyy-MM-dd'),
            }
        )
    ),

    ms(
        {
            { trig = 'ALLREGMATCH', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        [regex]::Matches({Source}, '{Pattern}', 'IgnorePatternWhitespace') | ForEach-Object {{ $_.{DoSomething} }}
        ]],
            {
                Source = i(1, '$input'),

                Pattern = i(2, '.*'),
                DoSomething = i(3, 'Value'),
            }
        )
    ),
}

local autosnippets = {
    s(
        'IF',
        fmt(
            [[
        if({})
        {{
            {}
        }}
        {}{}
        ]],
            {
                i(1),
                i(2),
                i(3),
                m(3, 'else', 'no'),
            }
        )
    ),

    s(
        'ELS_EI_F',
        fmt(
            [[
        elseif({})
        {{
            {}
        }}
        ]],
            {
                i(1),
                i(2),
            }
        )
    ),

    s(
        'ELSE',
        fmt(
            [[
        else
        {{
            {}
        }}
        ]],
            {
                i(1),
            }
        )
    ),

    ms(
        {
            { trig = 'FUNCTION', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        function {Name} {{
            {}
        }}
        ]],
            {
                Name = i(1, 'MyFunction'),
                i(2),
            }
        )
    ),

    ms(
        {
            { trig = 'Write-Host', snippetType = 'snippet' },
            { trig = 'PRINT', snippetType = 'autosnippet' },
            { trig = 'Write-Host', snippetType = 'snippet' },
            { trig = 'ERRORPRINT', snippetType = 'autosnippet' },
            { trig = 'Write-Output', snippetType = 'snippet' },
        },
        fmt([[{}]], {
            d(1, function(args, snip)
                local nodes = {}

                local printFunctionToUse = ''

                if snip.trigger == 'ERRORPRINT' or snip.trigger == 'Write-Error' then
                    printFunctionToUse = 'Error'
                elseif snip.trigger == 'PRINT' or snip.trigger == 'Write-Host' then
                    printFunctionToUse = 'Host'
                else
                    printFunctionToUse = 'Output'
                end

                table.insert(
                    nodes,
                    sn(
                        1,
                        fmt(
                            [[
                    Write-{FunctionToUse} "{Text}"
                    ]],
                            {
                                FunctionToUse = t(printFunctionToUse),
                                Text = i(1),
                            }
                        )
                    )
                )

                return sn(nil, nodes)
            end, {}),
        })
    ),

    ms(
        {
            { trig = 'Write-Host', snippetType = 'snippet' },
            -- { trig = 'PRINT', snippetType = 'autosnippet' },
            -- { trig = 'Write-Host', snippetType = 'snippet' },
            -- { trig = 'ERRORPRINT', snippetType = 'autosnippet' },
            -- { trig = 'Write-Output', snippetType = 'snippet' },
        },
        fmt(
            [[
            {}
        ]],
            {

                d(1, function(args, snip)
                    local nodes = {}

                    local write_host = sn(
                        nil,
                        fmt(
                            [[
                     Write-Host "{}" -ForegroundColor {} -BackgroundColor {}
                     ]],
                            {
                                i(1),
                                c(2, powershell_foreground_highlights),
                                c(3, powershell_background_highlights),
                            }
                        )
                    )

                    local write_output = sn(
                        nil,
                        fmt(
                            [[
                    Write-Output "{}"
                    ]],
                            {
                                i(1),
                            }
                        )
                    )

                    local write_error = sn(
                        nil,
                        fmt(
                            [[
                    Write-Error "{}"
                    ]],
                            {
                                i(1),
                            }
                        )
                    )

                    local choices = {
                        write_error,
                        write_host,
                        write_output,
                    }

                    -- local function tableMoveFirstToLast(items)
                    --     local firstItem = items[1]
                    --     table.remove(items, 1)
                    --     items[#items + 1] = firstItem
                    -- end
                    -- if snip.trigger ~= 'ERRORPRINT' then
                    --     tableMoveFirstToLast(choices)
                    -- end

                    table.insert(nodes, c(1, choices))

                    return sn(nil, nodes)
                end, {}),
            }
        )
    ),

    ms(
        {
            { trig = 'FREACH', snippetType = 'autosnippet' },
            { trig = 'ForEach-Object', snippetType = 'snippet' },
        },
        fmt([[ForEach-Object {{ {} }}]], {
            i(1),
        })
    ),

    s(
        'TRY',
        fmt(
            [[
        try
        {{
            {}
        }}
        catch
        {{
            {}
        }}
        {}
        ]],
            {
                i(1),
                i(2),
                i(0),
            }
        )
    ),
}

return snippets, autosnippets
