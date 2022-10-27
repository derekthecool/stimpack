---@diagnostic disable: undefined-global
local snippets = {
    s(
        'list',
        fmt('${} = New-Object System.Collections.Generic.List[string]', {
            i(1),
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
