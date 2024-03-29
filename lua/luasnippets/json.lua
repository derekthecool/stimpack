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

    ms(
        {
            {
                trig = 'projector.json dotnet',
            },
        },
        fmt(
            [=[
        [
          {{
            "name": "run",
            "group": "dotnet",
            "type": "coreclr",
            "request": "launch",
            "cwd": "${{workspaceFolder}}",
            "stopAtEntry": true,
            "program": "${{workspaceFolder}}/{}",
            "dependencies": ["project.dotnet.build"]
          }},
          {{
            "name": "build",
            "group": "dotnet",
            "command": "dotnet build"
          }}
        ]
        ]=],
            {
                d(1, function(args, snip)
                    local nodes = {}

                    -- Add nodes for snippet
                    local choices = {}
                    local scandir = require('plenary.scandir')
                    local files = scandir.scan_dir('.', { respect_gitignore = true, search_pattern = '.*.dll' })

                    if not next(files) then
                        vim.notify(
                            'No .dll files found, try building the project first',
                            vim.log.levels.INFO,
                            { title = 'Stimpack Notification' }
                        )
                        return
                    end

                    V(files)

                    for _, file in pairs(files) do
                        local normalized_file = vim.fs.normalize(file)
                        if normalized_file then
                            normalized_file = normalized_file:gsub('%./', '')
                            table.insert(choices, t(normalized_file))
                        end
                    end

                    if next(choices) ~= nil then
                        table.insert(nodes, c(1, choices))

                        return sn(nil, nodes)
                    end
                end, {}),
            }
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
