---@diagnostic disable: undefined-global

local my_treesitter_functions = require('stimpack.my-treesitter-functions')
local auxiliary = require('luasnippets.functions.auxiliary')
local string_processor = require('luasnippets.functions.string_processor')

-- This document is used as a basic style/convention guide
-- https://barrgroup.com/sites/default/files/barr_c_coding_standard_2018.pdf

local snippets = {

    ms(
        {
            {
                trig = 'FIRST',
                snippetType = 'autosnippet',
            },
        },
        fmt(
            [[
        {} {}{};
        ]],
            {
                i(1, 'int'),
                i(2, 'var'),
                c(3, {
                    sn(
                        nil,
                        fmt([[{}= {}]], {
                            t(' '),
                            i(1, 'value'),
                        }, { trim_empty = false })
                    ),
                    t(''),
                }),
            }
        )
    ),

    ms(
        {
            {
                trig = 'CLASS',
                snippetType = 'autosnippet',
            },
            {
                trig = 'struct',
                snippetType = 'snippet',
            },
        },
        fmt(
            [[
        typedef struct {{
            {}
        }} {}_t;
        ]],
            {
                i(2),
                i(1, 'my_struct_t'),
            }
        )
    ),

    ms(
        {
            'printf',
            'fprintf',
            { trig = 'PRINT',      snippetType = 'autosnippet' },
            { trig = 'ERRORPRINT', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        {}"{}"{});
        ]],
            {
                f(function(args, snip)
                    if snip.trigger == 'ERRORPRINT' or snip.trigger == 'fprintf' then
                        return 'fprintf(stderr, '
                    else
                        return 'printf('
                    end
                end, {}),
                i(1),
                auxiliary.printf_style_dynamic_formatter(2, 1),
            }
        )
    ),

    s(
        'main',
        fmt(
            [[
        #include <stdio.h>
        #include <stdlib.h>

        int main(void)
        {{
             printf("{}\n");
             {}
             return 0;
        }}
        ]],
            {
                i(1),
                i(0),
            }
        )
    ),

    s(
        'main lua',
        fmt(
            [[
        #include <stdio.h>
        #include <stdlib.h>

        #include <lua.h>
        #include <lualib.h>
        #include <lauxlib.h>

        int main(void)
        {{
             lua_State* L = luaL_newstate();
             luaL_openlibs(L);

             luaL_dostring(L, "print('{}')");

             return 0;
        }}
        ]],
            {
                i(1, 'Hello world from lua!'),
            }
        )
    ),

    s(
        'memcpy',
        fmt(
            [[
        memcpy({}, {}, {});
        ]],
            {
                i(1, 'destination'),
                i(2, 'source'),
                i(3, 'size'),
            }
        )
    ),

    s(
        'malloc',
        fmt(
            [[
        {} {} = malloc(sizeof({}) * {});
        if({} == NULL)
        {{
             printf("malloc for {} failed\n");
             exit(1);
        }}
        ]],
            {
                i(1, 'int'),
                i(2, 'variableName'),
                rep(1),
                i(3, '50'),
                -- A shortcut for functionNodes that only do very basic string manipulation.
                -- l(lambda, argnodes):
                l(l._1:gsub('[*]', ''), { 2 }),
                rep(2),
            }
        )
    ),

    -- {{{ clang format disable block
    s(
        {
            trig = 'clangf',
            descr = 'Comment string to disable clang formatting',
        },
        fmt(
            [[
      // clang-format off
      {}
      // clang-format on
      ]],
            { i(1) }
        )
    ),
    -- }}}

    -- {{{ easy strtok
    s(
        {
            trig = 'strtok_ez',
            descr = 'Easily use strtok with a for loop',
        },
        fmt(
            [[
      char separator[] = "{}";
      for (char *p = strtok({}, separator); p != NULL; p = strtok(NULL, separator))
      {{
        returnValue += atoi(p);
      }}
      {}
      ]],
            { i(1, ','), i(2, 'InputStringToParse'), i(3) }
        )
    ),

    s(
        'puts',
        fmt([[puts("{}");]], {
            i(1, 'Hello World!'),
        })
    ),
    -- }}}

    s(
        'macro stringize',
        fmt(
            [[
        #define Stringize(x) #x
        ]],
            {}
        )
    ),

    s(
        'macro double stringize',
        fmt(
            [[
        #define Stringize(x) #x
        #define DoubleStringize(x) Stringize(x)
        ]],
            {}
        )
    ),

    s(
        'clash of code',
        fmt(
            [[
        #include <stdio.h>
        #include <stdlib.h>
        #include <string.h>
        main() {{
        {}
        printf("%s\n", p);
        {}
        }}
        ]],
            {
                c(1, {
                    sn(
                        1,
                        fmt(
                            [[
                            char *p,*l=0;
                            getline(&p,&l,stdin);
                             ]],
                            {}
                        )
                    ),

                    sn(
                        1,
                        fmt(
                            [[
                            char *p,*l=0;
                            // Read all stdin
                            getdelim(&p,&l,0xff,stdin);
                             ]],
                            {}
                        )
                    ),
                }),
                i(2, 'test'),
            }
        )
    ),

    ms(
        {
            { trig = 'string length', snippetType = 'autosnippet' },
            'strlen',
        },
        -- Do not add semicolon as it might need to be done in a loop
        fmt([[ strlen({})]], {
            i(1, 'string'),
        })
    ),

    ms(
        {
            { trig = 'string copy', snippetType = 'autosnippet' },
            'strcpy',
        },
        fmt([[strcpy({}, {});]], {
            i(1, 'destination'),
            i(2, 'item_to_copy_from'),
        })
    ),

    -- Algorithms start

    s(
        'swap case',
        fmt(
            [[
        void StringSwapCase(*inputString) {
          unsigned char A_to_a = 'a' - 'A';
          for (int i = 0; i < strlen(inputString); i++) {
            char isLetter = isalpha(inputString[i]) ? 1 : 0;
            char isUpper = isupper(inputString[i]) ? 1 : -1;
            inputString[i] += isLetter * isUpper * A_to_a;
          }
        }
        ]],
            {},
            {
                delimiters = [[/\]],
            }
        ),
        {
            callbacks = {
                [-1] = {
                    -- Write needed using directives before expanding snippet so positions are not messed up
                    [events.pre_expand] = function()
                        auxiliary.insert_include_if_needed('<ctype.h>')
                    end,
                },
            },
        }
    ),
    -- Algorithms end

    ms(
        {
            {
                trig = 'STDINT',
                snippetType = 'autosnippet',
            },
            {
                trig = 'USTDINT',
                snippetType = 'autosnippet',
            },
        },
        fmt([[{}{}]], {
            f(function(args, snip)
                if snip.trigger == 'USTDINT' then
                    return 'u'
                end
            end, {}),

            c(1, {
                t('int8_t'),
                t('int16_t'),
                t('int32_t'),
                t('int64_t'),
            }),
        })
    ),
}

