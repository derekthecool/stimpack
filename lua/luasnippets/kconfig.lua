---@diagnostic disable: undefined-global
local snippets = {
    ms(
        {
            { trig = 'kconfig_wifi', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
menu "wifi settings"
    config WIFI_SSID
        string "WiFi SSID"
        default "FreeusWiFi"
        help
            SSID (network name) for the example to connect to.

    config WIFI_PASSWORD
        string "WiFi Password"
        default "mypassword"
        help
            WiFi password (WPA or WPA2) for the example to use.
endmenu
    ]],
            {}
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
