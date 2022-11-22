---@diagnostic disable: undefined-global
local snippets = {}

local autosnippets = {
    s(
        'PRINT',
        fmt([[printfn "{}" {}]], {
            i(1, '%d'),
            i(2, 'variable'),
        })
    ),
}

return snippets, autosnippets
