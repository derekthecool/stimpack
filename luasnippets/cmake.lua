---@diagnostic disable: undefined-global

local snippets = {

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
}

local autosnippets = {
    s(
        'trigger',
        fmt(
            [[
       ]],
            {}
        )
    ),
}

return snippets, autosnippets
