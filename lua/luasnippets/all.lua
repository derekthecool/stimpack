---@diagnostic disable: undefined-global
local snippets = {
    ms(
        {
            { trig = 'version', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        {CommentString} Print the language version
        {PrintCommand}
        ]],
            {
                CommentString = f(function(args, snip)
                    return ((require('Comment.ft').get(vim.bo.filetype)[1]):gsub('%%s', ''))
                end, {}),
                PrintCommand = f(function(args, snip)
                    local file_type = vim.bo.filetype
                    if file_type == 'c' then
                        return [[printf("C language version: %lu\n", __STDC_VERSION__);]]
                    elseif file_type == 'cpp' then
                        return [[printf("CPP language version: %lu\n", __cplusplus );]]
                    else
                        return string.format(
                            require('Comment.ft').get(vim.bo.filetype)[1],
                            'Language ' .. file_type .. ' not found'
                        )
                    end
                end),
            }
        )
    ),

    ms(
        {
            { trig = 'ad_unit', snippetType = 'snippet' },
        },
        fmt([[{}]], {
            c(1, {
                t('ca-app-pub-3940256099942544/9214589741'),
            }),
        })
    ),

    ms(
        {
            { trig = '$$', snippetType = 'autosnippet' },
            -- Left
            { trig = '¥', snippetType = 'autosnippet' },
            { trig = '$$', snippetType = 'snippet' },
        },
        fmt([[${}]], {
            i(1, 'variable'),
        })
    ),

    ms(
        {
            { trig = '{{', snippetType = 'autosnippet' },
            -- Right
            { trig = '€', snippetType = 'autosnippet' },
            { trig = '${', snippetType = 'snippet' },
        },
        fmt([[${{{}}}]], {
            i(1, 'variable'),
        })
    ),

    ms({
        { trig = 'pi', snippetType = 'snippet' },
    }, fmt([[3.141592653589793238462643383279502884197169399375105820974944592307816406286]], {})),
}

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
            { trig = '<<<<', snippetType = 'autosnippet' },
        },
        fmt([[<{}>]], {
            i(1),
        })
    ),

    ms(
        {
            { trig = 'ansi_color_background', snippetType = 'snippet', condition = nil },
        },
        fmt([[\033[48;2;{BG_Red};{BG_Green};{BG_Blue}{TextMode}m{Text}\033[0m]], {
            BG_Red = i(1, '0-255 BG Red'),
            BG_Green = i(2, '0-255 BG Green'),
            BG_Blue = i(3, '0-255 BG Blue'),
            TextMode = c(4, {
                t(''), -- Normal
                t(';1'), -- Bold
                t(';2'), -- Dim
                t(';3'), -- Italic
                t(';4'), -- Underline
                t(';5'), -- Blinking slow
                t(';6'), -- Blinking fast
                t(';7'), -- Inverted color
                t(';8'), -- Strike through
            }),
            Text = i(5, 'Text with background color'),
        })
    ),

    ms(
        {
            { trig = 'ansi_color_foreground', snippetType = 'snippet', condition = nil },
        },
        fmt([[\033[38;2;{FG_Red};{FG_Green};{FG_Blue}{TextMode}m{Text}\033[0m]], {
            FG_Red = i(1, '0-255 FG Red'),
            FG_Green = i(2, '0-255 FG Green'),
            FG_Blue = i(3, '0-255 FG Blue'),
            TextMode = c(4, {
                t(''), -- Normal
                t(';1'), -- Bold
                t(';2'), -- Dim
                t(';3'), -- Italic
                t(';4'), -- Underline
                t(';5'), -- Blinking slow
                t(';6'), -- Blinking fast
                t(';7'), -- Inverted color
                t(';8'), -- Strike through
            }),
            Text = i(5, 'Text with background color'),
        })
    ),

    ms(
        {
            { trig = '\\e', snippetType = 'snippet' },
            { trig = '\\033', snippetType = 'snippet' },
            { trig = 'ansi_color', snippetType = 'snippet' },
            { trig = 'color', snippetType = 'snippet' },
        },
        fmt([[\033[38;2;{FG_Red};{FG_Green};{FG_Blue};48;2;{BG_Red};{BG_Green};{BG_Blue}{TextMode}m{Text}\033[0m]], {
            FG_Red = i(1, '0-255 FG Red'),
            FG_Green = i(2, '0-255 FG Green'),
            FG_Blue = i(3, '0-255 FG Blue'),
            BG_Red = i(4, '0-255 BG Red'),
            BG_Green = i(5, '0-255 BG Green'),
            BG_Blue = i(6, '0-255 BG Blue'),
            TextMode = c(7, {
                t(''), -- Reset
                t(';1'), -- Bold
                t(';2'), -- Dim
                t(';3'), -- Italic
                t(';4'), -- Underline
                t(';5'), -- Blinking slow
                t(';6'), -- Blinking fast
                t(';7'), -- Inverted color
                t(';8'), -- Strike through
            }),
            Text = i(8, 'Text to print in color'),
        })
    ),
}

return snippets, autosnippets
