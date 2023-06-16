---@diagnostic disable: undefined-global
local snippets = {
    s(
        'projector.json',
        fmt(
            [=[
        // Projector.json neovim json configuration
        // https://github.com/kndndrj/nvim-projector/blob/master/examples/projector.json
        [

        ]
        ]=],
            {}
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
