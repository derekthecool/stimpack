---@diagnostic disable: undefined-global

local auxiliary = require('luasnippets.functions.auxiliary')

local snippets = {

    ms(
        {
            { trig = 'SHA256', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
import hashlib


def calculate_sha256(data):
    # Convert data to bytes if it’s not already
    if isinstance(data, str):
        data = data.encode()
    # Calculate SHA-256 hash
    sha256_hash = hashlib.sha256(data).hexdigest()
    return sha256_hash
        ]],
            {}
        )
    ),

    ms(
        {
            { trig = 'LAMBDA', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[lambda {variables} : {mapping}]], {
            variables = i(1, 'x'),
            mapping = i(2, 'x * x'),
        })
    ),

    ms({
        { trig = 'input input', snippetType = 'autosnippet', condition = nil },
    }, fmt([[input()]], {})),
    postfix({ trig = '_int', match_pattern = '[%w%.%_%-()]+$' }, {
        f(function(_, parent)
            return string.format('int(%s)', parent.snippet.env.POSTFIX_MATCH)
        end, {}),
    }),
    ms(
        {
            { trig = 'FUNCTION', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        def {FunctionName}():
            {Code}
        ]],
            {
                FunctionName = i(1, 'MyFunction'),
                Code = i(2),
            }
        )
    ),
    ms(
        {
            { trig = 'mqtt', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
import paho.mqtt.client as mqtt
import time

client = mqtt.Client()
client.connect("192.168.100.35", 1883, 60)
for i in range(500):
    client.publish("TMAE94/sub", bytes.fromhex("220708dd0110107801"))
    time.sleep(35)
client.disconnect()
        ]],
            {}
        )
    ),
    ms({
        { trig = 'read_all_stdin', snippetType = 'snippet' },
    }, fmt([[sys.stdin.read().splitlines()]], {})),
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
            { trig = 'PRINT', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt([[print({})]], {
            i(1),
        })
    ),

    ms(
        {
            { trig = 'string format', snippetType = 'autosnippet', condition = nil },
            { trig = 'format string', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[f'{}']], {
            i(1),
        })
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
