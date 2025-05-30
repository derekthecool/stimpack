---@diagnostic disable: undefined-global

local snippets = {
    ms(
        {
            { trig = 'PRINT',           snippetType = 'autosnippet', condition = nil },
            { trig = 'message',         snippetType = 'snippet',     condition = nil },
            { trig = 'message message', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
        message("{Message}")
        ]],
            {
                Message = i(1, 'Print message here, will show up during cmake build'),
            }
        )
    ),

    ms(
        {
            { trig = 'glob',      snippetType = 'snippet',     condition = nil },
            { trig = 'glob glob', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
        file({GlobType} {Variable} "{Pattern}")
        ]],
            {
                GlobType = c(1, {
                    t('GLOB_RECURSE'),
                    t('GLOB'),
                }),
                Variable = i(2, 'SOURCES'),
                Pattern = i(3, '*.c'),
            }
        )
    ),
    ms(
        {
            { trig = 'cross_compile', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
# https://kubasejdak.com/how-to-cross-compile-for-embedded-with-cmake-like-a-champ
set(CMAKE_SYSTEM_NAME               Generic)
set(CMAKE_SYSTEM_PROCESSOR          arm)

# Without that flag CMake is not able to pass test compilation check
set(CMAKE_TRY_COMPILE_TARGET_TYPE   STATIC_LIBRARY)

set(BAREMETAL_ARM_TOOLCHAIN_PATH "/usr/bin/")

set(CMAKE_AR                        ${BAREMETAL_ARM_TOOLCHAIN_PATH}arm-none-eabi-ar${CMAKE_EXECUTABLE_SUFFIX})
set(CMAKE_ASM_COMPILER              ${BAREMETAL_ARM_TOOLCHAIN_PATH}arm-none-eabi-gcc${CMAKE_EXECUTABLE_SUFFIX})
set(CMAKE_C_COMPILER                ${BAREMETAL_ARM_TOOLCHAIN_PATH}arm-none-eabi-gcc${CMAKE_EXECUTABLE_SUFFIX})
set(CMAKE_CXX_COMPILER              ${BAREMETAL_ARM_TOOLCHAIN_PATH}arm-none-eabi-g++${CMAKE_EXECUTABLE_SUFFIX})
set(CMAKE_LINKER                    ${BAREMETAL_ARM_TOOLCHAIN_PATH}arm-none-eabi-ld${CMAKE_EXECUTABLE_SUFFIX})
set(CMAKE_OBJCOPY                   ${BAREMETAL_ARM_TOOLCHAIN_PATH}arm-none-eabi-objcopy${CMAKE_EXECUTABLE_SUFFIX} CACHE INTERNAL "")
set(CMAKE_RANLIB                    ${BAREMETAL_ARM_TOOLCHAIN_PATH}arm-none-eabi-ranlib${CMAKE_EXECUTABLE_SUFFIX} CACHE INTERNAL "")
set(CMAKE_SIZE                      ${BAREMETAL_ARM_TOOLCHAIN_PATH}arm-none-eabi-size${CMAKE_EXECUTABLE_SUFFIX} CACHE INTERNAL "")
set(CMAKE_STRIP                     ${BAREMETAL_ARM_TOOLCHAIN_PATH}arm-none-eabi-strip${CMAKE_EXECUTABLE_SUFFIX} CACHE INTERNAL "")

set(CMAKE_C_FLAGS "-mcpu=cortex-a7 -mfloat-abi=hard -mfpu=neon")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mcpu=cortex-a7 -mfloat-abi=hard -mfpu=neon")

set(CMAKE_C_FLAGS_DEBUG             "-Os -g" CACHE INTERNAL "")
set(CMAKE_C_FLAGS_RELEASE           "-Os -DNDEBUG" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS_DEBUG           "${CMAKE_C_FLAGS_DEBUG}" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS_RELEASE         "${CMAKE_C_FLAGS_RELEASE}" CACHE INTERNAL "")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)


# # arm-none-eabi-toolchain.cmake
# set(CMAKE_SYSTEM_NAME Generic)
# set(CMAKE_SYSTEM_PROCESSOR arm)
#
# # Specify the cross compiler
# set(CMAKE_C_COMPILER arm-none-eabi-gcc)
# set(CMAKE_CXX_COMPILER arm-none-eabi-g++)
# set(CMAKE_ASM_COMPILER arm-none-eabi-as)
#
# # Specify the path to the ARM toolchain (optional)
# set(CMAKE_FIND_ROOT_PATH /path/to/your/toolchain)
#
# # Search for programs in the build host directories
# set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
#
# # For libraries and headers in the cross-compilation
# set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
# set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
        ]],
            {},
            { delimiters = '<>' }
        )
    ),
    ms(
        {
            {
                trig = 'add_test',
                snippetType = 'snippet',
            },
        },
        fmt(
            [[
        add_test({} {})
        ]],
            {
                i(1, 'TestName'),
                i(2, 'commands...'),
            }
        )
    ),

    ms(
        {
            {
                trig = '==',
                snippetType = 'autosnippet',
            },
        },
        fmt(
            [[
        {}
        ]],
            {
                c(1, {
                    -- Strings
                    t('STREQUAL'),
                    t('STRLESS'),
                    t('STRGREATER'),
                    -- REGEX
                    t('MATCHES'),
                    -- NUMBERS
                    t('EQUAL'),
                    t('LESS'),
                    t('GREATER'),
                    -- LOGICAL
                    t('AND'),
                    t('OR'),
                    t('NOT'),
                    -- LISTS
                    t('IN_LIST'),
                    -- FILE CHECKS
                    t('EXISTS'),
                    t('IS_DIRECTORY'),
                    t('IS_FILE'),
                }),
            }
        )
    ),

    ms(
        {
            {
                trig = 'add_compile_definitions',
                snippetType = 'snippet',
            },
        },
        fmt(
            [[
        # Preprocess definitions to add
        # Use the syntax of VAR or VAR=value
        add_compile_definitions({})
        ]],
            {
                i(1, 'INCLUDE_MQTT'),
            }
        )
    ),

    s(
        'file',
        fmt(
            [[
        # Copy the file to build always
        file(COPY ${{CMAKE_CURRENT_SOURCE_DIR}}/{}
             DESTINATION ${{CMAKE_CURRENT_BINARY_DIR}})
        ]],
            {
                i(1),
            }
        )
    ),
    s(
        'configure_file',
        fmt(
            [[
        # Copy the file to build and rerun project if modified
        configure_file(COPY ${{CMAKE_CURRENT_SOURCE_DIR}}/{}
             DESTINATION ${{CMAKE_CURRENT_BINARY_DIR}} COPYONLY)
        ]],
            {
                i(1),
            }
        )
    ),

    s(
        'project',
        fmt(
            [[
        project({}
            LANGUAGES C
            DESCRIPTION "project description")
        ]],
            {
                i(1, 'ProjectName'),
            }
        )
    ),

    s(
        'add_executable',
        fmt(
            [[
        add_executable({}
            # Sources
            {})
        ]],
            {
                i(1, 'ProgramName'),
                i(2, 'main.c'),
            }
        )
    ),

    s(
        'add_library',
        fmt(
            [[
        add_library({} {}
            # Sources
            {})
        ]],
            {
                i(1, 'LibraryName'),
                c(2, {
                    t('STATIC'),
                    t('DYNAMIC'),
                }),

                i(3, 'file.c'),
            }
        )
    ),

    s(
        'target_link_libraries',
        fmt(
            [[
        target_link_libraries({} {})
        ]],
            {
                i(1, 'ProgramName'),
                i(2, 'LibraryName'),
            }
        )
    ),

    -- ESP32 stuff
    ms(
        {
            { trig = 'idf_component_register', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        idf_component_register(SRCS {Sources}
            REQUIRES {PublicRequires}
            PRIV_REQUIRES {PrivateRequires}
            INCLUDE_DIRS "."
        )
        ]],
            { Sources = i(1, 'main.c'), PublicRequires = i(2, 'efuse'), PrivateRequires = i(3, 'mqtt') }
        )
    ),
    -- ESP32 stuff end

    -- {{{ Cmake C library and test app for test driven development (tdd) setup
    s(
        {
            trig = '_Ctdd',
            descr = 'Easy cmake tdd setup for a C project',
        },

        fmt(
            [[
    cmake_minimum_required(VERSION {})

    #Set debug mode
    set(CMAKE_BUILD_TYPE Debug)

    #Export compile commands json file, this is needed for project autocomplete

    set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

    #Set variable to use for project name and main file
    set(ProjectBasename "{}")

    #Set project name, description, and language
    project({}
        LANGUAGES C
        DESCRIPTION "{}"
        )

    #Set static library
    add_library({} STATIC
        {}.c
        {}.h
        )

    # Enable Cmake built-in unit testing, needs to be declared once for entire project
    include(CTest)

    # Add test application
    add_executable({}_test
        {}_test.c
        )

    # Link the static library to the test application
    target_link_libraries({})

    #Use the newest C standard (C11)
    set_property(TARGET {}      PROPERTY C_STANDARD 11)
    set_property(TARGET {}_test PROPERTY C_STANDARD 11)

    # Tests can pass or fail in two ways:
    # 1. Default method is to check the return code.
    #
    #    Return value of:             0 == pass
    #    Return value of: anything else == fail
    #
    # 2. You can read the output and filter with a regular expression. Note that
    #    stderr and stdout will all be checked, not just stdout.
    #
    #    PASS_REGULAR_EXPRESSION: if output matches, the test will pass
    #    FAIL_REGULAR_EXPRESSION: if output matches, the test will fail
    #
    #  ____  _                 _     _   ____
    # / ___|| |__   ___  _   _| | __| | |  _ \ __ _ ___ ___
    # \___ \| '_ \ / _ \| | | | |/ _\` | | |_) / _\` / __/ __|
    #  ___) | | | | (_) | |_| | | (_| | |  __/ (_| \__ \__ \
    # |____/|_| |_|\___/ \__,_|_|\__,_| |_|   \__,_|___/___/
    #--------------------------------
    add_test(${}_ShouldPass {}_test "${}")

    # Tests that are supposed to fail (return value != 0)
    #  ____  _                 _     _   _____     _ _
    # / ___|| |__   ___  _   _| | __| | |  ___|_ _(_) |
    # \___ \| '_ \ / _ \| | | | |/ _\` | | |_ / _\` | | |
    #  ___) | | | | (_) | |_| | | (_| | |  _| (_| | | |
    # |____/|_| |_|\___/ \__,_|_|\__,_| |_|  \__,_|_|_|
    #--------------------------------
    add_test(${}_ShouldFail {}_test "${}")
    ]],
            {
                i(1, ' 3.10.2'),
                i(2, 'ProjectName'),
                rep(2),
                i(3, 'Description'),
                -- Repeat this field 8 times
                rep(2),
                rep(2),
                rep(2),
                rep(2),
                rep(2),
                rep(2),
                rep(2),
                rep(2),
                i(4, 'Test1'),
                rep(2),
                i(5, 'PassInput'),
                rep(4),
                rep(2),
                i(6, 'FailInput'),
            }
        )
    ),
    -- }}}

    -- {{{ Cmake C executable
    s(
        {
            trig = 'Capp',
            descr = 'Easy C cmake app setup',
        },

        fmt(
            [[
    cmake_minimum_required(VERSION {})

    #Set debug mode
    set(CMAKE_BUILD_TYPE Debug)

    #Export compile commands json file, this is needed for project autocomplete
    set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

    #Set variable to use for project name and main file
    set(ProjectBasename "{}")
    set(MainSource "{}.c")

    #Set project name and specify C compiler
    project({} C)

    #Set executable
    add_executable({} ${{MainSource}})
    ]],
            {
                i(1, ' 3.10.2'),
                i(2, 'ProjectName'),
                rep(2),
                rep(2),
                rep(2),
            }
        )
    ),
    -- }}}

    ms(
        {
            { trig = 'compile_commands.json',   snippetType = 'snippet', condition = nil },
            { trig = 'export_compile_commands', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
    # Generate compile_commands.json for LSP autocomplete
    set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
    ]],
            {}
        )
    ),

    s(
        'variable_watch',
        fmt(
            [[
variable_watch({})

        ]],
            {

                i(1, 'EXTRA_COMPONENT_DIRS'),
            }
        )
    ),

    s(
        'threads',
        fmt(
            [[
        # If having errors finding threads use this
        # https://stackoverflow.com/questions/54587052/cmake-on-mac-could-not-find-threads-missing-threads-found
        set(CMAKE_THREAD_LIBS_INIT "-lpthread")
        set(CMAKE_HAVE_THREADS_LIBRARY 1)
        set(CMAKE_USE_WIN32_THREADS_INIT 0)
        set(CMAKE_USE_PTHREADS_INIT 1)
        set(THREADS_PREFER_PTHREAD_FLAG ON)
        ]],
            {}
        )
    ),

    -- Lua embed build setup
    s(
        'lua setup',
        fmt(
            [[
        # Add these if using newer lua like 5.4.6: lctype.c lcorolib.c lutf8lib.c
        add_library("lua" STATIC
            ./lua-5.1.5/src/lapi.c
            ./lua-5.1.5/src/lcode.c
            ./lua-5.1.5/src/ldebug.c
            ./lua-5.1.5/src/ldo.c
            ./lua-5.1.5/src/ldump.c
            ./lua-5.1.5/src/lfunc.c
            ./lua-5.1.5/src/lgc.c
            ./lua-5.1.5/src/llex.c
            ./lua-5.1.5/src/lmem.c
            ./lua-5.1.5/src/lobject.c
            ./lua-5.1.5/src/lopcodes.c
            ./lua-5.1.5/src/lparser.c
            ./lua-5.1.5/src/lstate.c
            ./lua-5.1.5/src/lstring.c
            ./lua-5.1.5/src/ltable.c
            ./lua-5.1.5/src/ltm.c
            ./lua-5.1.5/src/lundump.c
            ./lua-5.1.5/src/lvm.c
            ./lua-5.1.5/src/lzio.c
            ./lua-5.1.5/src/lauxlib.c
            ./lua-5.1.5/src/lbaselib.c
            ./lua-5.1.5/src/ldblib.c
            ./lua-5.1.5/src/liolib.c
            ./lua-5.1.5/src/lmathlib.c
            ./lua-5.1.5/src/loslib.c
            ./lua-5.1.5/src/ltablib.c
            ./lua-5.1.5/src/lstrlib.c
            ./lua-5.1.5/src/loadlib.c
            ./lua-5.1.5/src/linit.c
            )

        # Copy a lua script file from source directory to build directory
        configure_file(${{CMAKE_CURRENT_SOURCE_DIR}}/script.lua
            ${{CMAKE_CURRENT_BINARY_DIR}} COPYONLY)

        target_link_libraries(Luatest lua)
        ]],
            {}
        )
    ),

    s(
        'lua idf_component_register',
        fmt(
            [[
        idf_component_register("lua"
            SRCS
            "lua515/src/lapi.c"
            "lua515/src/lcode.c"
            "lua515/src/ldebug.c"
            "lua515/src/ldo.c"
            "lua515/src/ldump.c"
            "lua515/src/lfunc.c"
            "lua515/src/lgc.c"
            "lua515/src/llex.c"
            "lua515/src/lmem.c"
            "lua515/src/lobject.c"
            "lua515/src/lopcodes.c"
            "lua515/src/lparser.c"
            "lua515/src/lstate.c"
            "lua515/src/lstring.c"
            "lua515/src/ltable.c"
            "lua515/src/ltm.c"
            "lua515/src/lundump.c"
            "lua515/src/lvm.c"
            "lua515/src/lzio.c"
            "lua515/src/lauxlib.c"
            "lua515/src/lbaselib.c"
            "lua515/src/ldblib.c"
            "lua515/src/liolib.c"
            "lua515/src/lmathlib.c"
            "lua515/src/loslib.c"
            "lua515/src/ltablib.c"
            "lua515/src/lstrlib.c"
            "lua515/src/loadlib.c"
            "lua515/src/linit.c"
            INCLUDE_DIRS
            "lua515/src"
            )

        # Ignore this error in the lua library
        target_compile_options(${{COMPONENT_LIB}} PRIVATE -Wno-error=misleading-indentation)
        ]],
            {}
        )
    ),

    ms(
        {
            {
                trig = 'set_tests_properties',
                snippetType = 'snippet',
            },
        },
        fmt(
            [[
    set_tests_properties(
        # Tests
        {}

        PROPERTIES
        # The test is passed if stdout matches this
        PASS_REGULAR_EXPRESSION "{}"
        # The test is a failure if stdout matches this
        FAIL_REGULAR_EXPRESSION "{}"
        # The test will be marked as skipped if stdout matches this
        SKIP_REGULAR_EXPRESSION "{}"
    )
        ]],
            {
                i(1, 'MyTest1'),
                i(2, '.*Test Passed.*'),
                i(3, '.*Test Failed.*'),
                i(4, '.*Skip this test.*'),
            }
        )
    ),

    ms(
        {
            { trig = 'option', snippetType = 'snippet' },
        },
        fmt(
            [[
        option({} "{}" {})
        ]],
            {
                i(1, 'DEFINE_ITEM_NAME'),
                i(2, 'Prompt: should this feature be included?'),
                c(3, {
                    t('OFF'),
                    t('ON'),
                    i(1, 'custom_value'),
                }),
            }
        )
    ),

    ms(
        {
            { trig = 'FREACH', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        foreach({} ${{{}}})
            message("Current item: ${{{}}}")
            {}
        endforeach()
        ]],
            {
                i(1, 'item'),
                i(2, 'source_list'),
                rep(1),
                i(3),
            }
        )
    ),

    ms(
        {
            { trig = 'list', snippetType = 'snippet' },
        },
        fmt(
            [[
    list({})
        ]],
            {

                c(1, {
                    t('GET listVariable 1 outputIndexedVariable'),
                }),
            }
        )
    ),

    ms(
        {
            { trig = 'FUNCTION', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        function({FunctionName} {Parameters})
            {}
        endfunction()
        ]],
            {
                FunctionName = i(1, 'FunctionName'),
                Parameters = i(2, 'params...'),
                i(3),
            }
        )
    ),

    ms(
        {
            { trig = 'target_include_directories', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
        target_include_directories(
            ${{{LibraryOrProgram}}}
            PRIVATE
            "${{CMAKE_CURRENT_BINARY_DIR}}/{Files}"
        )
        ]],
            {
                LibraryOrProgram = i(1, 'ProgramName'),
                Files = i(2, 'Files'),
            }
        )
    ),
}

