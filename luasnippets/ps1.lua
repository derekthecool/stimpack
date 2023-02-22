---@diagnostic disable: undefined-global
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
        .Synopsis
           Short description
        .DESCRIPTION
           Long description
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
            # Param1 help description
            [Parameter(Mandatory=$true,
                ValueFromPipeline=$true,
                ValueFromPipelineByPropertyName=$true,
                ValueFromRemainingArguments=$false,
                Position=0,
                ParameterSetName='Parameter Set 1')]
            [ValidateNotNull()]
            [ValidateNotNullOrEmpty()]
            [ValidateCount(0,5)]
            [ValidateSet("sun", "moon", "earth")]
            [Alias("p1")] 
            $Param1

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
                i(1),
                i(2),
                i(3),
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
        Write-Host "{}"
        ]],
            {
                i(1),
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
        'write host',
        fmt(
            [[
        Write-Host "{}" -ForegroundColor {}
        ]],
            {
                i(1),
                c(2, {
                    t('Black'),
                    t('DarkBlue'),
                    t('DarkGreen'),
                    t('DarkCyan'),
                    t('DarkRed'),
                    t('DarkMagenta'),
                    t('DarkYellow'),
                    t('Gray'),
                    t('DarkGray'),
                    t('Blue'),
                    t('Green'),
                    t('Cyan'),
                    t('Red'),
                    t('Magenta'),
                    t('Yellow'),
                    t('White'),
                }),
            }
        )
    ),

    s(
        'write output',
        fmt(
            [[
        Write-Output "{}"
        ]],
            {
                i(1),
            }
        )
    ),
}

return snippets, autosnippets
