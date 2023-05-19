---@diagnostic disable: undefined-global

local snippets = {

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
    s(
        'idf_component_register',
        fmt(
            [[
        idf_component_register("{}"
            {})
        ]],
            {
                i(1, 'library_name'),
                i(2, 'source.c'),
            }
        )
    ),

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

    s(
        'export compile',
        fmt(
            [[
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
    ]],
            {}
        )
    ),

    s(
        'message',
        fmt(
            [[
        message({})
        ]],
            {
                i(1, '"Error here"'),
            }
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
        {
          
        }
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
        {
          
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

    s(
        'SECOND',
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
}

return snippets, autosnippets
