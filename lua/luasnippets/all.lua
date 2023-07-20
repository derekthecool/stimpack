---@diagnostic disable: undefined-global
local snippets = {}

local autosnippets = {
    s(
        'TODO',
        fmt(
            [[
        TODO: {}, {}
        ]],
            {
                f(function(args, snip)
                    return os.date('%c')
                end, {}),

                i(1, 'Do something here later'),
            }
        )
    ),
}

return snippets, autosnippets
