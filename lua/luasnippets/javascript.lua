---@diagnostic disable: undefined-global
local snippets = {
    ms(
        {
            { trig = 'console.log', snippetType = 'snippet' },
            { trig = 'PRINT', snippetType = 'autosnippet' },
            { trig = 'console.error', snippetType = 'snippet' },
            { trig = 'ERRORPRINT', snippetType = 'autosnippet' },
        },
        fmt([[console.{}({})]], {
            f(function(args, snip)
                if snip.trigger == 'ERRORPRINT' or snip.trigger == 'console.error' then
                    return 'error'
                else
                    return 'log'
                end
            end, {}),

            i(1),
        })
    ),

    ms({
        { trig = 'readline', snippetType = 'snippet' },
    }, fmt([[readline()]], {})),
}

local autosnippets = {}

return snippets, autosnippets
