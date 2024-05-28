---@diagnostic disable: undefined-global
local snippets = {

    ms(
        {
            { trig = 'mariadb', snippetType = 'snippet', condition = conds.line_begin },
            { trig = 'mysql',   snippetType = 'snippet', condition = conds.line_begin },
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
            { trig = 'sqlserver',  snippetType = 'snippet', condition = conds.line_begin },
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
}

local autosnippets = {
    s(
        'FIRST',
        fmt([[{}]], {
            c(1, {
                sn(
                    nil,
                    fmt([[{}: {}]], {
                        i(1, 'item'),
                        i(2, 'value'),
                    })
                ),

                sn(
                    nil,
                    fmt(
                        [[
                {}:
                  - {}
                ]],
                        {
                            i(1, 'item'),
                            i(2, 'value'),
                        }
                    )
                ),
            }),
        })
    ),
}

return snippets, autosnippets
