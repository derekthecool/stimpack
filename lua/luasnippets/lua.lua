---@diagnostic disable: undefined-global, missing-parameter

local my_treesitter_functions = require('stimpack.my-treesitter-functions')
local shiftwidth = vim.bo.shiftwidth
local shiftwidth_match_string = string.rep(' ', shiftwidth)
local auxiliary = require('luasnippets.functions.auxiliary')
local scan = require('plenary.scandir')
local fun = require('luafun.fun')
local conds_expand = require('luasnip.extras.conditions.expand')
local treesitter_postfix = require('luasnip.extras.treesitter_postfix').treesitter_postfix

local function column_count_from_string(descr)
    -- this won't work for all cases, but it's simple to improve
    -- (feel free to do so! :D )
    return #(descr:gsub('[^clm]', ''))
end

-- function for the dynamicNode.
local tab = function(args, snip)
    local cols = column_count_from_string(args[1][1])
    -- snip.rows will not be set by default, so handle that case.
    -- it's also the value set by the functions called from dynamic_node_external_update().
    if not snip.rows then
        snip.rows = 1
    end
    local nodes = {}
    -- keep track of which insert-index we're at.
    local ins_indx = 1
    for j = 1, snip.rows do
        -- use restoreNode to not lose content when updating.
        table.insert(nodes, r(ins_indx, tostring(j) .. 'x1', i(1)))
        ins_indx = ins_indx + 1
        for k = 2, cols do
            table.insert(nodes, t(' & '))
            table.insert(nodes, r(ins_indx, tostring(j) .. 'x' .. tostring(k), i(1)))
            ins_indx = ins_indx + 1
        end
        table.insert(nodes, t({ '\\\\', '' }))
    end
    -- fix last node.
    nodes[#nodes] = t('')
    return sn(nil, nodes)
end

-- 'recursive' dynamic snippet. Expands to some text followed by itself.
local rec_ls = function()
    return sn(
        2,
        c(1, {
            -- Order is important, sn(...) first would cause infinite loop of expansion.
            t(''),
            sn(nil, { i(1), d(2, rec_ls, {}) }),
        })
    )
end

local snippets = {
    treesitter_postfix(
        {
            matchTSNode = {
                query = [[
            (function_declaration
              name: (identifier) @fname
              parameters: (parameters) @params
              body: (block) @body
            ) @prefix
        ]],
                query_lang = 'lua',
            },
            trig = '.fn',
        },
        fmt(
            [[
    local {} = function{}
        {}
    end
]],
            {
                l(l.LS_TSCAPTURE_FNAME),
                l(l.LS_TSCAPTURE_PARAMS),
                l(l.LS_TSCAPTURE_BODY),
            }
        )
    ),

    ms(
        {
            { trig = 'trigger', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [=[
-- thank you https://www.lua.org/pil/19.3.html
function pairsByKeys(t, f)
    local a = {{}}
    for n in pairs(t) do
        table.insert(a, n)
    end
    table.sort(a, f)
    local i = 0 -- iterator variable
    local iter = function() -- iterator function
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
end
        ]=],
            {}
        )
    ),
    ms(
        {
            { trig = 'to_binary_string', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
function to_binary(n)
    if n == 0 then
        return '0'
    end
    local t = {{}}
    while n > 0 do
        table.insert(t, 1, n % 2)
        n = math.floor(n / 2)
    end
    return table.concat(t)
end
        ]],
            {}
        )
    ),

    ms(
        {
            { trig = [[\\]],          snippetType = 'snippet', condition = nil },
            { trig = 'regex_pattern', snippetType = 'snippet', condition = nil },
        },
        fmt([[{Pattern}]], {
            Pattern = c(1, {
                -- all letters
                t('%a'),
                -- control
                t('%c'),
                -- numbers
                t('%d'),
                -- all printable except space
                t('%g'),
                -- lowercase
                t('%l'),
                -- uppercase
                t('%u'),
                -- alphanumeric
                t('%w'),
                -- hexadecimal digits
                t('%x'),
            }),
        })
    ),
    ms(
        {
            { trig = 'table.concat', snippetType = 'autosnippet', condition = nil },
            { trig = 'table concat', snippetType = 'autosnippet', condition = nil },
            { trig = 'table.concat', snippetType = 'snippet',     condition = nil },
        },
        fmt([[table.concat({Table}, {Separator}]], {
            Table = i(1, 'table'),
            Separator = i(2, ' '),
        })
    ),
    ms(
        {
            { trig = 'table.insert', snippetType = 'autosnippet', condition = nil },
            { trig = 'table insert', snippetType = 'autosnippet', condition = nil },
            { trig = 'table insert', snippetType = 'snippet',     condition = nil },
        },
        fmt([[{Choice}]], {
            Choice = c(1, {
                sn(
                    nil,
                    fmt([[table.insert({Table}, {Value})]], {
                        Table = r(1, 'table'),
                        Value = r(2, 'value'),
                    })
                ),
                sn(
                    nil,
                    fmt([[table.insert({Table}, {Position}, {Value})]], {
                        Table = r(1, 'table'),
                        Position = i(2, 'index'),
                        Value = r(3, 'value'),
                    })
                ),
                sn(
                    nil,
                    fmt([[{Table}[#{TableRep}+1] = {Value}]], {
                        Table = r(1, 'table'),
                        TableRep = rep(1),
                        Value = r(2, 'value'),
                    })
                ),
            }),
        }),
        -- TODO: (Derek Lomax) 12/6/2024 3:12:40 PM, these stored values are not working
        {
            stored = {
                ['Table'] = i(1, 'table'),
                ['Value'] = i(2, 'value'),
            },
        }
    ),
    ms(
        {
            { trig = 'stylua_ignore', snippetType = 'snippet', condition = nil },
        },
        fmt([[-- stylua: ignore {Choice}]], {
            Choice = c(1, {
                t('start'),
                t('end'),
            }),
        })
    ),
    ms(
        {
            { trig = ':match', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[:match('{Pattern}')]], {
            Pattern = i(1, '.*'),
        })
    ),

    ms(
        {
            { trig = 'require require', snippetType = 'autosnippet', condition = conds.line_begin },
            { trig = 'require',         snippetType = 'snippet',     condition = conds.line_begin },
        },
        fmt([[require('{Module}')]], {
            Module = i(1),
        })
    ),

    ms(
        {
            { trig = 'type type', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[type({Item})]], {
            Item = i(1, 'variable'),
        })
    ),

    ms(
        {
            'format',
            {
                trig = 'string format',
                snippetType = 'autosnippet',
                condition = function(line_to_cursor)
                    return line_to_cursor:match([[']]) == nil
                end,
            },
        },
        fmt(
            [[
        string.format("{}"{})
        ]],
            {
                i(1),
                auxiliary.printf_style_dynamic_formatter(2, 1),
            }
        )
    ),

    s(
        'require',
        fmt(
            [[
        local {} = require('{}')
        ]],

            {
                l(l._1:gsub('.*%.(%w+)', '%1'), { 1 }),
                i(1, 'initial text'),
            }
        )
    ),

    -- File snippets

    s(
        'file exists',
        fmt(
            [[
        function FileExists(filename)
            local f = io.open(filename, 'r')
            if f ~= nil then
                io.close(f)
                return true
            else
                return false
            end
        end
        ]],
            {}
        )
    ),

    s(
        'module',
        fmt(
            [[
        local {} = {{}}

        {}

        return {}
        ]],
            {
                i(1, 'M'),
                d(2, function(args, snip)
                    local module_name = args[1][1]
                    local nodes = {}

                    if not snip.rows then
                        snip.rows = 1
                    end

                    local insert_index = 1
                    local module_item_count = 1
                    for row = 1, snip.rows do
                        if row == 1 then
                            table.insert(nodes, t({ '' }))
                        else
                            table.insert(nodes, t({ '', '', '' }))
                        end

                        table.insert(nodes, t({ string.format('%s.', module_name) }))
                        local restore_node_1 = string.format('module_item_%d', module_item_count)
                        table.insert(nodes, r(insert_index, restore_node_1, i(1, restore_node_1)))
                        insert_index = insert_index + 1
                        module_item_count = module_item_count + 1
                        --
                        -- local restore_node_2 = string.format('module_item_content_%d', insert_index)
                        -- table.insert(nodes, r(insert_index, restore_node_2, i(1, 'true')))
                        -- insert_index = insert_index + 1
                    end

                    return sn(nil, nodes)
                end, { 1 }, {
                    user_args = {
                        -- Pass the functions used to manually update the dynamicNode as user args.
                        -- The n-th of these functions will be called by dynamic_node_external_update(n).
                        -- These functions are pretty simple, there's probably some cool stuff one could do
                        -- with `ui.input`
                        function(snip)
                            -- V('Increment module item')
                            snip.rows = snip.rows + 1
                        end,
                        -- don't drop below one.
                        function(snip)
                            -- V('Decrement module item')
                            snip.rows = math.max(snip.rows - 1, 1)
                        end,
                    },
                }),
                rep(1),
            }
        )
    ),

    s(
        'test restore',
        fmt(
            [[
        {}
        ]],
            {

                c(1, {
                    r(1, 'unique_key1', i(1)),
                    r(1, 'unique_key2', i(1)),
                }),
            }
        )
    ),

    s(
        'metaset',
        fmt([[setmetatable({}, {})]], {
            i(1, 'tableToSetMetaTableOn'),
            i(2, 'metaTable'),
        })
    ),

    ms(
        {
            {
                trig = 'io.lines',
                snippetType = 'snippet',
            },
        },
        fmt(
            [[
        for line in io.lines() do
            {}
        end
        ]],
            {
                i(1),
            }
        )
    ),

    ms(
        {
            {
                trig = 'gsub table extract',
                snippetType = 'snippet',
            },
        },
        fmt(
            [[
        {}={{}}
        {}:gsub('{}, function(a)
            table.insert({}, a)
        end)
        ]],
            {
                i(3, 'default'),
                c(1, {
                    t('io.read()'),
                    i(1, 'my_string'),
                }),
                i(2, '%w+'),
                rep(3),
            }
        )
    ),

    ms(
        {
            { trig = ':gsub', snippetType = 'autosnippet', wordTrig = false },
        },
        fmt(
            [[
        :gsub('{}', '{}')
        ]],
            {
                i(1, '%w+'),
                i(2, ''),
            }
        )
    ),

    ms(
        {
            { trig = 'read line', snippetType = 'autosnippet' },
            { trig = 'io.read()', snippetType = 'snippet' },
        },
        fmt([[{}]], {
            c(1, {
                t([[io.read()]]),
                t([[io.read('n')]]),
                t([[io.read('a')]]),
                t([[io.read('l')]]),
                t([[io.lines()]]),
            }),
        })
    ),

    ms(
        {
            { trig = 'load', snippetType = 'snippet' },
        },
        fmt(
            [[
        {}
        ]],
            {
                c(1, {
                    sn(
                        nil,
                        fmt(
                            [[
            -- Load and execute the expression
            local ok, result = pcall(load("return " .. {}))

            -- Check for errors during the load and execution process
            if ok then
                print(result)
            else
                print("Error: ", result)
            end
              ]],
                            {
                                i(1, 'string_to_load'),
                            }
                        )
                    ),

                    sn(
                        nil,
                        fmt([[print(load("return "..{})())]], {
                            i(1, 'string_to_load'),
                        })
                    ),
                }),
            }
        )
    ),

    ms(
        {
            { trig = 'round', snippetType = 'snippet' },
        },
        fmt(
            [[
function round(number, decimal_places)
    local multiplier = 10 ^ (decimal_places or 0)
    return math.floor(number * multiplier + 0.5) / multiplier
end
        ]],
            {}
        )
    ),

    ms(
        {
            { trig = 'REGMATCH', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        local {} = {}:match('{}')
        ]],
            {
                i(1, 'match'),
                i(2, 'source_string'),
                i(3, 'pattern'),
            }
        )
    ),

    ms(
        {
            { trig = 'ALLREGMATCH', snippetType = 'autosnippet', condition = conds.line_begin },
            { trig = 'gmatch',      snippetType = 'snippet',     condition = conds.line_begin },
        },
        fmt(
            [[
        for {} in {}:gmatch('{}') do
            {}
        end
        ]],
            {
                i(1, 'word'),
                i(2, 'source_string'),
                i(3, 'pattern'),
                i(4),
            }
        )
    ),

    ms(
        {
            { trig = 'REGREPLACE', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt([[{Choices}]], {
            Choices = c(1, {
                sn(
                    nil,
                    fmt(
                        [[
        local {Variable} = {Source}:gsub('{Pattern}', {Replacement})
                    ]],
                        {
                            Variable = i(1, 'output'),
                            Source = i(2, 'source'),
                            Pattern = i(3, '.*'),
                            Replacement = i(4, 'replacement'),
                        }
                    )
                ),
            }),
        })
    ),

    ms(
        {
            { trig = 'TEST', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
            it('{}', function()
                {}
            end)
            ]],
            {
                i(1),
                i(2),
            }
        )
    ),

    ms(
        {
            { trig = 'INCLUDE', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        require('{}')
        ]],
            {
                i(1),
            }
        )
    ),

    -- Working snippet that generates commas when needed inside a table
    -- Enhancement would be to use a dynamic creation of a node that would optionally
    -- put a choice option defaulting to 'local' for variables inside a function
    -- When inside a table, the node choice would not exist
    ms(
        {
            { trig = 'FIRST', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt([[ = {}{}]], {
            i(1, 'true'),
            f(function(args, snip)
                local returnString = ''

                if require('stimpack.my-treesitter-functions').lua.current_location_is_in_lua_table() == true then
                    returnString = ','
                end
                return returnString
            end, {}),
        }),
        {
            condition = conds_expand.line_begin,
        }
    ),

    ms(
        {
            { trig = 'TABLE', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        {{
            {}
        }}
        ]],
            {
                i(1),
            },
            {
                condition = conds_expand.line_begin,
            }
        )
    ),

    ms(
        {
            { trig = 'KEY', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        {} = {},
        ]],
            {
                i(1, 'key'),
                i(2, 'value'),
            },
            {
                condition = conds_expand.line_begin,
            }
        )
    ),

    ms(
        {
            { trig = 'IF', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
            if {} then
            {}
            end
            {}]],
            {
                i(1, 'true'),
                auxiliary.wrap_selected_text(2),
                i(0),
            },
            {
                condition = conds_expand.line_begin,
            }
        )
    ),

    ms(
        {
            {
                trig = shiftwidth_match_string .. 'ELS_EI_F',
                regTrig = true,
                wordTrig = false,
                snippetType = 'autosnippet',
                condition = conds.line_begin,
            },
        },
        fmt(
            [[
        elseif {} then
            {}
        ]],
            {
                i(1),
                i(2),
            },
            {
                condition = conds_expand.line_begin,
            }
        )
    ),

    ms(
        {
            {
                trig = shiftwidth_match_string .. 'ELSE',
                regTrig = true,
                wordTrig = false,
                snippetType = 'autosnippet',
                condition = conds.line_begin,
            },
        },
        fmt(
            [[
        else
            {}
        ]],
            {
                i(1),
            },
            {
                condition = conds_expand.line_begin,
            }
        )
    ),

    ms(
        {
            { trig = 'module function', snippetType = 'autosnippet', condition = nil },
            { trig = 'module function', snippetType = 'snippet',     condition = nil },
        },
        fmt(
            [[
        M.{Name} = function({Args})
          {Code}
        end]],
            {
                Name = i(1, 'function_name'),
                Args = i(2),
                Code = i(3),
            }
        ),
        {
            condition = conds_expand.line_begin,
        }
    ),

    ms(
        {
            { trig = 'FUNCTION', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
        function({})
          {}
        end]],
            {
                i(1),
                i(2),
            }
        ),
        {
            condition = conds_expand.line_begin,
        }
    ),

    -- TODO: Call different function than pairs if two arguments are used
    ms(
        {
            { trig = '(%w+),? (%w+) FOR', regTrig = true, snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        for {} do
            {}
        end

        {}
        ]],
            {
                d(1, function(args, snip)
                    -- Check for numeric for loop, only lower bound needs to be number
                    if snip.captures[1]:match('%d+') then
                        return sn(nil, {
                            t('i='),
                            t(snip.captures[1]),
                            t(', '),
                            t(snip.captures[2]),
                        })
                    elseif snip.captures[1]:match('i?pairs') then
                        return sn(nil, {
                            t(string.format('k, v in %s(%s)', snip.captures[1], snip.captures[2])),
                        })
                    else
                        return sn(nil, {
                            i(1),
                            t('in'),
                            i(2),
                        })
                    end
                end, { 1 }),
                i(2),
                i(0),
            }
        )
    ),

    ms(
        {
            { trig = 'FREACH', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        for {}, {} in {}({}) do
            {}
        end
        ]],
            {
                i(1, '_'),
                i(2, 'value'),
                c(3, {
                    t('pairs'),
                    t('ipairs'),
                }),
                i(4, 'table'),
                i(5),
            }
        ),
        {
            condition = conds_expand.line_begin,
        }
    ),

    ms(
        {
            { trig = 'FOR', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        for {}={}, {} do
            {}
        end{}
        ]],
            {
                i(0, 'i'),
                i(1, '1'),
                i(2, '10, 2'),
                i(3),
                i(4),
            }
        ),
        {
            condition = conds_expand.line_begin,
        }
    ),

    ms(
        {
            { trig = 'WHILE', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        while {} do
            {}
        end

        {}
        ]],
            {
                i(1, 'condition'),
                i(2),
                i(0),
            }
        ),
        {
            condition = conds_expand.line_begin,
        }
    ),

    ms(
        {
            { trig = 'FRMAT', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
      string.format('{}',{})
      {}
      ]],
            {
                i(1),
                i(2),
                i(0),
            },
            {
                condition = conds_expand.line_begin,
            }
        )
    ),

    ms(
        {
            { trig = 'PRINT', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
      print({})
      {}
      ]],
            { i(1), i(0) },
            {
                condition = conds_expand.line_begin,
            }
        )
    ),

    ms(
        {
            { trig = 'ERRORPRINT', snippetType = 'autosnippet' },
        },
        fmt([[io.stderr:write({})]], {
            i(1),
        })
    ),

    ms(
        {
            { trig = 'DESCRIBE',   descr = 'Plenary test group', snippetType = 'autosnippet' },
            { trig = 'test group', descr = 'Plenary test group', snippetType = 'snippet' },
        },
        fmt(
            [[
        describe('{} --', function()
          {}
        end)

        {}
    ]],
            {
                i(1, 'Test group name '),
                d(2, function()
                    local test_snippet = fmt(
                        [[
          it('{}', function()
              {}
          end)
          ]],
                        {
                            i(1, 'Test name'),
                            i(2),
                        }
                    )

                    -- TODO: dynamic may not be the way to go. I may need just normal choice version
                    local runtimepath_add_in = fmt(
                        [[
          before_each(function()
              -- Run time path is not getting loaded automatically, so modify it before each test
              print('Attempting to add to neovim runtime path with current plugin location')
              local path_to_plugin = debug.getinfo(1).source:match('@(.*[/\\]lua[/\\])'):gsub('"', '')
              print(string.format('Attempting to add: %s to neovim runtimepath because plenary tests fail without this', path_to_plugin))
              vim.cmd('set runtimepath+=' .. path_to_plugin)
          end)
          ]],

                        {}
                    )

                    return sn(
                        nil,
                        {
                            c(1, {
                                t('new text'),
                                runtimepath_add_in,
                            }),
                        }

                    -- test_snippet
                    )
                end, { 1 }),

                i(3),
            },
            {
                condition = conds_expand.line_begin,
            }
        )
    ),

    ms(
        {
            { trig = 'nvimcommand', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
            vim.api.nvim_cmd({{ cmd = '{}', args = {{ '{}' }} }}, {{}})
            ]],
            {
                i(1, 'command'),
                i(2),
            }
        )
    ),

    ms(
        {
            { trig = 'ASSERT', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        assert.{}({})
        ]],
            {
                c(1, {
                    t('are.same'),
                    t('is.same'),
                    t('are_not.equals'),
                    t('are_not.equal'),
                    t('is_not.equal'),
                    t('truthy'),
                    t('is.truthy'),
                    t('True'),
                    t('is_true'),
                    t('falsy'),
                    t('is.falsy'),
                    t('has_error(function() end)'),
                    t('has_no_errors(function() end)'),
                    t('are.unique'),
                }),
                i(2),
            },
            {
                condition = conds_expand.line_begin,
            }
        )
    ),

    ms(
        {
            { trig = 'var var', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
      {}
      ]],
            {
                f(function()
                    return my_treesitter_functions.lua.get_recent_var()
                end, {}),
            }
        )
    ),

    -- Start luafun snippets, https://luafun.github.io/index.html

    ms(
        {
            { trig = ':filter', snippetType = 'autosnippet' },
        },
        fmt([[:filter(function({Inputs}) return {Condition} end)]], {
            Inputs = i(1, 'I'),
            Condition = i(2, 'I % 2 == 0'),
        })
    ),

    ms(
        {
            { trig = ':map', snippetType = 'autosnippet' },
        },
        fmt([[:map(function({Inputs}) return {Mapping} end)]], {
            Inputs = i(1, 'I'),
            Mapping = i(2, 'I * I'),
        })
    ),

    ms(
        {
            { trig = ':iter', snippetType = 'autosnippet' },
        },
        fmt([[:iter(function({Inputs}) {Iteration} end)]], {
            Inputs = i(1, 'I'),
            Iteration = i(1, 'print I'),
        })
    ),

    ms(
        {
            { trig = ':each', snippetType = 'autosnippet' },
        },
        fmt([[:each({Function})]], {
            Function = i(1, 'print'),
        })
    ),

    ms(
        {
            { trig = ':fold', snippetType = 'autosnippet' },
        },
        fmt([[:foldl({Function}, {InitialValue})]], {
            Function = c(1, {
                t('operator.add'),
                t('operator.div'),
                t('operator.truediv'),
                t('operator.floordiv'),
                t('operator.intdiv'),
                t('operator.mod'),

                sn(
                    nil,
                    fmt(
                        [[
                function({Accumulator}, {Variable})
                    return {Calculation}
                end
                ]],
                        {
                            Accumulator = i(1, 'accumulator'),
                            Variable = i(2, 'x'),
                            Calculation = i(3, 'accumulator + x'),
                        }
                    )
                ),
            }),
            InitialValue = i(2, '0'),
        })
    ),

    -- End luafun snippets, https://luafun.github.io/index.html
}

local autosnippets = {}

return snippets, autosnippets
