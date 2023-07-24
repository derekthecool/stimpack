---@diagnostic disable: undefined-global
local snippets = {
    s(
        'projector.json',
        fmt(
            [=[
        // Projector.json neovim json configuration
        // https://github.com/kndndrj/nvim-projector/blob/master/examples/projector.json
        [
          {{
            "name": "{}",
            "group": "{}",
            "command": "{}",
            "dependencies": [
              // <scope>.<group>.<name>
              // "project.go.Generate Stuff"
            ]
          }},
        ]
        ]=],
            {
                i(1, 'ProjectName'),
                i(2, 'GroupName'),
                i(3, 'dotnet build'),
            }
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
