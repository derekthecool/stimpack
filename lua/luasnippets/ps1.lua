---@diagnostic disable: undefined-global

local shareable = require('luasnippets.functions.shareable_snippets')

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
    Describe '{TestGroupName}' {{
        It '{TestDescription}' {{
            {Assertion}
        }}
    }}
    ]],
            {
                TestGroupName = i(1, 'Test group'),
                TestDescription = i(2, 'This test does ....'),
                Assertion = i(3, '$(Get-ChildItem).Count | Should -Be 42'),
            }
        )
    )
end

local function CustomObject(index)
    return sn(
        index,
        fmt(
            [[
     [PSCustomObject]@{{
         {Items}
     }}
     ]],
            {
                Items = i(1, 'Name = "Derek"'),
            }
        )
    )
end

local function ApprovedVerb(index)
    return sn(
        index,
        fmt([[{}]], {
            c(1, {
                t('Add'),
                t('Clear'),
                t('Close'),
                t('Copy'),
                t('Enter'),
                t('Exit'),
                t('Find'),
                t('Format'),
                t('Get'),
                t('Hide'),
                t('Join'),
                t('Lock'),
                t('Move'),
                t('New'),
                t('Open'),
                t('Optimize'),
                t('Push'),
                t('Pop'),
                t('Redo'),
                t('Remove'),
                t('Rename'),
                t('Reset'),
                t('Resize'),
                t('Search'),
                t('Select'),
                t('Set'),
                t('Show'),
                t('Skip'),
                t('Split'),
                t('Step'),
                t('Switch'),
                t('Undo'),
                t('Unlock'),
                t('Watch'),
                t('Connect'),
                t('Disconnect'),
                t('Read'),
                t('Receive'),
                t('Send'),
                t('Write'),
                t('Backup'),
                t('Checkpoint'),
                t('Compare'),
                t('Compress'),
                t('Convert'),
                t('ConvertFrom'),
                t('ConvertTo'),
                t('Dismount'),
                t('Edit'),
                t('Expand'),
                t('Export'),
                t('Group'),
                t('Import'),
                t('Initialize'),
                t('Limit'),
                t('Merge'),
                t('Mount'),
                t('Out'),
                t('Publish'),
                t('Restore'),
                t('Save'),
                t('Sync'),
                t('Unpublish'),
                t('Update'),
                t('Debug'),
                t('Measure'),
                t('Ping'),
                t('Repair'),
                t('Resolve'),
                t('Test'),
                t('Trace'),
                t('Approve'),
                t('Assert'),
                t('Build'),
                t('Complete'),
                t('Confirm'),
                t('Deny'),
                t('Deploy'),
                t('Disable'),
                t('Enable'),
                t('Install'),
                t('Invoke'),
                t('Register'),
                t('Request'),
                t('Restart'),
                t('Resume'),
                t('Start'),
                t('Stop'),
                t('Submit'),
                t('Suspend'),
                t('Uninstall'),
                t('Unregister'),
                t('Wait'),
                t('Use'),
                t('Block'),
                t('Grant'),
                t('Protect'),
                t('Revoke'),
                t('Unblock'),
                t('Unprotect'),
            }),
        })
    )
end

