---@diagnostic disable: undefined-global
local snippets = {
    s(
        'mysql database',
        fmt(
            [[
  mysql:
    image: mysql
    command: --default-authentication-plugin=mysql_native_password
    restart: always
    ports:
      # Open this port to access using local mysql client
      - {}:3306
    environment:
      MYSQL_ROOT_PASSWORD: password
    volumes:
      # Initialize database with .sql, and .sh files in this directory
      - ./{}:/docker-entrypoint-initdb.d
        ]],
            {
                i(1, 'Local port for sql access'),
                i(2, 'LocalDirectoryForSqlDatabaseInit'),
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
