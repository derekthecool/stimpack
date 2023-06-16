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

local snippets = {
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
                end,
                {  }),
                i(1, 'Short script description'),
                i(2, 'Long script description'),
                i(3, 'param1'),
                i(4, 'echo "start code"'),
                i(5, 'echo "perform code"'),
                i(6, 'echo "end code"'),
            }
        )
    ),

    s(
        'param',
        fmt(
            [[
    {}[Parameter(
        Mandatory=${},
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true,
        ValueFromRemainingArguments=$false,
        Position=0,
        ParameterSetName='Parameter Set 1')]
    [{}]${}
        ]],
            {
                c(1, {
                    t(''),
                    t(','),
                }),

                c(2, {
                    t('true'),
                    t('false'),
                }),
                c(3, {
                    t('switch'),
                    i(1, 'WriteYourOwnType'),
                    t('string'),
                    t('int32'),
                }),
                i(4, 'VariableName'),
            }
        )
    ),

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
        else if({})
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

    s(
        'FUNCTION',
        fmt(
            [[
        function {} {{
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
        'PRINT',
        fmt(
            [[
            {}
        ]],
            {
                c(1, {
                    sn(
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
                    ),

                    sn(
                        nil,
                        fmt(
                            [[
                    Write-Output "{}"
                    ]],
                            {
                                i(1),
                            }
                        )
                    ),

                    sn(
                        nil,
                        fmt(
                            [[
                    Write-Error "{}"
                    ]],
                            {
                                i(1),
                            }
                        )
                    ),
                }),
            }
        )
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

    s(
        { trig = '?', regTrig = false, wordTrig = false },
        fmt(
            [[
        | Where-Object {{
            $_{}
        }}
        ]],
            {
                i(1),
            }
        )
    ),
}

return snippets, autosnippets
