---@diagnostic disable: undefined-global
local snippets = {
    ms(
        {
            { trig = 'style', snippetType = 'snippet' },
        },
        fmt(
            [[
         # Starship.toml style, optionally none, fg:<color>, and bg:<color>
         style = '{TextStyle} {Color}'
         ]],
            {
                TextStyle = c(1, {
                    t('bold'),
                    t('italic'),
                    t('underline'),
                    t('dimmed'),
                    t('inverted'),
                    t('blink'),
                    t('hidden'),
                    t('strikethrough'),
                }),
                Color = c(2, {
                    t('black'),
                    t('bright-black'),
                    t('red'),
                    t('bright-red'),
                    t('green'),
                    t('bright-green'),
                    t('blue'),
                    t('bright-blue'),
                    t('yellow'),
                    t('bright-yellow'),
                    t('purple'),
                    t('bright-purple'),
                    t('cyan'),
                    t('bright-cyan'),
                    t('white'),
                    t('bright-white'),
                    sn(
                        nil,
                        fmt([[#{HexColor}]], {
                            HexColor = i(1, 'AA00FF'),
                        })
                    ),
                }),
            }
        )
    ),
}

local autosnippets = {
    -- Filetypes like this only need a single snippet
    -- The basic template starter point
    s(
        'FIRST',
        fmt(
            [[
        column_width = 120
        line_endings = "Unix"
        indent_type = "Spaces"
        indent_width = 4
        quote_style = "ForceSingle"
        call_parentheses = "Always"
        ]],
            {}
        )
    ),
}

return snippets, autosnippets
