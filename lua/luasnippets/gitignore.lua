---@diagnostic disable: undefined-global
local snippets = {
    s(
        'esp-idf',
        fmt(
            [[
         build/
         sdkconfig
         sdkconfig.old

         compile_commands.json
         ]],
            {}
        )
    ),

    ms(
        {
            { trig = 'FIRST', snippetType = 'autosnippet' },
        },
        fmt([[ {} ]], {
            c(1, {
                sn(
                    nil,
                    fmt(
                        [[
                        # Flutter / Dart gitignore
                        # Miscellaneous
                        *.class
                        *.log
                        *.pyc
                        *.swp
                        .DS_Store
                        .atom/
                        .buildlog/
                        .history
                        .svn/
                        migrate_working_dir/

                        # IntelliJ related
                        *.iml
                        *.ipr
                        *.iws
                        .idea/

                        # The .vscode folder contains launch configuration and tasks you configure in
                        # VS Code which you may wish to be included in version control, so this line
                        # is commented out by default.
                        #.vscode/

                        # Flutter/Dart/Pub related
                        **/doc/api/
                        **/ios/Flutter/.last_build_id
                        .dart_tool/
                        .flutter-plugins
                        .flutter-plugins-dependencies
                        .pub-cache/
                        .pub/
                        /build/

                        # Symbolication related
                        app.*.symbols

                        # Obfuscation related
                        app.*.map.json

                        # Android Studio will place build artifacts here
                        /android/app/debug
                        /android/app/profile
                        /android/app/release
                ]],
                        {}
                    )
                ),
            }),
        })
    ),
}

local autosnippets = {}

return snippets, autosnippets