local snippets = {
    ms(
        {
            { trig = '$\\(\\)', regTrig = false, snippetType = 'autosnippet', condition = nil },
        },
        fmt([[$({})]], {
            i(1),
        })
    ),

    ms(
        {
            { trig = 'error', snippetType = 'snippet', condition = nil },
            { trig = 'error action', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[-ErrorAction {Options}]], {
            Options = c(1, {
                t('SilentlyContinue'),
                t('Stop'),
                t('Break'),
                t('Ignore'),
                t('Inquire'),
                t('Suspend'),
                t('Continue'),
            }),
        })
    ),

    ms(
        {
            { trig = 'custom object', snippetType = 'snippet', condition = nil },
        },
        fmt([[{Custom}]], {
            Custom = CustomObject(1),
        })
    ),

    ms(
        {
            { trig = 'pipelineInput', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string]$pipelineInput
)

Begin {
    <BeginWork>
}

Process {
    <ProcessWork>
}

End {
    <EndWork>
}
        ]],
            {
                BeginWork = i(1, 'echo start processing'),
                ProcessWork = i(2, 'ForEach-Object { $_ }'),
                EndWork = i(3, 'echo end processing'),
            },
            {
                delimiters = '<>',
            }
        )
    ),

    ms(
        {
            { trig = 'Update-TypeData', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
        Update-TypeData -TypeName {TypeName} -DefaultDisplayPropertySet {ListOfPropertiesToShow} CreatedBy -ErrorAction SilentlyContinue
        ]],
            {
                TypeName = i(1, 'MyClass'),
                ListOfPropertiesToShow = i(2, 'Id, Count, Sum'),
            }
        )
    ),

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
            { trig = 'TEST', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
    It '{TestDescription}' {{
        {}
    }}
        ]],
            {
                TestDescription = i(1, 'This test should do ....'),
                i(2),
            }
        )
    ),

    ms(
        {
            { trig = 'ASSERT', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        {Input} | Should -{Option}
        ]],
            {
                Input = i(1, 'VariableOrCommand'),
                Option = c(2, {
                    t('Be'),
                    t('Throw'),
                    t('BeOfType'),
                    t('BeTrue'),
                    t('BeFalse'),
                    t('HaveCount'),
                    i(1),
                }),
            }
        )
    ),

    ms(
        {
            { trig = 'FILE_TEST', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        BeforeAll {{
            . {Filename}
        }}

        {Test}
        ]],
            {
                Filename = d(1, function(args, snip)
                    local nodes = {}

                    -- Add nodes for snippet
                    local scandir = require('plenary.scandir')
                    local files = scandir.scan_dir(
                        string.format('%s/..', vim.fn.expand('%:h')),
                        { respect_gitignore = true, search_pattern = '%.ps1' }
                    )

                    for _, value in ipairs(files) do
                        table.insert(nodes, t(value))
                    end

                    -- local choices = c(1, nodes)

                    return sn(nil, {
                        c(1, nodes),
                    })
                end, {}),
                Test = PesterTest(2),
            }
        )
    ),

    ms(
        {
            { trig = 'const', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        Set-Variable {Name} -Option Constant -Value {Value}
        ]],
            {
                Name = i(1, 'MyConstVariable'),
                Value = i(2, '"Value"'),
            }
        )
    ),

    ms(
        {
            { trig = 'ValidateSet', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt([=[[ValidateSet({Items})]]=], {
            Items = i(1, 'One, Two, Three'),
        })
    ),

    ms(
        {
            { trig = 'ValidatePattern', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [=[
        [ValidatePattern('{Pattern}')]
        ]=],
            {
                Pattern = i(1, '.*'),
            }
        )
    ),
    ms(
        {
            { trig = 'ValidateCount', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt('[ValidateCount(int {minLength}, int {maxLength})]', {
            minLength = i(1, '0'),
            maxLength = i(2, '100'),
        })
    ),
    ms(
        {
            { trig = 'ValidateLength', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt('[ValidateLength(int {minLength}, int {maxLength})]', {
            minLength = i(1, '20'),
            maxLength = i(2, '100'),
        })
    ),

    ms(
        {
            { trig = '###', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt([[{}]], {
            c(1, {

                -- Short version

                sn(
                    nil,
                    fmt(
                        [[
    <#
        .SYNOPSIS
        {Synopsis}

        .DESCRIPTION
        {Description}

        .PARAMETER Name
        {Parameter}

        .EXAMPLE
        {Example}
    #>
                  ]],
                        {
                            Synopsis = i(1, 'Adds a file name extension to a supplied name.'),
                            Description = i(
                                2,
                                'Adds a file name extension to a supplied name. Takes any strings for the file name or extension.'
                            ),
                            Parameter = i(3, 'Specifies the file name.'),
                            Example = i(4, 'PS> Add-Extension -name "File"'),
                        }
                    )
                ),

                -- Full version
                sn(
                    nil,
                    fmt(
                        [[
    <#
        .SYNOPSIS
        Adds a file name extension to a supplied name.

        .DESCRIPTION
        Adds a file name extension to a supplied name.
        Takes any strings for the file name or extension.

        .PARAMETER Name
        Specifies the file name.

        .PARAMETER Extension
        Specifies the extension. "Txt" is the default.

        .INPUTS
        None. You can't pipe objects to Add-Extension.

        .OUTPUTS
        System.String. Add-Extension returns a string with the extension or file name.

        .EXAMPLE
        PS> Add-Extension -name "File"
        File.txt

        .EXAMPLE
        PS> Add-Extension -name "File" -extension "doc"
        File.doc

        .EXAMPLE
        PS> Add-Extension "File" "doc"
        File.doc

        .LINK
        Online version: http://www.fabrikam.com/add-extension.html

        .LINK
        Set-Item
    #>
                  ]],
                        {}
                    )
                ),
            }),
        })
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
            { trig = 'REGMATCH', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
    if({String} -cmatch '{Pattern}')
    {{
        {Code}
    }}
        ]],
            {
                String = i(1, 'string to match'),
                Pattern = i(2, '.*'),
                Code = i(3),
            }
        )
    ),

    ms(
        {
            { trig = 'ALLREGMATCH', snippetType = 'autosnippet' },
        },
        fmt(
            -- Old method
            -- [regex]::Matches({Source}, '{Pattern}', 'IgnorePatternWhitespace') | ForEach-Object {{ $_.{DoSomething} }}
            -- New method uses PSScriptTools function ConvertFrom-Text
            [[ConvertFrom-Text '{Pattern}']],
            {
                Pattern = i(1, '.*'),
            }
        )
    ),

    ms(
        {
            { trig = 'FOR', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        for(${Variable} = {InitialValue}; ${RepeatVariable} {Condition}; ${RepeatVariable}{Operation}){{
            {Code}
        }}
        ]],
            {
                Variable = i(1, 'i'),
                InitialValue = i(2, '0'),
                RepeatVariable = rep(1),
                Condition = i(3, '-lt 10'),
                Operation = i(4, '++'),
                Code = i(5),
            }
        )
    ),

    ms(
        {
            { trig = '\\\\', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[{}]], {
            c(1, {
                -- t('(?<{NamedCaptureGroup})}'),
                sn(
                    nil,
                    fmt([[(?<{NamedCaptureGroup}>{Pattern})]], {
                        NamedCaptureGroup = i(1, 'NamedCaptureGroup'),
                        Pattern = i(2, '.*'),
                    })
                ),
                -- https://learn.microsoft.com/en-us/dotnet/standard/base-types/character-classes-in-regular-expressions
                t('(?# Letter, Uppercase)\\p{Lu}'),
                t('(?# Letter, Lowercase)\\p{Ll}'),
                t('(?# Letter, Titlecase)\\p{Lt}'),
                t('(?# Letter, Modifier)\\p{Lm}'),
                t('(?# Letter, Other)\\p{Lo}'),
                t('(?# All letter characters. This includes the Lu, Ll, Lt, Lm, and Lo characters.)\\p{L}'),
                t('(?# Mark, Nonspacing)\\p{Mn}'),
                t('(?# Mark, Spacing Combining)\\p{Mc}'),
                t('(?# Mark, Enclosing)\\p{Me}'),
                t('(?# All combining marks. This includes the Mn, Mc, and Me categories.)\\p{M}'),
                t('(?# Number, Decimal Digit)\\p{Nd}'),
                t('(?# Number, Letter)\\p{Nl}'),
                t('(?# Number, Other)\\p{No}'),
                t('(?# All numbers. This includes the Nd, Nl, and No categories.)\\p{N}'),
                t('(?# Punctuation, Connector)\\p{Pc}'),
                t('(?# Punctuation, Dash)\\p{Pd}'),
                t('(?# Punctuation, Open)\\p{Ps}'),
                t('(?# Punctuation, Close)\\p{Pe}'),
                t('(?# Punctuation, Initial quote (may behave like Ps or Pe depending on usage))\\p{Pi}'),
                t('(?# Punctuation, Final quote (may behave like Ps or Pe depending on usage))\\p{Pf}'),
                t('(?# Punctuation, Other)\\p{Po}'),
                t(
                    '(?# All punctuation characters. This includes the Pc, Pd, Ps, Pe, Pi, Pf, and Po categories.)\\p{P}'
                ),
                t('(?# Symbol, Math)\\p{Sm}'),
                t('(?# Symbol, Currency)\\p{Sc}'),
                t('(?# Symbol, Modifier)\\p{Sk}'),
                t('(?# Symbol, Other)\\p{So}'),
                t('(?# All symbols. This includes the Sm, Sc, Sk, and So categories.)\\p{S}'),
                t('(?# Separator, Space)\\p{Zs}'),
                t('(?# Separator, Line)\\p{Zl}'),
                t('(?# Separator, Paragraph)\\p{Zp}'),
                t('(?# All separator characters. This includes the Zs, Zl, and Zp categories.)\\p{Z}'),
                t('(?# Other, Control A.K.A. non printables)\\p{Cc}'),
                t('(?# Other, Format)\\p{Cf}'),
                t('(?# Other, Surrogate)\\p{Cs}'),
                t('(?# Other, Private Use)\\p{Co}'),
                t('(?# Other, Not Assigned or Noncharacter)\\p{Cn}'),
                t('(?# All other characters. This includes the Cc, Cf, Cs, Co, and Cn categories.)\\p{C}'),
                t('\\d'),
                t('\\d+'),
                t('\\d*'),
                t('\\w'),
                t('\\w+'),
                t('\\w*'),
                t('\\s'),
                t('\\s+'),
                t('\\s*'),
                -- My awesome regexes with descriptions
                t('?# Non vowels, uses range subtraction)[a-zA-Z-[aeiouAEIOU]]'),
            }),
        })
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
            { trig = 'SWITCH', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        switch {Options} ({Expression}) {{
            {MatchValue} {{ {Code} }}
            default {{ {DefaultCode} }}
        }}
        ]],
            {
                Options = c(1, {
                    t('-Regex'),
                    t(''),
                    t('-Wildcard'),
                    t('-Exact'),
                    t('-CaseSensitive'),
                    t('-File'),
                }),
                Expression = i(2, 'Variable'),
                MatchValue = i(3, '"Match this value"'),
                Code = i(4, 'echo run this code'),
                DefaultCode = i(5, 'Write-Error "This code fails"'),
            }
        )
    ),

    ms(
        {
            { trig = 'FUNCTION', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        function {Verb}-{Noun} {{
            {}
        }}
        ]],
            {
                Verb = ApprovedVerb(1),
                Noun = i(2, 'Noun'),
                i(3),
            }
        )
    ),

    ms(
        {
            { trig = 'Write-Host', snippetType = 'snippet' },
            { trig = 'PRINT', snippetType = 'autosnippet' },
            { trig = 'ERRORPRINT', snippetType = 'autosnippet' },
            { trig = 'Write-Output', snippetType = 'snippet' },
        },
        fmt([[{}]], {
            d(1, function(args, snip)
                local nodes = {}

                local printFunctionToUse = ''

                if snip.trigger == 'ERRORPRINT' or snip.trigger == 'Write-Error' then
                    printFunctionToUse = 'Error'
                elseif snip.trigger == 'PRINT' or snip.trigger == 'Write-Information' then
                    printFunctionToUse = 'Information'
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
            { trig = 'ForEach-Object { $_', snippetType = 'autosnippet', wordTrig = false },
        },
        fmt([[{}]], {
            c(1, {
                sn(
                    nil,
                    fmt([[ForEach-Object {{ {} }}]], {
                        i(1),
                    })
                ),

                -- Full foreach-object
                sn(
                    nil,
                    fmt(
                        [[
                ForEach-Object -Begin {
                     <Begin>
                 } -Process {
                     <Process>
                } -End {
                     <End>
                }
                ]],
                        {
                            Begin = i(1, '$sum = 0'),
                            Process = i(2, '$sum += $_'),
                            End = i(3, '$sum'),
                        },

                        {
                            delimiters = '<>',
                        }
                    )
                ),
            }),
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
