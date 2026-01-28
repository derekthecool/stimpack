---@diagnostic disable: undefined-global

local auxiliary = require('luasnippets.functions.auxiliary')
local shareable = require('luasnippets.functions.shareable_snippets')

local snippets = {
    ms(
        {
            { trig = 'device_log', snippetType = 'snippet', condition = nil },
            { trig = 'device log', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
      # Device Log Analysis
      
      - Filename: `{Filename}
      - Date of analysis: {Date}
      - Analyzed by: Derek Lomax
      - DeviceId: `{DeviceId}`
      
      ## Synopsis
      
      {Synopsis}
      
      ## Full Description

      {Description}
      
      ## How To Test
      
      ### Configuration
      
      {Configuration}
      
      ### Test Procedure
      
      {TestProcedure}
      
      ## Full Log
      
      > [!NOTE]
      > NOTE this log was captured by placing the device on the cradle and running `register spiffs` then `cat errlogb.txt`
      > Lines that have the visible ANSI chars for color should be ignored and only the clean looking lines should be read!

      ```
      {LogBlock}
      ```
      ]],
            {
                Filename = f(function(args, snip)
                    return vim.fn.expand('%:f:t')
                end, {}),

                -- this function  node depends on the node 5 from the auxiliary.wrap_selected_text return
                -- without this reading the buffer only shows the text from the snippet so far
                DeviceId = f(function(args, snip)
                    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
                    for _, line in ipairs(lines) do
                        local id = line:match('Device ID: (%w+)')
                        if id then
                            return id
                        end
                    end
                    return 'not found after checking ' .. #lines .. ' number of lines'
                end, { 5 }),
                Date = f(function(args, snip)
                    return os.date('%Y-%m-%d')
                end, {}),
                Synopsis = i(1, 'Brief synopsis of issue ....'),
                Description = i(2, 'Full description of problem'),
                Configuration = i(3, '- PowerMode: FS04'),
                TestProcedure = i(4, '1. First ....'),

                -- Function  nodes do not take any index
                LogBlock = auxiliary.wrap_selected_text(5),
            }
        )
    ),

    ms(
        {
            { trig = 'link_local_file', snippetType = 'snippet', condition = nil },
        },
        fmt('[{Reference}]({Path})', {
            Path = shareable.file_list(1),
            -- Reference = i(2, 'Awesome file ....'),
            Reference = d(2, function(args, snip)
                local nodes = {}
                table.insert(nodes, i(1, args[1]))
                return sn(nil, nodes)
            end, { 1 }),
        })
    ),

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
        fmt([[{}]], {
            d(1, function(args, snip)
                local link_from_clipboard = vim.fn.getreg('+')
                local last_part_of_link = link_from_clipboard:match('/([^/]+)$')
                return sn(
                    nil,
                    fmt([[[{Description}]({Link})]], {

                        Description = i(1, last_part_of_link),
                        Link = t(link_from_clipboard),
                    })
                )
            end, {}),
        })
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
            { trig = 'Fixed', snippetType = 'snippet' },
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
            { trig = 'Changed', snippetType = 'snippet' },
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
            { trig = 'Added', snippetType = 'snippet' },
            { trig = 'CHANGELOG.md add', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        ### Added

        - {}
        ]],
            {
                i(1),
            }
        )
    ),

    ms(
        {
            { trig = 'Removed', snippetType = 'snippet' },
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
            { trig = '---', snippetType = 'autosnippet' },
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

    ms(
        {
            { trig = '```', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
            ```{Language}
            {Content}
            ```
            ]],
            {
                Language = c(1, {
                    t('yaml'),
                    t('sh'),
                    t('powershell'),
                    t('fsharp'),
                    t('csharp'),
                    t('c'),
                    i(1),
                }),
                Content = c(2, {
                    f(function(args, snip)
                        return vim.fn.getreg('+', 1, true)
                    end, {}),
                    auxiliary.wrap_selected_text(2),
                }),
            }
        )
    ),
}

local autosnippets = {

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
                    return (vim.fn.expand('%:t') or '')
                        :gsub('_(%w)', function(a)
                            if type(a) == 'string' then
                                return a:toupper()
                            end
                        end)
                        :gsub('%.md', '')
                end, {}),

                i(1),
            }
        )
    ),
}

return snippets, autosnippets
