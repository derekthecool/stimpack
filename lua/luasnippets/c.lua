---@diagnostic disable: undefined-global

local my_treesitter_functions = require('config.my-treesitter-functions')
local auxiliary = require('luasnippets.functions.auxiliary')
local string_processor = require('luasnippets.functions.string_processor')

local shareable = require('luasnippets.functions.shareable_snippets')

-- This document is used as a basic style/convention guide
-- https://barrgroup.com/sites/default/files/barr_c_coding_standard_2018.pdf

local snippets = {
    ms(
        {
            { trig = 'array_length', snippetType = 'snippet', condition = nil},
            { trig = 'array length', snippetType = 'autosnippet', condition = nil,},
        },
      fmt(
        [[
        size_t {ArrayRep}_length = sizeof({Array})/sizeof({ArrayRep}[0]);
        ]],
        {
            Array = i( 1, 'input_array'),
            ArrayRep = rep(1),
        }
      )
    ),

    ms(
        {
            { trig = 'hex_string',          snippetType = 'snippet', condition = nil },
            { trig = 'bytes_to_hex_string', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
    for (int i = 0; i < {Length}; i++)
    {{
        // Convert each byte to two hexadecimal characters
        sprintf({Destination} + i * 2, "%02{UpperLower}", {Source}[i]);
    }}
         ]],
            {
                Length = i(1, 'source_length'),
                Destination = i(2, 'destination'),
                UpperLower = c(3, {
                    t('X'),
                    t('x'),
                }),
                Source = i(4, 'source'),
            }
        )
    ),

    postfix('.function', {
        d(1, function(_, parent)
            return sn(nil, { t('[' .. parent.env.POSTFIX_MATCH .. ']') })
        end),
    }),

    ms(
        {
            { trig = 'vars',            snippetType = 'autosnippet', condition = nil },
            { trig = 'format_variable', snippetType = 'snippet',     condition = nil },
        },
        fmt([[{Variable}: {Type}, ]], {
            Variable = i(1, 'VariableName'),
            Type = i(2, '%s'),
        })
    ),
    ms(
        {
            { trig = 'STDINT', snippetType = 'autosnippet', condition = nil },
            { trig = 'stdint', snippetType = 'snippet',     condition = nil },
        },
        fmt([[{Types}]], {
            Types = c(1, {
                t('int8_t'),
                t('uint8_t'),
                t('int16_t'),
                t('uint16_t'),
                t('int32_t'),
                t('uint32_t'),
                t('int64_t'),
                t('uint64_t'),
                t('int8_t'),
                t('uint_least8_t'),
                t('int_least8_t'),
                t('uint_least16_t'),
                t('int_least16_t'),
                t('uint_least32_t'),
                t('int_least32_t'),
                t('uint_least64_t'),
                t('int_least64_t'),
                t('uint_fast8_t'),
                t('int_fast8_t'),
                t('uint_fast16_t'),
                t('int_fast16_t'),
                t('uint_fast32_t'),
                t('int_fast32_t'),
                t('uint_fast64_t'),
                t('int_fast64_t'),
                t('intmax_t'),
                t('uintmax_t'),
            }),
        })
    ),
    ms({
        { trig = 'void void', snippetType = 'autosnippet', condition = nil },
        { trig = 'noop',      snippetType = 'autosnippet', condition = nil },
        { trig = 'no op',     snippetType = 'autosnippet', condition = nil },
    }, fmt([[(void)0)]], {})),
    ms(
        {
            { trig = 'readline', snippetType = 'snippet', condition = nil },
            { trig = 'getline',  snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        char *line, length = 0;
        getline(&line, &length, stdin);
        fprintf(stderr, "input: %s, line: %d\n", line, length);
        ]],
            {}
        )
    ),
    ms(
        {
            { trig = 'readline_delimited', snippetType = 'snippet', condition = nil },
            { trig = 'getdelim',           snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        char *line, length = 0;
        getdelim(&line, &length, {Delimiter}, stdin);
        fprintf(stderr, "input: %s, line: %d\n", line, length);
        ]],
            { Delimiter = i(1, '0xFF') }
        )
    ),
    ms(
        {
            { trig = 'function_pointer', snippetType = 'snippet', condition = nil },
        },
        fmt([[typedef {Return} (*{Name})({Parameters});]], {
            Return = i(1, 'ReturnValueType'),
            Name = i(2, 'FunctionPointerName'),
            Parameters = i(3, 'int param1'),
        })
    ),
    ms(
        {
            { trig = 'to_int', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        atoi({String})
        ]],
            {
                String = i(1, 'char_array_to_int'),
            }
        )
    ),

    ms(
        {
            { trig = '#IF', snippetType = 'autosnippet', condition = conds.line_begin },
            { trig = '#if', snippetType = 'snippet',     condition = conds.line_begin },
        },
        fmt(
            [[
        #if {Condition}
            {Code}
        #endif
        ]],
            {
                Condition = i(1, '1'),
                Code = i(2),
            }
        )
    ),

    ms(
        {
            { trig = '#ELSE', snippetType = 'autosnippet', condition = conds.line_begin },
            { trig = '#else', snippetType = 'snippet',     condition = conds.line_begin },
        },
        fmt(
            [[
        #else
            {Code}
        ]],
            {
                Code = i(1),
            }
        )
    ),

    ms({
        { trig = 'brief',       snippetType = 'snippet',     condition = conds.line_begin },
        { trig = 'brief brief', snippetType = 'autosnippet', condition = conds.line_begin },
        { trig = '///',         snippetType = 'autosnippet', condition = conds.line_begin },
    }, shareable.clang_brief_function_documentation(1)),

    ms({
        { trig = '__function', snippetType = 'autosnippet', condition = nil },
    }, fmt([[__FUNCTION__]], {})),

    ms(
        {
            { trig = 'shell_command', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
    char shell_command[] = "{Command}";
    FILE *shell_command_file_pointer = popen(shell_command, "r");
    char shell_command_read_buffer[9000];
    memset(shell_command_read_buffer, 0, sizeof(shell_command_read_buffer));
    size_t commandSize = fread(buffer, 1, sizeof buffer, otaCommandScriptFilePointer);
    puts(shell_command_read_buffer);
        ]],
            { Command = i(1, 'protoc --help') }
        )
    ),

    ms(
        {
            { trig = 'string compare', snippetType = 'autosnippet', condition = nil },
            { trig = 'strcmp',         snippetType = 'autosnippet', condition = nil },
            { trig = 'strncmp',        snippetType = 'autosnippet', condition = nil },
            { trig = 'strcmp',         snippetType = 'snippet',     condition = nil },
            { trig = 'strncmp',        snippetType = 'snippet',     condition = nil },
        },
        fmt([[{Choices}]], {
            Choices = c(1, {

                -- Short version
                sn(
                    nil,
                    fmt(
                        [[
                strcmp({Source}, "{Value}") == {ReturnValue}
                ]],
                        {
                            Source = i(1, 'MyString'),
                            Value = i(2, 'Check for this'),
                            ReturnValue = i(3, '0'),
                        }
                    )
                ),

                -- Length check version
                sn(
                    nil,
                    fmt(
                        [[
                    strcmp({Source}, "{Value}", {MaximumLength}) == {ReturnValue}
                ]],
                        {
                            Source = i(1, 'MyString'),
                            Value = i(2, 'Check for this'),
                            MaximumLength = i(3, '10'),
                            ReturnValue = i(4, '0'),
                        }
                    )
                ),
            }),
        })
    ),

    ms(
        {
            { trig = 'ENUM', snippetType = 'autosnippet' },
            { trig = 'enum', snippetType = 'snippet' },
        },
        fmt(
            [[
        typedef enum {{
            {}
        }} {}_t;
        ]],
            {
                i(2),
                i(1, 'my_enum'),
            }
        )
    ),

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
            typedef struct {NameRep} {{
                {Inside}
            }} {Name}_t;
        ]],
            {
                NameRep = rep(1),
                Name = i(1, 'my_struct_t'),
                Inside = i(2),
            }
        )
    ),

    ms(
        {
            -- Normal printf
            'printf',
            { trig = 'PRINT',      snippetType = 'autosnippet' },

            -- fprintf
            'fprintf',
            { trig = 'ERRORPRINT', snippetType = 'autosnippet' },

            -- String format either sprintf or snprintf
            'snprintf',
            'sprintf',
            { trig = 'FRMAT',         snippetType = 'autosnippet' },
            { trig = 'string format', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        {}"{}"{});
        ]],
            {
                d(1, function(args, snip)
                    local choice_list = {
                        ['printf'] = t('printf('),
                        ['fprintf'] = sn(
                            nil,
                            fmt([[fprintf({FileHandle}, ]], {
                                FileHandle = c(1, {
                                    t('stderr'),
                                    t('stdout'),
                                    i(1, 'CUSTOM_FILE_HANDLE'),
                                }),
                            })
                        ),
                        ['snprintf'] = sn(
                            nil,
                            fmt([[snprintf({Variable}, {Length}, ]], {
                                Variable = i(1, 'Variable'),
                                Length = i(2, 'MAXIMUM_LENGTH'),
                            })
                        ),
                        ['sprintf'] = t('sprintf'),
                    }

                    local normalized_trigger_name = snip.trigger
                        :gsub('ERRORPRINT', 'fprintf')
                        :gsub('PRINT', 'printf')
                        :gsub('string format', 'snprintf')
                        :gsub('FRMAT', 'snprintf')

                    local choices = {}
                    table.insert(choices, choice_list[normalized_trigger_name])
                    choice_list[normalized_trigger_name] = nil
                    for _, value in pairs(choice_list) do
                        table.insert(choices, value)
                    end

                    return sn(
                        1,
                        fmt([[{}]], {
                            c(1, choices),
                        })
                    )
                end, {}),

                i(2),
                auxiliary.printf_style_dynamic_formatter(3, 2),
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

    ms(
        {
            {
                trig = 'memset',
                snippetType = 'snippet',
            },
        },
        fmt(
            [[
        memset({}, {}, {});
        ]],
            {
                i(1, 'target'),
                i(2, '0'),
                i(3, 'length_to_write'),
            }
        )
    ),

    ms(
        {
            { trig = 'malloc',        snippetType = 'snippet',     condition = nil },
            { trig = 'malloc malloc', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
        {DataType} {VariableName} = malloc(sizeof({DataTypeRep}) * {Size});
        {PointerCheck}
        ]],
            {
                DataType = i(1, 'int'),
                VariableName = i(2, 'variableName'),
                DataTypeRep = rep(1),
                Size = i(3, '50'),
                PointerCheck = sn(
                    4,
                    fmt([[{Choices}]], {
                        Choices = c(1, {
                            t(''),
                            sn(
                                nil,
                                fmt(
                                    [[
                                    if(VariableName == NULL)
                                    {{
                                         printf("malloc failed\n");
                                         exit(1);
                                    }}
                                    ]],
                                    {}
                                )
                            ),
                            sn(
                                nil,
                                fmt(
                                    [[
                            AUDIO_NULL_CHECK(TAG, _mallocd_memory_, return NULL);
                            ]],
                                    {}
                                )
                            ),
                        }),

                        -- ]],
                    })
                ),
                -- A shortcut for functionNodes that only do very basic string manipulation.
                -- l(lambda, argnodes):
                -- l(l._1:gsub('[*]', ''), { 2 }),
                -- rep(2),
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
    ms(
        {
            { trig = 'strtok_ez',    snippetType = 'snippet',     condition = nil },
            { trig = 'string split', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
      char separator[] = "{Separator}";
      for (char *p = strtok({SourceString}, separator); p != NULL; p = strtok(NULL, separator))
      {{
        {Code}
      }}
      ]],
            { Separator = i(1, ' '), SourceString = i(2, 'line'), Code = i(3, 'int number = atoi(p);') }
        )
    ),

    ms(
        {
            {
                trig = 'strtol',
                snippetType = 'snippet',
            },
        },
        fmt(
            [[
        {} {} = ({})strtol({}, NULL, {});
        ]],
            {
                i(1, 'int'),
                i(2, 'hex_string_to_int'),
                rep(1),
                i(3, 'hex_string'),
                c(4, {
                    t('16'),
                    t('8'),
                    t('2'),
                    t(
                        '0 - magic mode - will interpret non-zero leading number as decimal, leading 0 as octal, leading 0X as hex'
                    ),
                }),
            }
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

    ms(
        {
            { trig = 'string safe copy', snippetType = 'autosnippet' },
            'strncpy',
        },
        fmt([[strncpy({}, {}, {});]], {
            i(1, 'destination'),
            i(2, 'item_to_copy_from'),
            i(3, 'length'),
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

    ms(
        {
            { trig = 'sizeof', snippetType = 'snippet' },
            { trig = 'SIZEOF', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        sizeof({})
        ]],
            {
                i(1, 'int'),
            }
        )
    ),

    ms(
        {
            {
                trig = 'getdelim',
                snippetType = 'snippet',
            },
        },
        fmt(
            [[
        char *p, *l = 0;
        getdelim(&p, &l, 0xFF, stdin);
        ]],
            {}
        )
    ),

    ms(
        {
            { trig = 'network_udp', snippetType = 'snippet', condition = conds.line_begin },
            { trig = 'udp',         snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define BUFFER_SIZE 1024

int main(int argc, char *argv[])
{{
    int sockfd;
    struct sockaddr_in server_addr;
    char buffer[BUFFER_SIZE];
    const char *message = "Hello, UDP server!";

    // Check for correct number of arguments
    if (argc != 3)
    {{
        fprintf(stderr, "Usage: %s <SERVER_IP> <SERVER_PORT>\n", argv[0]);
        exit(EXIT_FAILURE);
    }}

    const char *server_ip = argv[1];
    int server_port = atoi(argv[2]);

    // Create a socket
    if ((sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0)
    {{
        perror("socket creation failed");
        exit(EXIT_FAILURE);
    }}

    // Set up the server address struct
    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET; // IPv4
    server_addr.sin_port = htons(server_port);

    // Convert IP address from text to binary form
    if (inet_pton(AF_INET, server_ip, &server_addr.sin_addr) <= 0)
    {{
        perror("Invalid address or address not supported");
        close(sockfd);
        exit(EXIT_FAILURE);
    }}

    // Send message to the server
    ssize_t sent_bytes =
        sendto(sockfd, message, strlen(message), 0, (const struct sockaddr *)&server_addr, sizeof(server_addr));
    if (sent_bytes < 0)
    {{
        perror("sendto failed");
        close(sockfd);
        exit(EXIT_FAILURE);
    }}

    printf("Message sent: %s\n", message);

    // Receive response from the server
    socklen_t addr_len = sizeof(server_addr);
    ssize_t received_bytes = recvfrom(sockfd, buffer, BUFFER_SIZE, 0, (struct sockaddr *)&server_addr, &addr_len);
    if (received_bytes < 0)
    {{
        perror("recvfrom failed");
        close(sockfd);
        exit(EXIT_FAILURE);
    }}

    buffer[received_bytes] = '\0'; // Null-terminate the received string
    printf("Received from server: %s\n", buffer);

    // Close the socket
    close(sockfd);
    return 0;
}}
        ]],
            {}
        )
    ),

    ms(
        {
            { trig = 'leapyear', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
int isLeapYear(int year)
{{
    return (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0));
}}
        ]],
            {}
        )
    ),
}

local autosnippets = {
    shareable.for_loop_c_style,
    shareable.if_statement_c_style,
    shareable.else_statement_c_style,
    shareable.while_loop_c_style,
    shareable.function_c_style,
    shareable.ternary,

    s(
        'var var',
        fmt(
            [[
      {}
      ]],
            {
                f(function()
                    local variable = my_treesitter_functions.c.get_recent_var()
                    return variable
                end, {}),
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

                    {}

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

    ms(
        {
            { trig = 'switch', snippetType = 'snippet' },
            { trig = 'SWITCH', snippetType = 'autosnippet' },
        },
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

    ms(
        {
            { trig = 'case',      snippetType = 'snippet' },
            { trig = 'case case', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        case {}:
            {}
            break;
        ]],
            {
                i(1, 'item'),
                i(2),
            }
        )
    ),
}

-- Add snippets dynamically to the snippets table using just C library proto types
local prototypes = {
    -- <assert.h>
    'void assert(int expression)',

    -- <ctype.h>
    'int isalpha(int c)',
    'int isdigit(int c)',
    'int isalnum(int c)',
    'int ispunct(int c)',
    'int isspace(int c)',
    'int isupper(int c)',
    'int islower(int c)',
    'int toupper(int c)',
    'int tolower(int c)',

    -- <locale.h>
    'char *setlocale(int category, const char *locale)',
    'locale_t newlocale(int category, const char *locale, locale_t base)',
    'void freelocale(locale_t locale)',
    'locale_t duplocale(locale_t locale)',

    -- <math.h>
    'double fabs(double x)',
    'double floor(double x)',
    'double ceil(double x)',
    'double sqrt(double x)',
    'double pow(double x, double y)',
    'double exp(double x)',
    'double log(double x)',
    'double log10(double x)',
    'double sin(double x)',
    'double cos(double x)',
    'double tan(double x)',
    'double sinh(double x)',
    'double cosh(double x)',
    'double tanh(double x)',
    'double asin(double x)',
    'double acos(double x)',
    'double atan(double x)',
    'double atan2(double y, double x)',

    -- <setjmp.h>
    'void longjmp(jmp_buf env, int val)',
    'int setjmp(jmp_buf env)',

    -- <signal.h>
    'sig_atomic_t signal(int signum, void (*handler)(int))',
    'int raise(int sig)',

    -- <stdarg.h>
    'void va_start(va_list ap, last_arg)',
    'void va_end(va_list ap)',
    'void va_copy(va_list dest, va_list src)',
    'int vsprintf(char *str, const char *format, va_list ap)',

    -- <stdio.h>
    'void clearerr(FILE *stream)',
    'int fclose(FILE *stream)',
    'int fflush(FILE *stream)',
    'int fgetc(FILE *stream)',
    'char *fgets(char *str, int n, FILE *stream)',
    'int fprintf(FILE *stream, const char *format, ...)',
    'int fscanf(FILE *stream, const char *format, ...)',
    'int fputc(int c, FILE *stream)',
    'int fputs(const char *str, FILE *stream)',
    'void perror(const char *s)',
    'int printf(const char *format, ...)',
    'int puts(const char *str)',
    'int scanf(const char *format, ...)',
    'int sprintf(char *str, const char *format, ...)',
    'int sscanf(const char *str, const char *format, ...)',
    'int vfprintf(FILE *stream, const char *format, va_list arg)',
    'int vprintf(const char *format, va_list arg)',
    'int vsprintf(char *str, const char *format, va_list arg)',
    -- GNU libc stdio
    'int fcloseall(void)',
    'int fileno(FILE *stream)',
    'char *fgetwc(FILE *stream)',
    'int fgetws(wchar_t *ws, int n, FILE *stream)',
    'int fputwc(wchar_t wc, FILE *stream)',
    'int fputws(const wchar_t *ws, FILE *stream)',
    'FILE *fopen(const char *filename, const char *mode)',
    'FILE *freopen(const char *filename, const char *mode, FILE *stream)',
    'int fscanf(FILE *stream, const char *format, ...)',
    'int fseek(FILE *stream, long offset, int whence)',
    'int fseeko(FILE *stream, off_t offset, int whence)',
    'long ftell(FILE *stream)',
    'off_t ftello(FILE *stream)',
    'int fwrite(const void *ptr, size_t size, size_t count, FILE *stream)',
    'char *getdelim(char **lineptr, size_t *n, int delimiter, FILE *stream)',
    'char *getline(char **lineptr, size_t *n, FILE *stream)',
    'int getchar(void)',
    'char *gets(char *str)',
    'int getc(FILE *stream)',
    'int putc(int c, FILE *stream)',
    'void setbuf(FILE *stream, char *buf)',
    'int setvbuf(FILE *stream, char *buf, int mode, size_t size)',
    'int ungetc(int c, FILE *stream)',
    'int vprintf(const char *format, va_list arg)',
    'int vfprintf(FILE *stream, const char *format, va_list arg)',
    'int vsprintf(char *str, const char *format, va_list arg)',
    'void rewind(FILE *stream)',
    'void setvbuf(FILE *stream, char *buf, int mode, size_t size)',

    -- <stdlib.h>
    'void *malloc(size_t size)',
    'void *calloc(size_t num, size_t size)',
    'void *realloc(void *ptr, size_t size)',
    'void free(void *ptr)',
    'int abs(int n)',
    'long int labs(long int n)',
    'double atof(const char *str)',
    'int atoi(const char *str)',
    'long int atol(const char *str)',
    'float strtof(const char *str, char **endptr)',
    'int rand(void)',
    'void srand(unsigned int seed)',
    'void exit(int status)',
    'char *getenv(const char *name)',

    -- <string.h>
    'char *strcpy(char *dest, const char *src)',
    'char *strncpy(char *dest, const char *src, size_t n)',
    'char *strcat(char *dest, const char *src)',
    'char *strncat(char *dest, const char *src, size_t n)',
    'int strcmp(const char *str1, const char *str2)',
    'int strncmp(const char *str1, const char *str2, size_t n)',
    'int strcoll(const char *str1, const char *str2)',
    'size_t strlen(const char *str)',
    'char *strchr(const char *str, int c)',
    'char *strrchr(const char *str, int c)',
    'char *strstr(const char *haystack, const char *needle)',
    'char *strtok(char *str, const char *delim)',
    'void *memset(void *s, int c, size_t n)',
    'void *memcpy(void *dest, const void *src, size_t n)',
    'void *memmove(void *dest, const void *src, size_t n)',
    'int memcmp(const void *ptr1, const void *ptr2, size_t num)',
    'char *strdup(const char *str)',
    'size_t strcspn(const char *str1, const char *str2)',
    'size_t strspn(const char *str1, const char *str2)',

    -- <time.h>
    'time_t time(time_t *tloc)',
    'struct tm *localtime(const time_t *timer)',
    'struct tm *gmtime(const time_t *timer)',
    'time_t mktime(struct tm *tm)',
    'difftime(time_t end, time_t beginning)',
    'char *asctime(const struct tm *tm)',
    'char *ctime(const time_t *timer)',
}

for index, value in pairs(prototypes) do
    local return_type, function_name = value:match('(%S+%s+%*?)(%w+)')
    local args = value:match('%((.*)%)'):gmatch('([^,]+)')

    local args_table = {}
    local index = 1
    for arg in args do
        table.insert(args_table, i(index, arg))
        index = index + 1
        table.insert(args_table, t(','))
    end
    table.remove(args_table, #args_table)

    table.insert(
        snippets,
        ms(
            {
                { trig = '_' .. function_name, snippetType = 'snippet', condition = nil },
            },
            fmt([[{ReturnValue}{FunctionName}({Args});]], {
                ReturnValue = d(1, function(args, snip)
                    if return_type == 'void' then
                        return t('')
                    else
                        return sn(
                            nil,
                            c(1, {
                                t(''),
                                sn(
                                    nil,
                                    fmt([[{ReturnType}{VariableName} = ]], {
                                        ReturnType = i(1, return_type),
                                        VariableName = i(2, string.format('%s_return', function_name)),
                                    })
                                ),
                            })
                        )
                    end
                end, {}),
                -- ReturnValue = ,
                FunctionName = t(function_name),
                Args = sn(2, args_table),
            })
        )
    )
end

return snippets, autosnippets