local autosnippets = {

    s(
        'FOR',
        fmt(
            [[
        for(size_t i = {}; i < {}; i{})
        {{
            {}
        }}
        ]],
            {
                i(1, '0'),
                i(2, '10'),
                c(3, {
                    t('++'),
                    t('--'),
                }),
                i(4),
            }
        )
    ),

    s(
        'IF',
        fmt(
            [[
        if({})
        {{
            {}
        }}{}
        ]],
            {
                i(1),
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
        }}{}
        ]],
            {
                i(1),
                i(0),
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
                    local variable = my_treesitter_functions.cs.get_recent_var()
                    return variable
                end, {}),
            }
        )
    ),

    s(
        'FUNCTION',
        fmt(
            [[
            {} {}({})
            {{
                {}
            }}
            ]],
            {
                i(1, 'int'),
                i(2, 'MyFunction'),
                i(3),
                i(4),
            }
        )
    ),

    s(
        'head head',
        fmt([[{}]], {
            c(1, {
                sn(
                    nil,
                    fmt(
                        [[
                    #pragma once

                    #if defined(__cplusplus)
                    extern "C" {{
                    #endif

                    {}

                    #if defined(__cplusplus)
                    }}
                    #endif
                    ]],
                        {
                            i(1),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                    #ifndef {}
                    #define {}

                    #if defined(__cplusplus)
                    extern "C" {{
                    #endif

                    {}

                    #if defined(__cplusplus)
                    }}
                    #endif

                    #endif // {}
                    ]],
                        {
                            f(function(args, snip)
                                return vim.fn.expand('%:t'):gsub('%.h', ''):upper() .. '_H'
                            end, {}),
                            f(function(args, snip)
                                return vim.fn.expand('%:t'):gsub('%.h', ''):upper() .. '_H'
                            end, {}),
                            i(1),
                            f(function(args, snip)
                                return vim.fn.expand('%:t'):gsub('%.h', ''):upper() .. '_H'
                            end, {}),
                        }
                    )
                ),
            }),
        })
    ),

    s(
        'define define',
        fmt(
            [[
        /*
        @brief {}

        @returns <{}> {}
        */
        {} {}({});
        ]],
            {
                i(4, 'This function does does ...'),
                rep(1),
                i(5, 'Description about the return value'),

                i(1, 'int'),
                i(2, 'MyFunction'),
                i(3, 'int a, int b'),
            }
        )
    ),

    s(
        'WHILE',
        fmt(
            [[
        while({})
        {{
            {}
        }}
        ]],
            {
                i(1, 'true'),
                i(2),
            }
        )
    ),

    s(
        'ENUM',
        fmt(
            [[
        typedef enum
        {{
            {},{}
        }} {};{}
        ]],
            {
                i(2, 'KROOL'),
                i(3),
                i(1, 'EnumName'),
                i(0),
            }
        )
    ),

    s(
        '///',
        fmt(
            [[
        /*
        {}
        */
        ]],
            {
                i(1),
            }
        )
    ),

    s('INCLUDE', {
        d(1, function(args, snip)
            -- Create a table of nodes that will go into the header choice_node
            local headers_to_load_into_choice_node = {}

            -- Step 1: get companion .h file if the current file is a .c or .cpp file excluding main.c
            local extension = vim.fn.expand('%:e')
            local is_main = vim.fn.expand('%'):match('main%.cp?p?') ~= nil
            if (extension == 'c' or extension == 'cpp') and not is_main then
                local matching_h_file = vim.fn.expand('%:t'):gsub('%.c', '.h')
                local companion_header_file = string.format('#include "%s"', matching_h_file)
                table.insert(headers_to_load_into_choice_node, t(companion_header_file))
            end

            -- Step 2: get all the local headers in current directory and below
            local current_file_directory = vim.fn.expand('%:h')
            local local_header_files = require('plenary.scandir').scan_dir(
                current_file_directory,
                { respect_gitignore = true, search_pattern = '.*%.h$' }
            )

            -- Clean up and insert the detected local header files
            for _, local_header_name in ipairs(local_header_files) do
                -- Trim down path to be a true relative path to the current file
                local shortened_header_path = local_header_name:gsub(current_file_directory, '')
                -- Replace '\' with '/'
                shortened_header_path = shortened_header_path:gsub([[\+]], '/')
                -- Remove leading forward slash
                shortened_header_path = shortened_header_path:gsub('^/', '')
                local new_header = t(string.format('#include "%s"', shortened_header_path))
                table.insert(headers_to_load_into_choice_node, new_header)
            end

            -- Step 3: allow for custom insert_nodes for local and system headers
            local custom_insert_nodes = {
                sn(
                    nil,
                    fmt(
                        [[
                         #include "{}"
                         ]],
                        {
                            i(1, 'custom_insert.h'),
                        }
                    )
                ),
                sn(
                    nil,
                    fmt(
                        [[
                         #include <{}>
                         ]],
                        {
                            i(1, 'custom_system_insert.h'),
                        }
                    )
                ),
            }
            -- Add the custom insert_nodes for adding custom local (wrapped in "") or system (wrapped in <>) headers
            for _, custom_insert_node in ipairs(custom_insert_nodes) do
                table.insert(headers_to_load_into_choice_node, custom_insert_node)
            end

            -- Step 4: finally last priority is the system headers
            local system_headers = {
                t('#include <assert.h>'),
                t('#include <complex.h>'),
                t('#include <ctype.h>'),
                t('#include <errno.h>'),
                t('#include <fenv.h>'),
                t('#include <float.h>'),
                t('#include <inttypes.h>'),
                t('#include <iso646.h>'),
                t('#include <limits.h>'),
                t('#include <locale.h>'),
                t('#include <math.h>'),
                t('#include <setjmp.h>'),
                t('#include <signal.h>'),
                t('#include <stdalign.h>'),
                t('#include <stdarg.h>'),
                t('#include <stdatomic.h>'),
                t('#include <stdbit.h>'),
                t('#include <stdbool.h>'),
                t('#include <stdckdint.h>'),
                t('#include <stddef.h>'),
                t('#include <stdint.h>'),
                t('#include <stdio.h>'),
                t('#include <stdlib.h>'),
                t('#include <stdnoreturn.h>'),
                t('#include <string.h>'),
                t('#include <tgmath.h>'),
                t('#include <threads.h>'),
                t('#include <time.h>'),
                t('#include <uchar.h>'),
                t('#include <wchar.h>'),
                t('#include <wctype.h>'),
            }
            for _, header_snippet in ipairs(system_headers) do
                table.insert(headers_to_load_into_choice_node, header_snippet)
            end

            return sn(1, c(1, headers_to_load_into_choice_node))
        end, {}),
    }),

    s(
        'DEFINE',
        fmt(
            [[
        #define {} {}
        ]],
            {
                i(1, 'VARIABLE'),
                i(2, 'VALUE'),
            }
        )
    ),

    s(
        'SWITCH',
        fmt(
            [[
        switch({})
        {{
             case {}:
                 {}
                 break;
             default:
                 break;
        }}
        ]],
            {
                i(1, 'variable'),
                i(2, '1'),
                i(3),
            }
        )
    ),
}

return snippets, autosnippets
