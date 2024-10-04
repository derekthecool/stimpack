-- This file is for snippets that can be shared easily between languages.
-- Luasnip provides the option to extend filetypes, however doing this
-- approach is for fine grained control to avoid repetition and limit scope.
local shareable = {}

local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require('luasnip.util.events')
local ai = require('luasnip.nodes.absolute_indexer')
local extras = require('luasnip.extras')
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local conds = require('luasnip.extras.expand_conditions')
local postfix = require('luasnip.extras.postfix').postfix
local types = require('luasnip.util.types')
local parse = require('luasnip.util.parser').parse_snippet
local ms = ls.multi_snippet
local k = require('luasnip.nodes.key_indexer').new_key

-- Start dynamic_node with user input
-- https://github.com/L3MON4D3/LuaSnip/wiki/Misc#dynamicnode-with-user-input
local ls = require('luasnip')
local util = require('luasnip.util.util')
local node_util = require('luasnip.nodes.util')

-- For dart
shareable.lambda = function(index)
    return sn(
        index,
        fmt([[({}) {}]], {
            i(1),
            c(2, {
                sn(
                    nil,
                    fmt([[=> {}]], {
                        i(1),
                    })
                ),

                sn(
                    nil,
                    fmt(
                        [[
                        {{
                          {}
                        }}
                        ]],
                        {
                            i(1),
                        }
                    )
                ),
            }),
        })
    )
end

shareable.for_loop_c_style = ms(
    {
        { trig = 'FOR', snippetType = 'autosnippet' },
    },
    fmt(
        [[
        for(int i = {}; i < {}; i{})
        {{
            {}
        }}
        ]],
        {
            i(1, '0'),
            i(2, '10'),
            c(3, {
                t('++'),
                t('--'),
            }),
            i(4),
        }
    )
)

shareable.if_statement_c_style = ms(
    {
        { trig = 'IF', snippetType = 'autosnippet' },
        { trig = 'ELS_EI_F', snippetType = 'autosnippet' },
    },
    fmt(
        [[
        {}if({})
        {{
            {}
        }}
        ]],
        {
            f(function(args, snip)
                if snip.trigger == 'ELS_EI_F' then
                    return 'else '
                end
            end, {}),
            i(1),
            i(2),
        }
    )
)

shareable.else_statement_c_style = ms(
    {
        { trig = 'ELSE', snippetType = 'autosnippet' },
    },
    fmt(
        [[
        else
        {{
            {}
        }}
        ]],
        {
            i(1),
        }
    )
)

shareable.while_loop_c_style = ms(
    {
        { trig = 'WHILE', snippetType = 'autosnippet' },
    },
    fmt(
        [[
        while({})
        {{
            {}
        }}
        ]],
        {
            i(1, 'true'),
            i(2),
        }
    )
)

shareable.function_c_style = ms(
    {
        { trig = 'FUNCTION', snippetType = 'autosnippet' },
    },
    fmt(
        [[
            {} {}({})
            {{
                {}
            }}
            ]],
        {
            i(1, 'int'),
            i(2, 'MyFunction'),
            i(3),
            i(4),
        }
    )
)

shareable.clang_brief_function_documentation = function(index)
    return sn(
        index,
        fmt(
            [[
        /*
        @brief {Details}

        @param {ParamName} {ParamNotes}

        @returns <{ReturnType}> {ReturnNotes}
        */
        ]],
            {
                Details = i(1, 'this function does ....'),
                ParamName = i(2, 'param1'),
                ParamNotes = i(3, 'param 1 does this ....'),
                ReturnType = i(4, 'int'),
                ReturnNotes = i(5, 'Details about return type ....'),
            }
        )
    )
end

return shareable
