---@diagnostic disable: undefined-global, missing-parameter

local my_treesitter_functions = require('stimpack.my-treesitter-functions')
local shiftwidth = vim.bo.shiftwidth
local shiftwidth_match_string = string.rep(' ', shiftwidth)
local auxiliary = require('luasnippets.functions.auxiliary')
local scan = require('plenary.scandir')
local fun = require('luafun.fun')
local conds_expand = require('luasnip.extras.conditions.expand')

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
            { trig = 'read line', snippetType = 'snippet', },
            { trig = 'io.read()', snippetType = 'snippet', },
        },
        fmt(
            [[
        -- Read: {} line{} of input, as data type: {}
        {}
        ]],
            {
                i(1, '1'),
                f(function(args, snip)
                    if args[1] and args[1][1] and args[1][1] ~= '1' then
                        return 's'
                    end
                end, {1}),
                c(2, {
                    t('string'),
                    t('number'),
                }),
                 d(3, function(args, snip)
                     local nodes = {}

                     -- Add nodes for snippet
                     table.insert(nodes, t('Add this node'))
                     

                   return sn(nil, nodes)
                  end,
                   { 1 }
                  ),
            }

        )
    ),
}

local autosnippets = {

    s(
        'INCLUDE',
        fmt(
            [[
        require('{}')
        ]],
            {
                i(1),
            },
            {
                condition = conds_expand.line_begin,
            }
        )
    ),

    -- Working snippet that generates commas when needed inside a table
    -- Enhancement would be to use a dynamic creation of a node that would optionally
    -- put a choice option defaulting to 'local' for variables inside a function
    -- When inside a table, the node choice would not exist
    s(
        'FIRST',
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

    s(
        'TABLE',
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

    s(
        'KEY',
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

    s(
        'IF',
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

    s(
        { trig = shiftwidth_match_string .. 'ELS_EI_F', regTrig = true, wordTrig = false },
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

    s(
        { trig = shiftwidth_match_string .. 'ELSE', regTrig = true, wordTrig = false },
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

    s(
        'FUNCTION',
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
    s(
        { trig = '(%w+),? (%w+) FOR', regTrig = true },
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

    s(
        'FREACH',
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

    s(
        'FOR',
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

    s(
        'WHILE',
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

    s(
        'FRMAT',
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

    s(
        'PRINT',
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

    s(
        { trig = 'DESCRIBE', descr = 'Plenary test group' },
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

    s(
        'nvimcommand',
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

    s(
        'TEST',
        fmt(
            [[
            it('{}', function()
                {}
            end)
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

    s(
        'ASSERT',
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

    s(
        'var var',
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
}

return snippets, autosnippets
