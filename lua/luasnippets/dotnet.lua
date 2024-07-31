---@diagnostic disable: undefined-global

-- TODO: create function to check file extension for cs and add semicolon to end of lines
local add_optional_semicolon = f(function(args, snip)
    local file_extension = vim.fn.expand('%:e')
    local return_string
    if file_extension == 'csharp' then
        return_string = ';'
    end
    return return_string
end, {})

local auxiliary = require('luasnippets.functions.auxiliary')

local snippets = {
    ms(
        {
            { trig = 'string join', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[String.Join('{Delim}', {Collection})]], {
            Delim = i(1, ','),
            Collection = i(2, 'MyItems'),
        })
    ),
    ms(
        {
            { trig = 'asp log', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt([[app.Logger.{LogLevel}($"{LogText}");]], {
            LogLevel = c(1, {
                t('LogInformation'),
                t('LogError'),
                t('LogCritical'),
                t('LogTrace'),
                t('LogWarning'),
                t('LogDebug'),
            }),
            LogText = i(2),
        })
    ),

    ms(
        {
            { trig = 'region', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
    #region {Name}

    {CapturedText}

    #endregion
    ]],
            {
                Name = i(1, 'Name'),
                CapturedText = auxiliary.wrap_selected_text(2),
            }
        )
    ),

    s(
        'environment variable get',
        fmt(
            [[
         Environment.GetEnvironmentVariable("{}"{})
         ]],
            {
                i(1, 'EnvironmentVariableName'),
                c(2, {
                    t(''),
                    t(', EnvironmentVariableTarget.User'),
                    t(', EnvironmentVariableTarget.Process'),
                    t(', EnvironmentVariableTarget.Machine'),
                }),
            }
        )
    ),

    s(
        {
            trig = 'Regex.Replace',
        },
        fmt(
            [[
        Regex.Replace({}, @"{}", @"{}"){}
        ]],
            {
                i(1, 'InputString'),
                i(2, 'Regex'),
                i(3, 'Replacement'),
                add_optional_semicolon,
            }
        ),
        {
            callbacks = {
                [-1] = {
                    -- Write needed using directives before expanding snippet so positions are not messed up
                    [events.pre_expand] = function()
                        auxiliary.insert_include_if_needed('System.Text.RegularExpressions')
                    end,
                },
            },
        }
    ),

    ms(
        {
            { trig = 'regex match', snippetType = 'snippet' },
            { trig = 'REGMATCH', snippetType = 'autosnippet' },
        },
        fmt([[Regex.Match({}, @"{}", RegexOptions.IgnorePatternWhitespace)]], {
            i(1, '"source"'),
            i(2, '.*'),
        }),
        {
            callbacks = {
                [-1] = {
                    -- Write needed using directives before expanding snippet so positions are not messed up
                    [events.pre_expand] = function()
                        V('test')
                        auxiliary.insert_include_if_needed('System.Text.RegularExpressions')
                    end,
                },
            },
        }
    ),

    ms(
        {
            { trig = 'regex matches', snippetType = 'snippet' },
            { trig = 'ALLREGMATCH', snippetType = 'autosnippet' },
        },
        fmt([[Regex.Matches({}, @"{}", RegexOptions.IgnorePatternWhitespace)]], {
            i(1, '"source"'),
            i(2, '.*'),
        }),
        {
            callbacks = {
                [-1] = {
                    -- Write needed using directives before expanding snippet so positions are not messed up
                    [events.pre_expand] = function()
                        V('test')
                        auxiliary.insert_include_if_needed('System.Text.RegularExpressions')
                    end,
                },
            },
        }
    ),

    ms(
        {
            { trig = 'regex replace', snippetType = 'snippet' },
            { trig = 'REGREPLACE', snippetType = 'autosnippet' },
        },
        fmt([[Regex.Replace({}, @"{}", RegexOptions.IgnorePatternWhitespace)]], {
            i(1, '"source"'),
            i(2, '.*'),
        }),
        {
            callbacks = {
                [-1] = {
                    -- Write needed using directives before expanding snippet so positions are not messed up
                    [events.pre_expand] = function()
                        V('test')
                        auxiliary.insert_include_if_needed('System.Text.RegularExpressions')
                    end,
                },
            },
        }
    ),

    ms(
        {
            { trig = 'aggregate', snippetType = 'snippet' },
        },
        fmt(
            [[
        Aggregate({}, (acc, x) => {})
        ]],
            {
                i(1, 'initial_value'),
                i(2, 'calculation'),
            }
        )
    ),
}

local autosnippets = {
    s(
        'ReadLine',
        fmt(
            [[
        Console.ReadLine()
        ]],
            {}
        )
    ),

    -- {{{ XML autosnippet starter
    s(
        {
            trig = '///',
            descr = 'XML comment summary',
        },
        fmt(
            [[
    /// <summary>
    /// {}
    /// </summary>{}
    ]],
            {
                i(1),
                i(2),
            }
        ),
        {
            callbacks = {
                [-1] = {
                    -- Set vim comment mode to help continue writing the XML comment
                    -- Pressing the trigger of '///' again would trigger the snippet again
                    [events.enter] = function()
                        vim.cmd('set formatoptions+=cro')
                        P('made it')
                    end,
                },
                [2] = {
                    -- Disable the vim settings after leaving the snippet
                    [events.leave] = function()
                        vim.cmd('set formatoptions-=cro')
                        P('double made it')
                    end,
                },
            },
        }
    ),
    -- }}}

    --[[
https://learn.microsoft.com/en-us/dotnet/fsharp/language-reference/xml-documentation

Documenting code is recommended for many reasons. What follows are some best practices, general use case scenarios, and things that you should know when using XML documentation tags in your F# code.
* Enable the option --warnon:3390 in your code to help ensure your XML documentation is valid XML.
* Consider adding signature files to separate long XML documentation comments from your implementation.
* For the sake of consistency, all publicly visible types and their members should be documented. If you must do it, do it all.
* At a bare minimum, modules, types, and their members should have a plain /// comment or <summary> tag. This will show in an autocompletion tooltip window in F# editing tools.
* Documentation text should be written using complete sentences ending with full stops.
    ]]
    s(
        'XML XML',
        fmt([[{}]], {
            c(1, {
                sn(
                    nil,
                    fmt(
                        [[
                   <summary>{}</summary>
                   ]],
                        {
                            i(1, 'Summary text'),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                 <remarks>{}</remarks>
                 ]],
                        {
                            i(1, 'Specifies that text contains supplementary information about the program element'),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <param name="{}">{}</param>
                ]],
                        {
                            i(1),
                            i(2, 'Specifies the name and description for a function or method parameter'),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <typeparam name="{}">{}</typeparam>
                ]],
                        {
                            i(1),
                            i(2, 'Specifies the name and description for a type parameter'),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <returns>{}</returns>
                ]],
                        {
                            i(1, 'Describe the return value of a function or method'),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <exception cref="{}">{}</exception>
                ]],
                        {
                            i(1, 'Exception type'),
                            i(
                                2,
                                'Specifies the type of exception that can be generated and the circumstances under which it is thrown'
                            ),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <seealso cref="{}"/>
                ]],
                        {
                            i(
                                1,
                                'Specifies the type of exception that can be generated and the circumstances under which it is thrown'
                            ),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <para>{}</para>
                ]],
                        {
                            i(1, 'Specifies a paragraph of text. This is used to separate text inside the remarks tag'),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <code>{}</code>
                ]],
                        {
                            i(
                                1,
                                'Specifies that text is multiple lines of code. This tag can be used by generators to display text in a font that is appropriate for code'
                            ),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <paramref name="{}"/>
                ]],
                        {
                            i(1, 'Specifies a reference to a parameter in the same documentation comment'),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <typeparamref name="{}"/>
                ]],
                        {
                            i(1, 'Specifies a reference to a type parameter in the same documentation comment'),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <c>{}</c>
                ]],
                        {
                            i(1, 'Specifies a reference to a type parameter in the same documentation comment'),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <see cref="{}">{}</see>
                ]],
                        {
                            i(1, 'reference'),
                            i(2, 'Specifies a reference to a type parameter in the same documentation comment'),
                        }
                    )
                ),

                --
            }),
        })
    ),

    s(
        '\\\\',
        fmt([[{}]], {
            c(1, {
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

    --
}

return snippets, autosnippets
