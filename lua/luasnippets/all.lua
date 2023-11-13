---@diagnostic disable: undefined-global
local snippets = {}

local autosnippets = {
    s(
        'TODO',
        fmt([[TODO: (Derek Lomax) {}, {}]], {
            f(function(args, snip)
                return os.date('%c')
            end, {}),
            i(1, 'Do something here later'),
        })
    ),

    ms(
        {
            {
                trig = [['''']],
                snippetType = 'autosnippet',
            },
        },
        fmt([['{}']], {
            i(1),
        })
    ),

    ms(
        {
            {
                trig = [[""""]],
                snippetType = 'autosnippet',
            },
        },
        fmt([["{}"]], {
            i(1),
        })
    ),

    ms(
        {
            { trig = '\\e', snippetType = 'snippet' },
            { trig = '\\033', snippetType = 'snippet' },
            { trig = 'ansi color', snippetType = 'snippet' },
            { trig = 'color', snippetType = 'snippet' },
        },
        fmt(
            [[
        \033[38;2;{};{};{};48;2;{};{};{};{}m
        ]],
            {
                i(1, '0-255 FG Red'),
                i(2, '0-255 FG Green'),
                i(3, '0-255 FG Blue'),
                i(4, '0-255 BG Red'),
                i(5, '0-255 BG Green'),
                i(6, '0-255 BG Blue'),
                c(7, {
                    t('0'), -- Reset
                    t('1'), -- Bold
                    t('2'), -- Dim
                    t('3'), -- Italic
                    t('4'), -- Underline
                    t('5'), -- Blinking slow
                    t('6'), -- Blinking fast
                    t('7'), -- Inverted color
                    t('8'), -- Strike through
                }),
            }
        )
    ),
}

return snippets, autosnippets
