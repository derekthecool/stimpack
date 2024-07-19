---@diagnostic disable: undefined-global

local auxiliary = require('luasnippets.functions.auxiliary')

local snippets = {

    ms(
        {
            { trig = 'GitHub_alert', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
        > [!{AlertType}]
        > {Text}
        ]],
            {
                AlertType = c(1, {
                    t('NOTE'),
                    t('TIP'),
                    t('IMPORTANT'),
                    t('WARNING'),
                    t('CAUTION'),
                    i(1, 'custom'),
                }),
                Text = i(2, 'Alert text'),
            }
        )
    ),

    s(
        'footnote',
        fmt([[{}{}{}]], {
            t('['),
            i(1),
            f(function(args, snip)
                return ']'
            end, { 1 }),
        }),
        {
            callbacks = {
                [1] = {
                    [events.leave] = function(node, event_args)
                        local text = string.format('[%s]: ', node:get_text()[1])
                        vim.cmd('normal mm')
                        vim.api.nvim_buf_set_lines(0, -1, -1, false, { text })
                        V('Jumping to end of file to write footnote, position saved at mark m')
                        -- vim.cmd('normal GA')
                        -- vim.api.nvim_win_set_cursor(0,{-1,-1})
                        local esc_key = api.nvim_replace_termcodes('<Esc>', true, false, true)
                        api.nvim_feedkeys(esc_key, 'm', true)
                        -- vim.api.nvim_feedkeys('GA', 'i', false)
                    end,
                },
            },
        }
    ),

    s(
        {
            trig = 'link',
            descr = 'Create markdown link [txt](url)',
        },
        fmt(
            [[
            [{}]({})
            {}
            ]],
            {
                i(1),
                f(function()
                    return vim.fn.getreg('+')
                end, {}),
                i(0),
            }
        )
    ),

    s(
        'image',
        fmt([[![{}]({})]], {
            i(1, 'alt text'),
            i(2, 'image path'),
        })
    ),

    s(
        'pandoc header',
        fmt(
            [[
        % {}
        % {}
        % {}

        # {}

        {}
        ]],
            {
                i(1, 'Title'),
                i(2, 'Derek Lomax'),
                f(function()
                    return os.date('%Y-%m-%d')
                end, {}),
                rep(1),
                i(0),
            }
        )
    ),

    s(
        'CHANGELOG.md',
        fmt(
            [[
        # {} CHANGELOG

        All notable changes to this project will be documented in this file.
        The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
        and this project adheres to
        [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

        {}
        ]],
            {
                i(1, 'ProjectTitle'),
                i(0),
            }
        )
    ),

    s(
        'CHANGELOG.md item',
        fmt(
            [[
        ## {}

        ### {}

        - {}
        ]],
            {
                i(1, 'Version information'),
                i(2, 'Changed'),
                i(3),
            }
        )
    ),

    ms(
        {
            { trig = 'weight weight', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt([[| {Date}              | {Weight}           |]], {
            Date = i(1, '2024-04-30'),
            Weight = i(2, '214.5'),
        })
    ),

    ms(

        {
            { trig = 'CHANGELOG.md CHANGELOG.md', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        ## {Version} {Date}

        ### Added

        - {Added}

        ### Fixed

        - {Fixed}
        ]],
            {
                Version = i(1, '2.1.0'),
                Date = f(function(args, snip)
                    return os.date('%Y-%m-%d')
                end, {}),
                Added = i(2),
                Fixed = i(3),
            }
        )
    ),

    ms(
        {
            { trig = 'Fixed',            snippetType = 'snippet' },
            { trig = 'CHANGELOG.md fix', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        ### Fixed

        - {}
        ]],
            {
                i(1),
            }
        )
    ),

    ms(
        {
            { trig = 'Changed',             snippetType = 'snippet' },
            { trig = 'CHANGELOG.md change', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        ### Changed

        - {}
        ]],
            {
                i(1),
            }
        )
    ),

    ms(
        {
            { trig = 'Removed',             snippetType = 'snippet' },
            { trig = 'CHANGELOG.md remove', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        ### Removed

        - {}
        ]],
            {
                i(1),
            }
        )
    ),

    ms(
        {
            { trig = 'dataview', snippetType = 'snippet' },
        },
        fmt(
            [[
        ```dataview
        {} {}
        ```
        ]],
            {
                c(1, {
                    t('LIST'),
                    t('TABLE'),
                    t('TASK'),
                    t('CALENDAR'),
                }),
                i(2, 'FROM tag'),
            }
        )
    ),

    s(
        'selected_text',
        f(function(_, snip)
            local res, env = {}, snip.env
            table.insert(res, 'Selected Text (current line is ' .. env.TM_LINE_NUMBER .. '):')
            for _, ele in ipairs(env.LS_SELECT_RAW) do
                table.insert(res, ele)
            end
            return res
        end, {})
    ),

    ms(
        {
            { trig = 'front_matter', snippetType = 'snippet' },
            { trig = '---',          snippetType = 'autosnippet' },
        },
        fmt(
            [[
        ---
        {}
        ---
        ]],
            {
                i(1, 'item: value'),
            }
        )
    ),
}

local autosnippets = {

    s(
        '```',
        fmt(
            [[
            ```{}
            {}
            ```
            ]],
            {
                c(1, {
                    t('yaml'),
                    t('sh'),
                    t('powershell'),
                    t('fsharp'),
                    t('csharp'),
                    t('c'),
                    i(1),
                }),
                auxiliary.wrap_selected_text(2),
            }
        )
    ),

    s(
        'dick',
        fmt(
            [[
            {} : {{^}}{}{{^}}
            {}
            ]],
            {
                i(1, 'STKPWHRAO*EUFRPBLTS'),
                i(2),
                i(0),
            }
        )
    ),

    s(
        'TASK',
        fmt('- [ ] {}', {
            i(1),
        })
    ),

    s(
        'FIRST',
        fmt(
            [==[
---
tags: ["daily_work_notes"]
---

# {}

## Objectives

- [ ] {}

## Notes

## Task Progress

![[dataview_diary_query.md]]
        ]==],
            {
                f(function(args, snip)
                    return os.date('%Y-%m-%d')
                end, {}),
                i(1),
            }
        )
    ),

    s(
        'SECOND',
        fmt(
            [[
        # {}

        {}
        ]],
            {
                f(function(args, snip)
                    return vim.fn
                        .expand('%:t')
                        :gsub('_(%w)', function(a)
                            return a:toupper()
                        end)
                        :gsub('%.md', '')
                end, {}),

                i(1),
            }
        )
    ),
}

return snippets, autosnippets
