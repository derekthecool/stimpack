---@diagnostic disable: undefined-global
local snippets = {
    s(
        'init',
        fmt(
            [[
        create database test;
        use test;

        CREATE TABLE testTable
        (
        id INTEGER AUTO_INCREMENT,
        name TEXT,
        PRIMARY KEY (id)
        ) COMMENT='this is my test table';

        INSERT INTO testTable (id, name) VALUES ('1', 'MySQL test data 1');
        ]],
            {}
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
