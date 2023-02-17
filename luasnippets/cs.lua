---@diagnostic disable: undefined-global

local my_treesitter_functions = require('stimpack.my-treesitter-functions')

---Function for luasnip to add using directives needed for snippets
---@param required_using_directive_list string|table
local function add_csharp_using_statement_if_needed(required_using_directive_list)
    if type(required_using_directive_list) == 'string' then
        local temp = required_using_directive_list
        required_using_directive_list = { temp }
    end

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
        for index, using_directive in ipairs(required_using_directive_list) do
            if line:match(using_directive) ~= nil then
                table.remove(required_using_directive_list, index)
            end
        end
    end

    -- Add all using directives that remain in the list to be written to top of file
    if #required_using_directive_list > 0 then
        local using_directives_to_write = {}
        for _, using_directive in ipairs(required_using_directive_list) do
            table.insert(using_directives_to_write, string.format('using %s;', using_directive))
        end
        vim.api.nvim_buf_set_lines(0, 0, 0, false, using_directives_to_write)
    end
end

local snippets = {

    s(
        'regex match',
        fmt(
            [[
        if(Regex.IsMatch({}, @"{}"))
        {{
            {}
        }}
        ]]   ,
            {
                i(1, '"source"'),
                i(2, '.*'),
                i(3),
            }
        ),
        {
            callbacks = {
                [-1] = {
                    -- Write needed using directives before expanding snippet so positions are not messed up
                    [events.pre_expand] = function()
                        add_csharp_using_statement_if_needed('System.Text.RegularExpressions')
                    end,
                },
            },
        }
    ),

    s(
        'regex matches',
        fmt(
            [[
        var matches = Regex.Matches({}, @"{}")
                           .Cast<Match>()
                           .Select(match => {})
                           .Distinct();
        ]]   ,
            {
                i(1),
                i(2, '.*'),
                i(3, 'match'),
            }
        ),
        {
            callbacks = {
                [-1] = {
                    -- Write needed using directives before expanding snippet so positions are not messed up
                    [events.pre_expand] = function()
                        add_csharp_using_statement_if_needed({
                            'System.Linq',
                            'System.Text.RegularExpressions',
                        })
                    end,
                },
            },
        }
    ),

    s(
        'prop',
        fmt(
            [[
      {} {} {} {{ get; set; }}
      ]]     ,
            {
                c(1, {
                    t('public'),
                    t('private'),
                }),
                i(2, 'int'),
                i(3),
            }
        )
    ),

    s(
        'event',
        fmt(
            [[
      public event EventHandler<{}>? {};

      protected virtual void On{}({} e)
      {{
          {}?.Invoke(this, e);
      }}
      ]]     ,
            {
                i(1, 'string'),
                i(2, 'EventName'),
                rep(2),
                rep(1),
                rep(2),
            }
        )
    ),

    -- {{{ Comment XML snippets
    s(
        {
            trig = 'param',
            descr = 'XML parameter comment',
        },
        fmt([[<param name="{}">{}</param>]], {
            i(1),
            i(2),
        })
    ),

    s(
        {
            trig = 'exception',
            descr = 'XML exception comment',
        },
        fmt([[<exception cref="{}">{}</exception>]], {
            i(1, 'System.Exception'),
            i(2),
        })
    ),

    s(
        {
            trig = 'returns',
            descr = 'XML returns comment',
        },
        fmt([[<returns>{}</returns>]], {
            i(1),
        })
    ),

    s(
        {
            trig = 'code',
            descr = 'XML code comment',
        },
        fmt([[<code>{}</code>]], {
            i(1),
        })
    ),
    -- }}}

    -- Avalonia snippets
    s('transform', {
        i(1, 'TestTestTest'),
        t({ '', '' }),
        -- lambda nodes accept an l._1,2,3,4,5, which in turn accept any string transformations.
        -- This list will be applied in order to the first node given in the second argument.
        l(
            l._1:gsub('^.', function(s)
                return s:lower()
            end),
            1
        ),
    }),

    s(
        'prop Avalonia',
        fmt(
            [[
        private {} {};
        public {} {}
        {{
            get => {};
            set => this.RaiseAndSetIfChanged(ref {}, value);
        }}

        {}
      ]]     ,
            {
                i(1, 'int'),
                i(2, 'variableNameWithLoweredFirstChar'),
                rep(1),
                l(
                    l._1:gsub('^.', function(s)
                        return s:upper()
                    end),
                    2
                ),
                rep(2),
                rep(2),
                i(0),
            }
        )
    ),

    s(
        'enum',
        fmt(
            [[
        enum {}
        {{
            {}
        }}
        ]]   ,
            {
                i(1, 'Enum1'),
                i(2),
            }
        )
    ),

    s(
        'read line',
        fmt(
            [[
        var line = Console.ReadLine();
        ]]   ,
            {}
        ),
        {
            callbacks = {
                [-1] = {
                    -- Write needed using directives before expanding snippet so positions are not messed up
                    [events.pre_expand] = function()
                        add_csharp_using_statement_if_needed('System')
                    end,
                },
            },
        }
    ),

    s(
        'read lines',
        fmt(
            [[
        var Lines = new List<string>();
        var Line = "";
        while((Line = Console.ReadLine()) != null)
        {{
            Lines.Add(Line);
        }}
        ]]   ,
            {}
        ),
        {
            callbacks = {
                [-1] = {
                    -- Write needed using directives before expanding snippet so positions are not messed up
                    [events.pre_expand] = function()
                        add_csharp_using_statement_if_needed({ 'System', 'System.Collections.Generic' })
                    end,
                },
            },
        }
    ),

    s(
        'clash of code snippet starter',
        fmt(
            [[
        using System;
        using System.Linq;
        using System.Text.RegularExpressions;
        using System.Collections.Generic;

        {}

        {}

        Console.WriteLine({});
        ]]   ,
            {
                c(1, {
                    t('var Line = Console.ReadLine();'),
                    t({
                        'var Lines = new List<string>();',
                        'var Line="";',
                        'while((Line = Console.ReadLine()) != null)',
                        '{',
                        '    Lines.Add(Line);',
                        '}',
                    }),
                }),
                i(2),
                i(3),
            }
        )
    ),

    s(
        'range',
        fmt(
            [[
        Enumerable.Range({}, {})
        ]]   ,
            {
                i(1, '1'),
                i(2, '50'),
            }
        )
    ),
}