local autosnippets = {
    s(
        'FIRST',
        fmt(
            [[
        cmake_minimum_required(VERSION {})
        ]],
            {
                f(function(args, snip)
                    local DEFAULT = '3.17'
                    local cmakeVersion = Execute('cmake --version')
                    if cmakeVersion.stdout ~= nil then
                        -- Remove anything that is not a number or a .to get the version string
                        return (cmakeVersion.stdout[1]:gsub('[^0-9.]', ''))
                    else
                        return DEFAULT
                    end
                end, {}),
            }
        )
    ),

    ms(
        {
            { trig = 'SECOND', snippetType = 'autosnippet' },
            { trig = 'set',    snippetType = 'snippet' },
        },
        fmt(
            [[
        set({} {})
        ]],
            {
                i(1, 'Variable'),
                i(2, 'Value'),
            }
        )
    ),

    ms(
        {
            { trig = 'string', snippetType = 'snippet' },
            { trig = 'THIRD',  snippetType = 'autosnippet' },
        },
        fmt(
            [[
        # String commands, some take multiple arguments
        string({} {})
        ]],
            {
                c(1, {
                    t('CONCAT'),
                    t('LENGTH'),
                    t('SUBSTRING'),
                    t('STRIP'),
                    t('FIND'),
                    t('REPLACE'),
                    t('TOLOWER'),
                    t('TOUPPER'),
                    t('REPEAT'),
                    t('GENEX_STRIP'),
                }),
                i(2, 'inputString'),
            }
        )
    ),

    ms(
        {
            {
                trig = 'IF',
                snippetType = 'autosnippet',
            },
            { trig = 'if', snippetType = 'snippet', condition = nil,},
        },
        fmt(
            [[
        if({})
            {}
        endif()
        ]],
            {
                i(1, 'TRUE'),
                d(2, function(args, snip)
                    local nodes = {}

                    -- Add nodes for snippet
                    table.insert(nodes, i(1))

                    table.insert(
                        nodes,
                        d(2, function(args, snip)
                            local nodes = {}

                            -- Add nodes for snippet
                            if args ~= nil and args[1] ~= nil then
                                for _, value in ipairs(args[1]) do
                                    local else_if = 'TTT'
                                    if value:match(else_if) then
                                        -- table.insert(nodes, t('-- ' .. value))
                                        table.insert(nodes, t({ '', 'elseif(' }))
                                        table.insert(nodes, i(1))
                                        table.insert(nodes, t({ ')', '' }))
                                        vim.api.nvim_cmd({
                                            cmd = '%s/' .. else_if .. '//',
                                            args = {},
                                        }, {
                                            silent = true,
                                            emsg_silent = true,
                                        })
                                    end
                                end
                            end

                            return sn(nil, nodes)
                        end, { 1 })
                    )

                    return sn(nil, nodes)
                end, {}),
            }
        )
    ),

    ms(
        {
            { trig = '$$', wordtrig = false, snippetType = 'autosnippet' },
            { trig = '${', wordtrig = false, snippetType = 'autosnippet' },
        },
        fmt(
            [[
        ${{{}}}
        ]],
            {
                i(1, 'variable'),
            }
        )
    ),
}

return snippets, autosnippets
