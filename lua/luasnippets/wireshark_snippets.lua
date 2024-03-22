---@diagnostic disable: undefined-global, missing-parameter
-- Wireshark plugin snippets

-- Wireshark lua plugin helpers
local wireshark_plugin_details = function(index)
    return sn(
        index,
        fmt(
            [[
set_plugin_info({{
    version = '{Version}',
    author = '{Author}',
    description = '{Description}',
    repository = '{Repository}',
}})
]],
            {
                Version = i(1, '1.0.0'),
                Author = i(2, 'Derek Lomax'),
                Description = i(3, 'This is my awesome wireshark plugin that does something great'),
                Repository = i(4, 'repo source'),
            }
        )
    )
end

local snippets = {
    s(
        'wireshark easy postdissector',
        fmt(
            [[

-- EASYPOST.lua
-- https://wiki.wireshark.org/uploads/6f35ec7531e1557df3f2964c81d80510/EASYPOST.lua

-- Step 1 - Set plugin plugin information
{PluginDetails}

--- Step 2 - create a protocol to attach new fields to
---@type Proto
local {RepeatedProtocolName} = Proto.new('{ProtocolName}', '{ProtocolDescription}')

-- Step 3 - add some field(s) to Step 2 protocol
local pf = {{ payload = ProtoField.string('{FieldName}', '{FieldDescription}') }}

{RepeatedProtocolName2}.fields = pf

-- Step 4 - create a Field extractor to copy packet field data.
-- add items that could be used as a wireshark filter like frame.protocols or mqtt.msg
{RepeatedProtocolName3}_payload_f = Field.new('frame.protocols')

-- Step 5 - create the postdissector function that will run on each frame/packet
function {RepeatedProtocolName4}.dissector(tvb, pinfo, tree)
    local subtree = nil

    -- copy existing field(s) into table for processing
    finfo = {{ {RepeatedProtocolName5}_payload_f() }}

    if #finfo > 0 then
        if not subtree then
            subtree = tree:add({RepeatedProtocolName6})
        end
        for k, v in pairs(finfo) do
            -- process data and add results to the tree
            local field_data = string.format('%s', v):upper()
            subtree:add(pf.payload, field_data)
        end
    end
end

-- Step 6 - register the new protocol as a postdissector
register_postdissector({RepeatedProtocolName7})
        ]],
            {
                PluginDetails = wireshark_plugin_details(1),
                RepeatedProtocolName = rep(2),
                ProtocolName = i(2, 'protocol_name'),
                ProtocolDescription = i(3, 'Protocol description'),
                FieldName = i(4, 'field_name'),
                FieldDescription = i(5, 'Field description'),
                RepeatedProtocolName2 = rep(2),
                RepeatedProtocolName3 = rep(2),
                RepeatedProtocolName4 = rep(2),
                RepeatedProtocolName5 = rep(2),
                RepeatedProtocolName6 = rep(2),
                RepeatedProtocolName7 = rep(2),
            }
        )
    ),

    s(
        'wireshark tap simple',
        fmt(
            [[
        -- https://wiki.wireshark.org/Lua/Taps
        {}

        packets = 0

        -- Create a new tap
        local {} = Listener.new(nil, '{}')

        -- This function is called once each time the filter of the tap matches
        function {}.packet()
            packets = packets + 1
        end

        -- This function will get called at the end of the capture to print the summary
        function {}.draw()
            print('http packets:' .. packets)
        end

        -- This function will be called at the end of the capture run
        function {}.reset()
            packets = 0
            print('Script reset!')
        end
        ]],
            {

                -- i(1, '1.0.0'),
                -- i(2, 'Derek Lomax'),
                -- i(3, 'This is my awesome wireshark plugin that does something great'),
                -- i(4, 'repo source'),
                wireshark_plugin_details(1),
                i(2, 'http_tap'),
                i(3, 'http'),
                rep(3),
                rep(3),
                rep(3),
            }
        )
    ),

    ms(
        {
            { trig = 'wireshark tap with GUI', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
        -- https://wiki.wireshark.org/Lua/Taps
        -- text_window_tap.lua
        -- an example of a tap that registers a menu
        -- and prints to a text window

        instances = 0 -- number of instances of the tap created so far

        function mytap_menu()
            instances = instances + 1

            local td = {{}}
            -- the tap data, locally accessible by every function of the tap
            -- beware not to use a global for taps with multiple instances or you might
            -- find it been written by more instances of the tap, not what we want.
            -- each tap will have its own private instance of td.

            td.win = TextWindow.new('My Tap ' .. instances) -- the window we'll use
            td.text = '' -- the text of the tap
            td.instance = instances -- the instance number of this tap

            -- This tap will be local to the menu_function that called it
            local tap = Listener.new()

            -- Callback to remove the tap when the text window closes
            function remove_tap()
                if tap and tap.remove then
                    tap:remove()
                end
            end

            -- Make sure the tap doesn't hang around after the window was closed
            td.win:set_atclose(remove_tap)

            -- This function will be called for every packet
            function tap.packet(pinfo, tvb, tapdata)
                local text = 'packet ' .. pinfo.number
                td.text = td.text .. '\n' .. text
            end

            -- This function will be called once every few seconds to redraw the window
            function tap.draw()
                td.win:set(td.text)
            end
        end

        -- last we register the menu
        -- the first arg is the menu name
        -- the 2nd arg is the function to be called
        -- the third argument is the menu to hold this new menu
        register_menu('Lua Tap Test', mytap_menu, MENU_TOOLS_UNSORTED)
                ]],
            {}
        )
    ),

    -- s(
    --     'wireshark register additional protocols on other ports',
    --     fmt(
    --         [[
    --     -- https://wiki.wireshark.org/Lua/Examples#using-lua-to-register-protocols-to-more-ports
    --     {}
    --
    --     -- Get the list of dissectors currently available for the given port
    --     local {} = DissectorTable.get('{}')
    --
    --     -- Get the desired dissector from a known port
    --     -- For example:
    --     -- http: 80
    --     -- mqtt: 1883
    --     local {} = {}:get_dissector({})
    --
    --     -- For each port listed add the desired new protocol
    --     for i, port in ipairs({{ {} }}) do
    --         {}:add(port, {})
    --     end
    --
    --     -- Port ranges work as well
    --     -- {}:add("8000-8005", {})
    --     ]],
    --         {
    --             wireshark_plugin_details(1),
    --             i(2, 'tcp_port_table'),
    --             i(3, 'tcp.port'),
    --             i(4, 'mqtt_dissector'),
    --             rep(2),
    --             i(5, '1883'),
    --             i(6, '8000, 8001, 8002'),
    --             rep(2),
    --             rep(4),
    --             rep(2),
    --             rep(4),
    --         }
    --     )
    -- ),
}

local autosnippets = {}

return snippets, autosnippets
