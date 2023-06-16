---@diagnostic disable: undefined-global
local snippets = {}

local autosnippets = {
    -- Filetypes like this only need a single snippet
    -- The basic template starter point
    s(
        'FIRST',
        fmt(
            [[
        column_width = 120
        line_endings = "Unix"
        indent_type = "Spaces"
        indent_width = 4
        quote_style = "ForceSingle"
        call_parentheses = "Always"
        ]],
            {}
        )
    ),
}

return snippets, autosnippets
