---@diagnostic disable: undefined-global

--[[
See https://docs.espressif.com/projects/esp-idf/en/stable/esp32/api-reference/kconfig.html
Kconfig rules

Option names in any menus should have consistent prefixes. The prefix currently should have at least 3 characters.
The unit of indentation should be 4 spaces. All sub-items belonging to a parent item are indented by one level deeper. For example, menu is indented by 0 spaces, config menu by 4 spaces, help in config by 8 spaces, and the text under help by 12 spaces.
No trailing spaces are allowed at the end of the lines.
The maximum length of options is 50 characters.
The maximum length of lines is 120 characters.
]]

local function kconfig_item(index)
    return sn(
        index,
        fmt(
            [[
    config {Name}
        {Type} "{BasicDescription}"
        default {Value}
        help
            {Help}
                ]],
            {
                Name = i(1, 'CONFIGURATION_NAME_WRITTEN_LIKE_THIS'),
                Type = c(2, {
                    t('bool'),
                    t('string'),
                }),
                BasicDescription = i(3, 'Basic description of this item'),

                Value = c(4, {
                    t('y'),
                    t('n'),
                    sn(
                        nil,
                        fmt([["{Text}"]], {
                            Text = i(1, 'custom text'),
                        })
                    ),
                }),

                Help = i(5, 'Detailed description of this item'),
            }
        )
    )
end

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

    ms(
        {
            { trig = 'kconfig_menu', snippetType = 'snippet',     condition = nil },
            { trig = 'FIRST',        snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
        menu "{MenuName}"
            {Content}
            {}
        endmenu
        ]],
            {
                MenuName = i(1, 'Name of menu e.g. Console configuration'),
                Content = kconfig_item(2),
                i(3),
            }
        )
    ),

    ms(
        {
            { trig = 'kconfig_item', snippetType = 'snippet',     condition = nil },
            { trig = 'SECOND',       snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
        {Content}
        ]],
            {
                Content = kconfig_item(1),
            }
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
