---@diagnostic disable: undefined-global
local snippets = {
    ms(
        {
            { trig = 'FIRST', snippetType = 'autosnippet' },
        },
        fmt(
            [[
         {{ pkgs ? import <nixpkgs> {{ system = "x86_64-linux";}}
         }}:
         {}
         ]],
            {
                i(1),
            }
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
