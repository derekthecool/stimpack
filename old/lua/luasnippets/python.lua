local auxiliary = require('luasnippets.functions.auxiliary')
local treesitter_postfix = require('luasnip.extras.treesitter_postfix').treesitter_postfix
local postfix_builtin = require('luasnip.extras.treesitter_postfix').builtin

local function lambda(index)
    return sn(
        index,
        fmt([[lambda {variables} : {mapping}]], {
            variables = i(1, 'x'),
            mapping = i(2, 'x * x'),
        })
    )
end

local snippets = {
    postfix('.br', {
        l('[' .. l.POSTFIX_MATCH .. ']'),
    }),

    -- (assignment left: (identifier) @variable)

    -- treesitter_postfix({
    --     trig = 'var var',
    --     snippetType = 'autosnippet',
    --     name = 'log',
    --     dscr = 'Wrap a function call like map, filter, etc.',
    --     reparseBuffer = 'live',
    --     matchTSNode = postfix_builtin.tsnode_matcher.find_topmost_types({
    --         '(assignment left: (identifier) @variable)',
    --     }),
    -- }, fmt('console.log({})', { l(l.LS_TSMATCH) })),

    treesitter_postfix(
        {
            matchTSNode = {
                query = [[(assignment left: (identifier) @variable)]],
                query_lang = 'python',
            },
            trig = '.var',
            -- snippetType = 'autosnippet',
        },

        fmt([[{}]], {
            -- l(l.LS_TSMATCH),
            l('test' .. (l.LS_TSCAPTURE_VARIABLE or 'empty')),
        })
    ),

    treesitter_postfix(
        {
            trig = '.map',
            snippetType = 'autosnippet',
            name = 'log',
            dscr = 'Wrap a function call like map, filter, etc.',
            reparseBuffer = 'live',
            matchTSNode = postfix_builtin.tsnode_matcher.find_topmost_types({
                'call',
            }),
        },
        fmt('map({lambda_function}, {collection})', {
            lambda_function = lambda(1),
            collection = l(l.LS_TSMATCH),
        })
    ),

    treesitter_postfix(
        {
            trig = '.filter',
            snippetType = 'autosnippet',
            name = 'fast filter',
            dscr = 'Wrap a function call like map, filter, etc.',
            reparseBuffer = 'live',
            matchTSNode = postfix_builtin.tsnode_matcher.find_topmost_types({
                'call',
            }),
        },
        fmt('filter({lambda_function}, {collection})', {
            lambda_function = lambda(1),
            collection = l(l.LS_TSMATCH),
        })
    ),

    treesitter_postfix(
        {
            trig = 'lambda wrap',
            snippetType = 'autosnippet',
            name = 'fast lambda wrap',
            dscr = 'Wrap a function call like map, filter, etc.',
            reparseBuffer = 'live',
            matchTSNode = postfix_builtin.tsnode_matcher.find_topmost_types({
                'call',
            }),
        },
        fmt('{FunctionName}({lambda_function}, {collection})', {
            FunctionName = c(1, {
                t('map'),
                t('filter'),
                i(1, 'custom'),
            }),

            lambda_function = lambda(1),
            collection = l(l.LS_TSMATCH),
        })
    ),

    treesitter_postfix(
        {
            trig = 'wrap wrap',
            snippetType = 'autosnippet',
            name = 'super wrapper',
            dscr = 'Wrap any function call',
            reparseBuffer = 'live',
            matchTSNode = postfix_builtin.tsnode_matcher.find_topmost_types({
                'call',
            }),
        },
        fmt('{NewFunction}({collection})', {
            NewFunction = i(1, 'list'),
            collection = l(l.LS_TSMATCH),
        })
    ),

    ms(
        {
            { trig = 'map', snippetType = 'snippet', condition = nil },
        },
        fmt([[map({})]], {
            i(1),
        })
    ),

    ms(
        {
            { trig = 'filter', snippetType = 'snippet', condition = nil },
        },
        fmt([[filter({})]], {
            i(1),
        })
    ),

    ms(
        {
            { trig = 'range',       snippetType = 'snippet',     condition = nil },
            { trig = 'range range', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[range({})]], {
            i(1, '100'),
        })
    ),

    treesitter_postfix(
        {
            matchTSNode = {
                query = [[
            (integer) @number
        ]],
                query_lang = 'python',
            },
            trig = '.pp',
        },
        fmt([[NumberThing = {NumberThing}]], {
            NumberThing = l(l.LS_TSCAPTURE_NUMBER),
        })
    ),

    treesitter_postfix({
        trig = '.mv',
        matchTSNode = {
            query = [[((call) @function_call)]],
            query_lang = 'python',
        },
    }, {
        f(function(taco, parent)
            -- vim.print(taco)
            vim.print(parent.snippet.env)
            vim.print(parent.snippet.env.LS_TSMATCH)
            if taco.env then
                vim.print('Taco has env')
            end
            if parent.env then
                vim.print('parent.env has env')
                vim.print(type(parent.env.LS_TSDATA))
                V('function_call', parent.env.LS_TSCAPTURE_FUNCTION_CALL)
            end

            -- local node_content = table.concat(parent.snippet.env.LS_TSMATCH, '\n')
            -- local replaced_content = ('std::move(%s)'):format(node_content)
            -- return vim.split(ret_str, '\n', { trimempty = false })
        end),
    }),

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
        fmt([[{lambda_function}]], {
            lambda_function = lambda(1),
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
        { trig = 'read line',      snippetType = 'autosnippet', condition = nil },
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
            { trig = 'ERRORPRINT', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[print({}, file=sys.stderr, flush=True)]], {
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
