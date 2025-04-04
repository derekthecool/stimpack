---@diagnostic disable: undefined-global
local snippets = {
    ms(
        {
            { trig = 'subquery', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        select * from {OuterTable}
        where {OuterTableProperty} in(
            {InnerTableQuery}
        )
        ]],
            {
                OuterTable = i(1, 'OuterTable'),
                OuterTableProperty = i(2, 'OuterTableProperty'),
                InnerTableQuery = i(3, 'select * from InnerTable'),
            }
        )
    ),
    ms(
        {
            { trig = 'alter', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        ALTER TABLE {Table}
        ADD CONSTRAINT {NameForRule} UNIQUE ({UniqueColumns});
        ]],
            {
                Table = i(1, 'Table'),
                NameForRule = i(2, 'name_for_rule'),
                UniqueColumns = i(3, 'UniqueByColumn1,AlsoByColumn3'),
            }
        )
    ),
    ms({
        { trig = 'and and', snippetType = 'autosnippet', condition = nil },
    }, fmt([[AND]], {})),
    ms(
        {
            { trig = 'substring', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        substring({Column}, {Start}, {End}) as {SubstringName}
        ]],
            {
                Column = i(1, 'ColumnName'),
                Start = i(2, 'StartIndex'),
                End = i(3, 'EndIndex'),
                SubstringName = i(4, 'SubstringName'),
            }
        )
    ),
    ms(
        {
            { trig = 'with', snippetType = 'snippet', condition = nil },
            { trig = 'cte', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        with {CTEName} as (
            select
                {Select},
                ROW_NUMBER() OVER (PARTITION BY firmwareVersion ORDER BY IMEI) AS rn
            from {Table}
        )
        ]],
            {
                CTEName = i(1, 'CTEName'),
                Select = i(2, 'Column1'),
                Table = i(3, 'Table'),
            }
        )
    ),

    ms(
        {
            { trig = 'update', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        update {Table}
        set {Column}
        where {Where}
        ]],
            {
                Table = i(1, 'Table'),
                Column = i(2, 'Column1 = 5'),
                Where = i(3, 'Id = 1'),
            }
        )
    ),

    ms(
        {
            { trig = 'row_number', snippetType = 'snippet', condition = nil },
            { trig = 'row number', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
    ROW_NUMBER() OVER(PARTITION BY {Column} ORDER BY {OrderByColumn}) AS row_num
    ]],
            {
                Column = i(1, 'PartitionByColumn'),
                OrderByColumn = i(2, 'OrderByColumn'),
            }
        )
    ),

    ms(
        {
            { trig = 'like like', snippetType = 'autosnippet', condition = nil },
            { trig = 'like', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        LIKE '{Match}'
        ]],
            {
                Match = i(1, '%text%'),
            }
        )
    ),

    ms(
        {
            { trig = 'insert', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        INSERT INTO {Table} ({Columns})
        VALUES ({Values})
        ]],
            {
                Table = i(1, 'TableName'),
                Columns = i(2, 'Column1,Column2,Column3'),
                Values = i(3, 'Value1,Value2,Value3'),
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
