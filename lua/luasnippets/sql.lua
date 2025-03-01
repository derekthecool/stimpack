---@diagnostic disable: undefined-global
local snippets = {
    ms(
        {
            { trig = 'case_mysql', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        CASE
            WHEN {Condition}
            THEN {Value}
            ELSE {OtherValue}
        END
        ]],
            {
                Condition = i(1, 'l.Value REGEXP "[0-9]{5,10}"'),
                Value = i(2, 'true'),
                OtherValue = i(3, 'false'),
            }
        )
    ),

    ms(
        {
            { trig = 'regex_replace_mysql', snippetType = 'snippet', condition = nil },
            { trig = 'regexp_replace_mysql', snippetType = 'snippet', condition = nil },
        },
        fmt([[REGEXP_REPLACE({Source}, '{Pattern}', '{Replacement}')]], {
            Source = i(1, 'Source'),
            Pattern = i(2, '[0-9]+_([abc]+)'),
            Replacement = i(3, '\\\\1'),
        })
    ),

    ms(
        {
            { trig = 'regex_mysql', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        REGEXP '{Pattern}'
        ]],
            {
                Pattern = i(1, '[0-9]{1,3},2025'),
            }
        )
    ),
    ms(
        {
            { trig = 'select', snippetType = 'snippet', condition = nil },
            { trig = 'select select', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
SELECT
    {TableAbbreviationRep}.{Property}
FROM
    {Table} {TableAbbreviation}
WHERE
    {TableAbbreviationRep} {Condition}
        ]],
            {
                TableAbbreviationRep = rep(2),
                Property = i(3, 'Property'),
                Table = i(1, 'TableName'),
                TableAbbreviation = i(2, 'TableName'),
                Condition = i(4, '= 1234'),
            }
        )
    ),
    ms(
        {
            { trig = 'wherein', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
        where {Something} in (
            {Stuff}
        )
        ]],
            {
                Something = i(1, 'Item'),
                Stuff = i(2),
            }
        )
    ),
    ms(
        {
            { trig = 'FIRST', snippetType = 'autosnippet', condition = conds.line_begin },
        },
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

    ms(
        {
            { trig = 'property', snippetType = 'snippet' },
            { trig = 'property property', snippetType = 'autosnippet' },
        },
        fmt([[{ColumnName} {Type} not null {DefaultValue}]], {
            ColumnName = i(1, 'Column1'),
            Type = c(2, {
                t('int'),
                t('smallint'),
                t('bigint'),
                t('numeric'),
                t('float'),
                t('double'),
                t('date'),
                t('datetime'),
                t('time'),
                t('timestamp'),
                t('char'),
                t('text'),
                t('binary'),
                t('varbinary'),
                t('boolean (mysql)'),
                t('bit (sql server)'),
                sn(
                    nil,
                    fmt([[varchar({amount})]], {
                        amount = i(1, '20'),
                    })
                ),
            }),
            DefaultValue = i(3, 'default NOW()'),
        })
    ),
}

local autosnippets = {
    -- I don't care about capitals anymore
    -- ms({ 'select' }, t('SELECT')),
    -- ms({ 'from' }, t('FROM')),
    -- ms({ 'where' }, t('WHERE')),
    -- ms({ 'and' }, t('AND')),
    -- ms({ 'or' }, t('OR')),
    -- ms({ 'not' }, t('NOT')),
    -- ms({ 'order by' }, t('ORDER BY')),
    -- ms({ 'group by' }, t('GROUP BY')),
    -- ms({ 'having' }, t('HAVING')),
    -- ms({ 'join' }, t('JOIN')),
    -- ms({ 'inner join' }, t('INNER JOIN')),
    -- ms({ 'left join' }, t('LEFT JOIN')),
    -- ms({ 'right join' }, t('RIGHT JOIN')),
    -- ms({ 'full join' }, t('FULL JOIN')),
    -- ms({ 'on' }, t('ON')),
    -- ms({ 'as' }, t('AS')),
    -- ms({ 'distinct' }, t('DISTINCT')),
    -- ms({ 'union' }, t('UNION')),
    -- ms({ 'insert' }, t('INSERT')),
    -- ms({ 'into' }, t('INTO')),
    -- ms({ 'values' }, t('VALUES')),
    -- ms({ 'update' }, t('UPDATE')),
    -- ms({ 'set' }, t('SET')),
    -- ms({ 'delete' }, t('DELETE')),
    -- ms({ 'create' }, t('CREATE')),
    -- ms({ 'table' }, t('TABLE')),
    -- ms({ 'view' }, t('VIEW')),
    -- ms({ 'index' }, t('INDEX')),
    -- ms({ 'procedure' }, t('PROCEDURE')),
    -- ms({ 'function' }, t('FUNCTION')),
    -- ms({ 'trigger' }, t('TRIGGER')),
    -- ms({ 'constraint' }, t('CONSTRAINT')),
    -- ms({ 'primary key' }, t('PRIMARY KEY')),
    -- ms({ 'foreign key' }, t('FOREIGN KEY')),
    -- ms({ 'default' }, t('DEFAULT')),
    -- ms({ 'check' }, t('CHECK')),
    -- ms({ 'unique' }, t('UNIQUE')),
}

return snippets, autosnippets
