---@diagnostic disable: undefined-global

local auxiliary = require('luasnippets.functions.auxiliary')

local snippets = {
    ms(
        {
            { trig = 'read_all_stdin', snippetType = 'snippet' },
        },
        fmt(
            [[sys.stdin.read().splitlines()]],
            {}
        )
    ),
    s(
        'Plover dictionary',
        fmt(
            [[
            """
            Purpose: {}
            Required Plover Plugins:
                - plover-python-dictionary (https://pypi.org/project/plover-python-dictionary/)
            """

            import re
            import datetime
            import random

            LONGEST_KEY = {}

            def lookup(key):
                assert len(key) <= LONGEST_KEY

                {}

                raise KeyError

            def reverse_lookup(text):
                return []
        ]],
            {
                i(1),
                i(2, '2'),
                i(3),
            }
        )
    ),

    s(
        'file exists',
        fmt(
            [[
        os.path.isfile({})
        ]],
            {
                i(1, 'filename'),
            }
        ),
        {
            callbacks = {
                [-1] = {
                    -- Write needed using directives before expanding snippet so positions are not messed up
                    [events.pre_expand] = function()
                        auxiliary.insert_include_if_needed('os.path')
                    end,
                },
            },
        }
    ),

    s(
        'file read',
        fmt(
            [[
        {} = open("{}", "r")
        print({}.read())
        ]],
            {
                i(1, 'f'),
                i(2, 'filename'),
                rep(1),
            }
        )
    ),

    ms(
        {
            { trig = 'REGMATCH', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        re.match(r'{}', {})
        ]],
            {
                i(1, '.*'),
                i(2, 'input'),
            }
        )
    ),

    ms(
        {
            { trig = 'ALLREGMATCH', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        re.findall(r'{}', {})
        ]],
            {
                i(1, '.*'),
                i(2, 'input'),
            }
        )
    ),
}

local autosnippets = {
    s(
        'IF',
        fmt(
            [[
        if {}:
            {}
        ]],
            {
                i(1, 'True'),
                i(2),
            }
        )
    ),

    s(
        'ELSE',
        fmt(
            [[
        else:
            {}
        ]],
            {
                i(1),
            }
        )
    ),

    ms(
        {
            { trig = 'FOR', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        for {} in range({}):
            {}
        ]],
            {
                i(1, 'i'),
                i(2, 'source'),
                i(3),
            }
        )
    ),

    s(
        '"""',
        fmt(
            [[
        """
        {}
        """
        ]],
            {
                i(1),
            }
        )
    ),
}

return snippets, autosnippets
