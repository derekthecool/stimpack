---@diagnostic disable: undefined-global

local snippets = {

    -- {{{ XML snippets
    s(
        {
            trig = 'param',
            descr = 'XML parameter comment',
        },
        fmt([[<param name="{}">{}</param>]], {
            i(1),
            i(2),
        })
    ),

    s(
        {
            trig = 'exception',
            descr = 'XML exception comment',
        },
        fmt([[<exception cref="{}">{}</exception>]], {
            i(1, 'System.Exception'),
            i(2),
        })
    ),

    s(
        {
            trig = 'returns',
            descr = 'XML returns comment',
        },
        fmt([[<returns>{}</returns>]], {
            i(1),
        })
    ),

    s(
        {
            trig = 'code',
            descr = 'XML code comment',
        },
        fmt([[<code>{}</code>]], {
            i(1),
        })
    ),
    -- }}}
}

local autosnippets = {

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
    /// </summary>
    ]],
            {
                i(1),
            }
        )
    ),
    -- }}}
}

return snippets, autosnippets