local autosnippets = {

    s(
        'PRINT',
        fmt(
            [[
      Console.WriteLine($"{}");
      ]]     ,
            {
                i(1),
            }
        )
    ),

    s(
        'FORMAT',
        fmt(
            [[
      $"{}"
      ]]     ,
            {
                i(1),
            }
        )
    ),

    s(
        '{{',
        fmt([[{{{}}}]], {
            i(1),
        })
    ),

    -- {{{ Fast steno commands to trigger snippets
    s(
        'IF',
        fmt(
            [[
      if ({})
      {{
        {}
      }}
      {}
      ]]     ,
            {
                i(1, 'true'),
                i(2),
                i(0),
            }
        )
    ),

    s(
        'ELS_EI_F',
        fmt(
            [[
      else if ({})
      {{
        {}
      }}
      {}
      ]]     ,
            {
                i(1, 'false'),
                i(2),
                i(0),
            }
        )
    ),

    s(
        'ELSE',
        fmt(
            [[
      else
      {{
        {}
      }}

      {}
      ]]     ,
            {
                i(1),
                i(0),
            }
        )
    ),

    s(
        'CLASS',
        fmt(
            [[
        namespace {};

        {}{} class {}
        {{
            {}
        }}
        ]]   ,
            {
                f(function(args, snip)
                    -- Get csharp namespace
                    local cwd = vim.fn.getcwd()
                    local full_file = vim.fn.expand('%:p')
                    local just_file_name = vim.fn.expand('%:t')
                    local namespace = full_file
                        :gsub(cwd .. OS.separator, '')
                        :gsub(OS.separator .. just_file_name, '')
                        :gsub(OS.separator, '.')
                    return namespace
                end, {}),

                c(1, {
                    t('public'),
                    t('private'),
                }),

                c(2, {
                    t(''),
                    t(' static'),
                }),

                f(function(args, snip)
                    return vim.fn.expand('%:p:t:r')
                end, { 3 }),

                i(3),
            }
        )
    ),

    s(
        'CONSTRUCTOR',
        fmt(
            [[
        {}({})
        {{
            {}
        }}
        ]]   ,
            {
                f(function(args, snip)
                    local class_information = my_treesitter_functions.cs.get_class_name()
                    return string.format('%s %s', class_information.modifier, class_information.class)
                end, {}),
                i(1),
                i(2),
            }
        )
    ),

    s(
        'FOREACH',
        fmt(
            [[
            foreach(var item in {})
            {{
                  {}
            }}
            ]],
            {
                i(1),
                i(2),
            }
        )
    ),

    s(
        'TRY',
        fmt(
            [[
            try
            {{
                {}
            }}
            catch (Exception ex)
            {{
                {}
            }}
            ]],
            {
                i(1),
                i(2),
            }
        )
    ),

    -- s(
    --   'FOR',
    --   fmt(
    --     [[
    --     for (int i = {}; i < {}; i++)
    --     {{
    --       {}
    --     }}
    --
    --     {}
    --     ]],
    --     {
    --       i(1, '0'),
    --       i(2, '10'),
    --       i(3),
    --       i(0),
    --     }
    --   )
    -- ),

    s(
        { trig = 'CALL', wordTrig = false },
        fmt([[({});]], {
            i(1),
        })
    ),

    s(
        'FUNCTION',
        fmt(
            [[
      {} {} {}({})
      {{
        {}
      }}

      {}
      ]]     ,
            {
                c(1, {
                    t('public'),
                    t('private'),
                }),

                i(2, 'async Task'),

                --TODO: Add choice-node here
                i(3, 'AwesomeFunction'),

                i(4, 'int params'),
                i(5),
                i(0),
            }
        )
    ),

    -- TODO: Add switch statement that gets all enum values if applicable

    --[[ switch (DeviceTypeEnum)
            {
                case DeviceTypeEnum.unknown:
                    break;
                case DeviceTypeEnum.BelleX:
                    break;
                case DeviceTypeEnum.BelleW:
                    break;
                default:
                    break;
            } ]]

    s(
        { trig = '(%d+)b', regTrig = true },

        fmt([[ {} {} ]], {
            f(function(_, snip)
                return 'Captured Text: ' .. snip.captures[1] .. '.'
            end, {}),

            t('Derek is cool!'),
        })
    ),

    s(
        {
            trig = ' Derek (%d+) (%w+) ',
            regTrig = true,
            descr = 'test test',
        },
        fmt(
            [[
      {} {}
      ]]     ,
            {
                t(' Derek test: '),

                f(function(_, snip)
                    return snip.captures[2] .. ' + ' .. snip.captures[1]
                end, {}),
            }
        )
    ),

    s(
        'var var',
        fmt(
            [[
      {}
      ]]     ,
            {
                f(function()
                    local variable = my_treesitter_functions.cs.get_recent_var()
                    return variable
                end, {}),
            }
        )
    ),

    -- }}}
}

return snippets, autosnippets
