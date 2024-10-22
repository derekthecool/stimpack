---@diagnostic disable: undefined-global
local snippets = {

    -- Flutter key-store creation step one
    ms(
        {
            { trig = 'keystoreProperties-part1-above-android-block', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
        // Should be right above the 'android { .... } block
        def keystoreProperties = new Properties()
        def keystorePropertiesFile = rootProject.file('key.properties')
        if (keystorePropertiesFile.exists()) {
            keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
        }
        ]],
            {},
            { delimiters = '<>' }
        )
    ),

    ms(
        {
            {
                trig = 'keystoreProperties-part2-replaces-buildTypes-inside-android-block',
                snippetType = 'snippet',
                condition = conds.line_begin,
            },
        },
        fmt(
            [[
    // Should replace the buildTypes from flutter create template
    signingConfigs {
         release {
             keyAlias = keystoreProperties['keyAlias']
             keyPassword = keystoreProperties['keyPassword']
              storeFile = keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
             storePassword = keystoreProperties['storePassword']
         }
     }
     buildTypes {
         release {
             // TODO: Add your own signing config for the release build.
             // Signing with the debug keys for now,
             // so `flutter run --release` works.
             signingConfig = signingConfigs.debug
             signingConfig = signingConfigs.release
         }
     }
        ]],
            {},
            { delimiters = '<>' }
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
