---@diagnostic disable: undefined-global, missing-parameter

local shareable = require('luasnippets.functions.shareable_snippets')
local auxiliary = require('luasnippets.functions.auxiliary')

---@param index number
---@param values table
local function environment_item(index, values)
    return sn(
        index,
        fmt(
            [[
    {EnvironmentItems}
    ]],
            {
                EnvironmentItems = d(1, function(args, snip)
                    local nodes = {}

                    -- Add nodes for snippet
                    for _, value in pairs(values) do
                        local parts = vim.split(value, '=')
                        table.insert(
                            nodes,
                            sn(
                                1,
                                fmt([[- {EnvironmentVariableName}={EnvironmentVariableValue}]], {
                                    EnvironmentVariableName = t(parts[1]),
                                    EnvironmentVariableValue = i(1, parts[2]),
                                })
                            )
                        )
                    end

                    return sn(nil, c(1, nodes))
                end, {}),
            }
        )
    )
end

---@param index number
---@param ports table|nil
local function ports(index, ports)
    return sn(
        index,
        fmt(
            [[
    ports:
      {PortList}
    ]],
            {
                PortList = d(1, function(args, snip)
                    local nodes = {}

                    -- -- Add nodes for snippet
                    if not ports then
                        -- table.insert(nodes, i(1, '80:8080'))
                        -- table.insert(nodes, i(1, '80:8080'))
                        table.insert(
                            nodes,
                            sn(
                                1,
                                fmt(
                                    [[
                                    - {PortItem}
                                    ]],
                                    {
                                        PortItem = i(1, '8080:80'),
                                    }
                                )
                            )
                        )
                    else
                        for port_index, port in pairs(ports) do
                            table.insert(
                                nodes,
                                sn(
                                    port_index,
                                    fmt(
                                        [[
                                    - {PortItem}
                                    ]],
                                        {
                                            PortItem = i(1, string.format('%s', port)),
                                        }
                                    )
                                )
                            )
                        end
                    end

                    return sn(nil, nodes)
                end, { 1 }),
            }
        )
    )
end

local snippets = {
    ms(
        {
            { trig = 'ngrok', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
  ngrok:
    image: ngrok/ngrok:latest
    command:
      # Use http for a web api
      - 'http'
        # Send logs to stdout to make viewable via docker/podman logs command
        # By default there is no logging to files or stdout
      - '--log=stdout'
      - 'http://twilio_voip_api:8080'
    # Put api key NGROK_AUTHTOKEN in .env file
    env_file: .env
    ports:
      # Access to a nice web portal which has 2 nice features
      # 1. You can get your random public URL here, also available in logs
      # 2. It also somes with a nice request viewer
      - 4040:4040
        ]],
            {}
        )
    ),
    ms(
        {
            { trig = 'Dockerfile', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[dockerfile: {Path}]], {

            Path = auxiliary.scan_files(1, 'Dockerfile'),
        })
    ),

    ms(
        {
            { trig = 'ports', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[{Ports}]], {
            Ports = ports(1),
        })
    ),

    ms(
        {
            { trig = 'mariadb', snippetType = 'snippet', condition = conds.line_begin },
            { trig = 'mysql', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
  {Type}:
    image: {rep_type}:latest
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: {root_password}
      MYSQL_DATABASE: {database}
      MYSQL_USER: {user}
      MYSQL_PASSWORD: {password}
    ports:
      - "{local_port}:3306"
    volumes:
      - {volume}:/var/lib/mysql
      - ./DatabaseInitScripts/:/docker-entrypoint-initdb.d/

volumes:
    {volume_rep}:
        ]],
            {
                Type = c(1, {
                    t('mariadb'),
                    t('mysql'),
                }),
                rep_type = rep(1),
                root_password = i(2, 'Password1234'),
                database = i(3, 'Awesome'),
                user = i(4, 'me'),
                password = i(5, 'MyPassword1234'),
                local_port = i(6, '3306'),
                volume = i(7, 'persistantVolumeName'),
                volume_rep = rep(7),
            }
        )
    ),

    ms(
        {
            { trig = 'posgresql', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
  postgres:
    image: postgres:latest
    environment:
      POSTGRES_DB: {database}
      POSTGRES_USER: {user}
      POSTGRES_PASSWORD: {password}
    ports:
      - "{localPort}:5432"
    volumes:
      - {volume}:/var/lib/postgresql/data

   volumes:
     {rep_volume}:
        ]],
            {
                database = i(1, 'MyDatabase'),
                user = i(2, 'user'),
                password = i(3, 'password'),
                localPort = i(4, '5432'),
                volume = i(5, 'posgresql_volume'),
                rep_volume = rep(5),
            }
        )
    ),

    ms(
        {
            { trig = 'sql server', snippetType = 'snippet', condition = conds.line_begin },
            { trig = 'sqlserver', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
  sqlserver:
    image: mcr.microsoft.com/mssql/server:2019-latest
    environment:
      SA_PASSWORD: "{Password}"
      ACCEPT_EULA: "Y"
    ports:
      - "{localPort}:1433"
    volumes:
      - {volume}:/var/opt/mssql

  volumes:
    {volume_rep}:
        ]],
            {
                Password = i(1, 'Password123'),
                localPort = i(2, '1433'),
                volume = i(3, 'sqlserver_data'),
                volume_rep = rep(3),
            }
        )
    ),

    s(
        'compose',
        fmt(
            [[
        services:
          {}:
            {}
            ports:
              - {}
        ]],
            {
                i(1, 'container_name'),
                c(2, {
                    sn(
                        nil,
                        fmt([[image: "{}"]], {
                            i(1, 'bash/bash:latest'),
                        })
                    ),
                    t('build: .'),
                }),
                i(3, '8080:8080'),
            }
        )
    ),

    ms(
        {
            { trig = 'profiles', snippetType = 'snippet' },
        },
        fmt(
            [[
        profiles: ["{}"]
        ]],
            {
                i(1, 'debug'),
            }
        )
    ),

    ms(
        {
            { trig = 'environment', snippetType = 'snippet' },
        },
        fmt(
            [[
        environment:
          - {}
        ]],
            {
                i(1, 'DEBUG=1'),
            }
        )
    ),

    ms(
        {
            { trig = 'environment environment', snippetType = 'autosnippet', condition = nil },
            { trig = 'environment_examples', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        {EnvironmentCommonOptions}
        ]],
            {
                EnvironmentCommonOptions = environment_item(1, {
                    'ASPNETCORE_ENVIRONMENT=Development',
                    'ASPNETCORE_ENVIRONMENT=Production',
                    'DOTNET_ENABLE_DIAGNOSTICS=0',
                }),
            }
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
