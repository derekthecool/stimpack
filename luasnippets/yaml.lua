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
}

local autosnippets = {}

return snippets, autosnippets