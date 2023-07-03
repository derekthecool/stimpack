---@diagnostic disable: undefined-global
local snippets = {
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
        import os.path
        os.path.isfile({})
        ]],
            {
                i(1),
            }
        )
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