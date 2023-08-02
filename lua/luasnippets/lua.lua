---@diagnostic disable: undefined-global, missing-parameter

local my_treesitter_functions = require('stimpack.my-treesitter-functions')
local shiftwidth = vim.bo.shiftwidth
local shiftwidth_match_string = string.rep(' ', shiftwidth)
local auxiliary = require('luasnippets.functions.auxiliary')
local scan = require('plenary.scandir')
local fun = require('luafun.fun')

local function column_count_from_string(descr)
    -- this won't work for all cases, but it's simple to improve
    -- (feel free to do so! :D )
    return #(descr:gsub('[^clm]', ''))
end

-- function for the dynamicNode.
local tab = function(args, snip)
    local cols = column_count_from_string(args[1][1])
    -- snip.rows will not be set by default, so handle that case.
    -- it's also the value set by the functions called from dynamic_node_external_update().
    if not snip.rows then
        snip.rows = 1
    end
    local nodes = {}
    -- keep track of which insert-index we're at.
    local ins_indx = 1
    for j = 1, snip.rows do
        -- use restoreNode to not lose content when updating.
        table.insert(nodes, r(ins_indx, tostring(j) .. 'x1', i(1)))
        ins_indx = ins_indx + 1
        for k = 2, cols do
            table.insert(nodes, t(' & '))
            table.insert(nodes, r(ins_indx, tostring(j) .. 'x' .. tostring(k), i(1)))
            ins_indx = ins_indx + 1
        end
        table.insert(nodes, t({ '\\\\', '' }))
    end
    -- fix last node.
    nodes[#nodes] = t('')
    return sn(nil, nodes)
end

-- 'recursive' dynamic snippet. Expands to some text followed by itself.
local rec_ls = function()
    return sn(
        2,
        c(1, {
            -- Order is important, sn(...) first would cause infinite loop of expansion.
            t(''),
            sn(nil, { i(1), d(2, rec_ls, {}) }),
        })
    )
end

-- Wireshark lua plugin helpers
local wireshark_plugin_details = sn(
    1,
    fmt(
        [[
set_plugin_info({{
    version = '{}',
    author = '{}',
    description = '{}',
    repository = '{}',
}})
]],
        {
            i(1, '1.0.0'),
            i(2, 'Derek Lomax'),
            i(3, 'This is my awesome wireshark plugin that does something great'),
            i(4, 'repo source'),
        }
    )
)

local snippets = {
    ms(
        {
            {
                trig = 'plenary scandir',
                descr = 'description',
            },
        },
        fmt(
            [[
        local scandir = require('plenary.scandir')
        local files = scandir.scan_dir(
            '{}',
            {{ respect_gitignore = true, search_pattern = '{}' }}
        )
        ]],
            {
                i(1, 'directory_to_start_scan'),
                i(2, 'lua_search_pattern'),
            }
        )
    ),
    s(
        'selected_text',
        f(function(args, snip)
            local res, env = {}, snip.env
            table.insert(res, 'Selected Text (current line is ' .. env.TM_LINE_NUMBER .. '):')
            for _, ele in ipairs(env.LS_SELECT_RAW) do
                table.insert(res, ele)
            end
            return res
        end, {})
    ),

    ms({
        common = { snippetType = 'autosnippet' },
        'test1',
        'test2',
    }, {
        t('a or b (but autotriggered!!)'),
    }),

    s('ls', {
        t({ '\\begin{itemize}', '\t\\item ' }),
        i(1),
        d(2, rec_ls, {}),
        t({ '', '\\end{itemize}' }),
    }),

    s(
        'test',
        fmt([[{}]], {
            d(1, function(args, snip)
                if not snip.rows then
                    snip.rows = 1
                end
                local nodes = {}
                table.insert(nodes, i(1, 'Derek is cool'))

                -- keep track of which insert-index we're at.
                for j = 1, snip.rows do
                    table.insert(nodes, t({ '', string.format('My node: %d', j) }))
                end
                table.insert(nodes, t({ '', 'Derek is awesome' }))
                return sn(nil, nodes)
            end, {}, {
                user_args = {
                    -- Pass the functions used to manually update the dynamicNode as user args.
                    -- The n-th of these functions will be called by dynamic_node_external_update(n).
                    -- These functions are pretty simple, there's probably some cool stuff one could do
                    -- with `ui.input`
                    function(snip)
                        V('Increment row count')
                        snip.rows = snip.rows + 1
                    end,
                    -- don't drop below one.
                    function(snip)
                        V('Decrement row count')
                        snip.rows = math.max(snip.rows - 1, 1)
                    end,
                },
            }),
        })
    ),

    s(
        'tab',
        fmt(
            [[
\begin{{tabular}}{{{}}}
{}
\end{{tabular}}
]],
            {
                i(1, 'c'),
                d(2, tab, { 1 }, {
                    user_args = {
                        -- Pass the functions used to manually update the dynamicNode as user args.
                        -- The n-th of these functions will be called by dynamic_node_external_update(n).
                        -- These functions are pretty simple, there's probably some cool stuff one could do
                        -- with `ui.input`
                        function(snip)
                            V('Increment row count')
                            snip.rows = snip.rows + 1
                        end,
                        -- don't drop below one.
                        function(snip)
                            V('Decrement row count')
                            snip.rows = math.max(snip.rows - 1, 1)
                        end,
                    },
                }),
            }
        )
    ),

    ms(
        {
            'format',
            {
                trig = 'string format',
                snippetType = 'autosnippet',
                condition = function(line_to_cursor)
                    return line_to_cursor:match([[']]) == nil
                end,
            },
        },
        fmt(
            [[
        string.format("{}"{})
        ]],
            {
                i(1),
                auxiliary.printf_style_dynamic_formatter(2, 1),
            }
        )
    ),

    s(
        'require',
        fmt(
            [[
        local {} = require('{}')
        ]],

            {
                l(l._1:gsub('.*%.(%w+)', '%1'), { 1 }),
                i(1, 'initial text'),
            }
        )
    ),

    -- File snippets

    s(
        'file exists',
        fmt(
            [[
        function FileExists(filename)
            local f = io.open(filename, 'r')
            if f ~= nil then
                io.close(f)
                return true
            else
                return false
            end
        end
        ]],
            {}
        )
    ),

    -- {{{ Snippets to help create luasnip snippets
    s(
        {
            trig = 'snippet file',
            descr = 'Basic start for a snippet file named [ft].lua and located in the snippets directory of my neovim config',
        },

        fmt(
            [[
      ---@diagnostic disable: undefined-global, missing-parameter
      local snippets = {{
          {}
      }}

      local autosnippets = {{
          {}
      }}

      return snippets, autosnippets
      ]],
            { i(1), i(2) }
        )
    ),

    s(
        'luasnip_lambda_node',
        fmt(
            [[
        -- A shortcut for functionNodes that only do very basic string manipulation.
        -- l(lambda, argnodes):
        l(l._1:gsub('{}', '{}'), {{ {} }}),
        ]],
            {
                i(1, 'find'),
                i(2, 'replace'),
                i(3, '1, 2'),
            }
        )
    ),

    s(
        'luasnip_dynamic_lambda_node',
        fmt(
            [[
        -- Pretty much the same as lambda, but it inserts the resulting text as an insertNode, and, as such, it can be quickly overridden.
        -- dynamic_lambda(jump_indx, lambda, node_references)
        dl(l._{}:gsub('{}', '{}'), {{ {} }}),
        ]],
            {
                i(1, 'node_number_to_perform_function_on'),
                i(2, 'find'),
                i(3, 'replace'),
                i(4, 'dependant_nodes --[[ { 1, 2 }]]'),
            }
        )
    ),

    s(
        'luasnip_partial_node',
        fmt(
            [[
        -- Evaluates a function on expand and inserts its value
        ---partial(fn, params...)
        partial({})
        ]],
            {
                i(1, 'os.date, "%Y"'),
            }
        )
    ),

    s(
        'luasnip_nonempty_node',
        fmt(
            [[
        -- Inserts text if the referenced node doesn't contain any text.
        -- nonempty(node_reference, not_empty, empty):
        nonempty({}, "{}", "{}")
        ]],
            {
                i(1, '1'),
                i(2, 'Text to insert if not empty'),
                i(3, 'Text to insert if empty'),
            }
        )
    ),

    -- }}}

    -- {{{ Neovim command and API snippets
    s(
        'highlight',
        fmt(
            [[
        vim.api.nvim_set_hl(0, '{}', {{ bg = '#{}', fg = '#{}' }})
        ]],
            {
                i(1, 'ColorColumn'),
                i(2, 'FF99CC'),
                i(3, 'CCCCCC'),
            }
        )
    ),

    s(
        'lines',
        fmt(
            [[
         local lines = vim.api.nvim_buf_get_lines(0, 0,-1, false)
         for _, line in ipairs(lines) do
             {}
         end
         ]],
            {
                i(1),
            }
        )
    ),

    s(
        'nvimget cursor',
        fmt([[vim.api.nvim_win_get_cursor({})]], {
            i(1, '0'),
        })
    ),
    s(
        'nvimset cursor',
        fmt([[vim.api.nvim_win_set_cursor({}, {})]], {
            i(1, '0'),
            i(1, 'location tuple {line, column}'),
        })
    ),

    s(
        'get current line',
        fmt(
            [[
        vim.api.nvim_get_current_line()
        ]],
            {}
        )
    ),

    s(
        'autocommand',
        fmt(
            [[
        local {} = vim.api.nvim_create_augroup('{}', {{ clear = true }})
        vim.api.nvim_create_autocmd(
            '{}',
            {{
                pattern = {{ '{}' }},
                {},
                group = {}
            }}
        )
        ]],
            {
                -- TODO: add dynamic_node here to optionally include the group
                i(1, 'autocommandGroupName'),
                rep(1),
                i(2, 'Event'),
                i(3, 'File pattern'),
                c(4, {
                    sn(
                        nil,
                        -- TODO: the formatting is weird here, but stylua will fix it so not a huge priority
                        fmt(
                            [[
                            callback = function()
                                {}
                            end
                            ]],
                            {
                                i(1),
                            }
                        )
                    ),

                    sn(
                        nil,
                        fmt([[command = "{}"]], {
                            i(1),
                        })
                    ),
                }),

                rep(1),
            }
        )
    ),

    s(
        'map',
        fmt(
            [[
        vim.keymap.set('{}', '{}', function()
            {}
        end, {{ silent = true, desc = '{}' }})
        ]],
            {
                i(1, 'mode'),
                i(2, 'lhs'),
                i(3, 'vim.opt.textwidth = 100'),
                i(4, 'My awesome mapping'),
            }
        )
    ),

    -- }}}

    s(
        'module',
        fmt(
            [[
        local {} = {{}}

        {}

        return {}
        ]],
            {
                i(1, 'M'),
                d(2, function(args, snip)
                    local module_name = args[1][1]
                    local nodes = {}

                    if not snip.rows then
                        snip.rows = 1
                    end

                    local insert_index = 1
                    local module_item_count = 1
                    for row = 1, snip.rows do
                        if row == 1 then
                            table.insert(nodes, t({ '' }))
                        else
                            table.insert(nodes, t({ '', '', '' }))
                        end

                        table.insert(nodes, t({ string.format('%s.', module_name) }))
                        local restore_node_1 = string.format('module_item_%d', module_item_count)
                        table.insert(nodes, r(insert_index, restore_node_1, i(1, restore_node_1)))
                        insert_index = insert_index + 1
                        module_item_count = module_item_count + 1
                        --
                        -- local restore_node_2 = string.format('module_item_content_%d', insert_index)
                        -- table.insert(nodes, r(insert_index, restore_node_2, i(1, 'true')))
                        -- insert_index = insert_index + 1
                    end

                    return sn(nil, nodes)
                end, { 1 }, {
                    user_args = {
                        -- Pass the functions used to manually update the dynamicNode as user args.
                        -- The n-th of these functions will be called by dynamic_node_external_update(n).
                        -- These functions are pretty simple, there's probably some cool stuff one could do
                        -- with `ui.input`
                        function(snip)
                            -- V('Increment module item')
                            snip.rows = snip.rows + 1
                        end,
                        -- don't drop below one.
                        function(snip)
                            -- V('Decrement module item')
                            snip.rows = math.max(snip.rows - 1, 1)
                        end,
                    },
                }),
                rep(1),
            }
        )
    ),

    s(
        'test restore',
        fmt(
            [[
        {}
        ]],
            {

                c(1, {
                    r(1, 'unique_key1', i(1)),
                    r(1, 'unique_key2', i(1)),
                }),
            }
        )
    ),

    s(
        'lazy',
        fmt(
            [[
        return {{
            '{}',

            -- Basic plugin settings
            -- enabled = true,
            -- cond = function()
            --    return true
            -- end,
            -- dependencies = {{
            --     'other plugins to load first',
            -- }},

            -- Plugin version settings
            -- branch = 'branch name',
            -- tag = 'tag name',
            -- commit = 'commit hash',
            -- version = 'semver version string',
            -- pin = true, -- if true, never update
            -- submodules = true, -- if false git submodules will not be fetched
            -- priority = 50, -- Only needed for start plugins, default 50

            -- Lazy loading settings
            -- lazy = true,
            -- event = 'VeryLazy',
            -- cmd = 'MyExCommandNameToLoadThisPlugin',
            -- ft = {{ 'cs', 'help', 'lua' }},
            -- keys = {{ "<C-a>", {{ "<C-x>", mode = "i" }} }}, -- LazyKeys table

            -- Configuration
            -- opts = configuration table to be passed to plugin's setup function
            -- config = function to execute when plugin loads
            -- init = function that is always run on startup
            opts = {{
                {}
            }},
            config = function()
                {}
            end,
            init = function()
                {}
            end,

            -- Plugin development
            -- dir = 'plugin local path',
            -- dev = true,
        }}
        ]],
            {
                i(1, 'plugin URL'),
                i(2, 'opts table'),
                i(3, 'config function'),
                i(4, 'init function'),
            }
        )
    ),

    s(
        'metaset',
        fmt([[setmetatable({}, {})]], {
            i(1, 'tableToSetMetaTableOn'),
            i(2, 'metaTable'),
        })
    ),

    -- Wireshark plugin snippets
    s(
        'wireshark easy postdissector',
        fmt(
            [[

-- EASYPOST.lua
-- https://wiki.wireshark.org/uploads/6f35ec7531e1557df3f2964c81d80510/EASYPOST.lua

-- Step 1 - Set plugin plugin information
{}

--- Step 2 - create a protocol to attach new fields to
---@type Proto
local {} = Proto.new('{}', '{}')

-- Step 3 - add some field(s) to Step 2 protocol
local pf = {{ payload = ProtoField.string('{}', '{}') }}

{}.fields = pf

-- Step 4 - create a Field extractor to copy packet field data.
-- add items that could be used as a wireshark filter like frame.protocols or mqtt.msg
{}_payload_f = Field.new('frame.protocols')

-- Step 5 - create the postdissector function that will run on each frame/packet
function {}.dissector(tvb, pinfo, tree)
    local subtree = nil

    -- copy existing field(s) into table for processing
    finfo = {{ {}_payload_f() }}

    if #finfo > 0 then
        if not subtree then
            subtree = tree:add({})
        end
        for k, v in pairs(finfo) do
            -- process data and add results to the tree
            local field_data = string.format('%s', v):upper()
            subtree:add(pf.payload, field_data)
        end
    end
end

-- Step 6 - register the new protocol as a postdissector
register_postdissector({})
        ]],
            {
                wireshark_plugin_details,
                rep(2),
                i(2, 'protocol_name'),
                i(3, 'Protocol description'),
                i(4, 'field_name'),
                i(5, 'Field description'),
                rep(2),
                rep(2),
                rep(2),
                rep(2),
                rep(2),
                rep(2),
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
                wireshark_plugin_details,
                i(2, 'http_tap'),
                i(3, 'http'),
                rep(3),
                rep(3),
                rep(3),
            }
        )
    ),

    s(
        'wireshark tap with GUI',
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

    s(
        'wireshark register additional protocols on other ports',
        fmt(
            [[
        -- https://wiki.wireshark.org/Lua/Examples#using-lua-to-register-protocols-to-more-ports
        {}

        -- Get the list of dissectors currently available for the given port
        local {} = DissectorTable.get('{}')

        -- Get the desired dissector from a known port
        -- For example:
        -- http: 80
        -- mqtt: 1883
        local {} = {}:get_dissector({})

        -- For each port listed add the desired new protocol
        for i, port in ipairs({{ {} }}) do
            {}:add(port, {})
        end

        -- Port ranges work as well
        -- {}:add("8000-8005", {})
        ]],
            {
                wireshark_plugin_details,
                i(2, 'tcp_port_table'),
                i(3, 'tcp.port'),
                i(4, 'mqtt_dissector'),
                rep(2),
                i(5, '1883'),
                i(6, '8000, 8001, 8002'),
                rep(2),
                rep(4),
                rep(2),
                rep(4),
            }
        )
    ),

    ms(
        {
            '.nvim.lua',
            'nvim.lua',
        },
        fmt(
            [[
-- Simple .nvim.lua
local delay_ms = 3000

vim.defer_fn(function()
	local toggleterm = require("toggleterm")

    local build = '<>'
	vim.keymap.set("n", ",u;", function()
		toggleterm.exec(build)
	end, { silent = true, desc = build })

    local run = '<>'
	vim.keymap.set("n", ",uu", function()
		toggleterm.exec(run)
	end, { silent = true, desc = run })

    vim.cmd('cd <>')

    vim.notify('Ready to run', vim.log.levels.INFO, { title = '.nvim.lua commands' })
end, delay_ms)
        ]],
            {
                c(1, {
                    t('dotnet build'),
                    t('idf.py build'),
                    i(1, 'custom command'),
                }),
                c(2, {
                    t('dotnet run'),
                    t('dotnet test'),
                    t('idf.py build flash monitor'),
                    i(1, 'custom command'),
                }),
                d(3, function(args, snip)
                    local nodes = {}

                    -- Add nodes for snippet
                    local dirs = fun.map(function(a)
                        return t(vim.fs.normalize(a))
                    end, scan.scan_dir('.', { respect_gitignore = true, only_dirs = true, depth = 2 })):totable()

                    return sn(nil, c(1, dirs))
                end, { }),
            },
            {
                delimiters = '<>',
            }
        )
    ),
}

local autosnippets = {

    s(
        'INCLUDE',
        fmt(
            [[
        require('{}')
        ]],
            {
                i(1),
            }
        )
    ),

    -- Working snippet that generates commas when needed inside a table
    -- Enhancement would be to use a dynamic creation of a node that would optionally
    -- put a choice option defaulting to 'local' for variables inside a function
    -- When inside a table, the node choice would not exist
    s(
        'FIRST',
        fmt([[ = {}{}]], {
            i(1, 'true'),
            f(function(args, snip)
                local returnString = ''

                if require('stimpack.my-treesitter-functions').lua.current_location_is_in_lua_table() == true then
                    returnString = ','
                end
                return returnString
            end, {}),
        })
    ),

    s(
        'TABLE',
        fmt(
            [[
        {{
            {}
        }}
        ]],
            {
                i(1),
            }
        )
    ),

    s(
        'KEY',
        fmt(
            [[
        {} = {},
        ]],
            {
                i(1, 'key'),
                i(2, 'value'),
            }
        )
    ),

    -- {{{ Neovim command and API snippets
    s(
        'VIM.NOTIFY',
        fmt([[vim.notify('{}', {}, {{ title = '{}' }})]], {
            i(1, 'Notify text'),
            c(2, {
                t('vim.log.levels.INFO'),
                t('vim.log.levels.ERROR'),
                t('vim.log.levels.TRACE'),
                t('vim.log.levels.WARN'),
                t('vim.log.levels.DEBUG'),
                t('vim.log.levels.OFF'),
            }),
            i(3, 'Stimpack Notification'),
        })
    ),
    -- }}}

    -- {{{ Fast steno commands to trigger snippets
    s(
        'IF',
        fmt(
            [[
            if {} then
            {}
            end
            {}]],
            {
                i(1, 'true'),
                auxiliary.wrap_selected_text(2),
                i(0),
            }
        )
    ),

    s(
        { trig = shiftwidth_match_string .. 'ELS_EI_F', regTrig = true, wordTrig = false },
        fmt(
            [[
        elseif {} then
            {}
        ]],
            {
                i(1),
                i(2),
            }
        )
    ),

    s(
        { trig = shiftwidth_match_string .. 'ELSE', regTrig = true, wordTrig = false },
        fmt(
            [[
        else
            {}
        ]],
            {
                i(1),
            }
        )
    ),

    s(
        'FUNCTION',
        fmt(
            [[
        function({})
          {}
        end]],
            {
                i(1),
                i(2),
            }
        )
    ),

    -- TODO: Call different function than pairs if two arguments are used
    s(
        { trig = '(%w+),? (%w+) FOR', regTrig = true },
        fmt(
            [[
        for {} do
            {}
        end

        {}
        ]],
            {
                d(1, function(args, snip)
                    -- Check for numeric for loop, only lower bound needs to be number
                    if snip.captures[1]:match('%d+') then
                        return sn(nil, {
                            t('i='),
                            t(snip.captures[1]),
                            t(', '),
                            t(snip.captures[2]),
                        })
                    elseif snip.captures[1]:match('i?pairs') then
                        return sn(nil, {
                            t(string.format('k, v in %s(%s)', snip.captures[1], snip.captures[2])),
                        })
                    else
                        return sn(nil, {
                            i(1),
                            t('in'),
                            i(2),
                        })
                    end
                end, { 1 }),
                i(2),
                i(0),
            }
        )
    ),

    s(
        'FOREACH',
        fmt(
            [[
        for {}, {} in {}({}) do
            {}
        end
        ]],
            {
                i(1, '_'),
                i(2, 'value'),
                c(3, {
                    t('pairs'),
                    t('ipairs'),
                }),
                i(4, 'table'),
                i(5),
            }
        )
    ),

    s(
        'FOR',
        fmt(
            [[
        for {}={}, {} do
            {}
        end{}
        ]],
            {
                i(0, 'i'),
                i(1, '1'),
                i(2, '10, 2'),
                i(3),
                i(4),
            }
        )
    ),

    s(
        'WHILE',
        fmt(
            [[
        while {} do
            {}
        end

        {}
        ]],
            {
                i(1, 'condition'),
                i(2),
                i(0),
            }
        )
    ),

    s(
        'FORMAT',
        fmt(
            [[
      string.format('{}',{})
      {}
      ]],
            {
                i(1),
                i(2),
                i(0),
            }
        )
    ),

    s(
        'PRINT',
        fmt(
            [[
      print({})
      {}
      ]],
            { i(1), i(0) }
        )
    ),

    s(
        { trig = 'DESCRIBE', descr = 'Plenary test group' },
        fmt(
            [[
        describe('{} --', function()
          {}
        end)

        {}
    ]],
            {
                i(1, 'Test group name '),
                d(2, function()
                    local test_snippet = fmt(
                        [[
          it('{}', function()
              {}
          end)
          ]],
                        {
                            i(1, 'Test name'),
                            i(2),
                        }
                    )

                    -- TODO: dynamic may not be the way to go. I may need just normal choice version
                    local runtimepath_add_in = fmt(
                        [[
          before_each(function()
              -- Run time path is not getting loaded automatically, so modify it before each test
              print('Attempting to add to neovim runtime path with current plugin location')
              local path_to_plugin = debug.getinfo(1).source:match('@(.*[/\\]lua[/\\])'):gsub('"', '')
              print(string.format('Attempting to add: %s to neovim runtimepath because plenary tests fail without this', path_to_plugin))
              vim.cmd('set runtimepath+=' .. path_to_plugin)
          end)
          ]],

                        {}
                    )

                    return sn(
                        nil,
                        {
                            c(1, {
                                t('new text'),
                                runtimepath_add_in,
                            }),
                        }

                        -- test_snippet
                    )
                end, { 1 }),

                i(3),
            }
        )
    ),

    s(
        'nvimcommand',
        fmt(
            [[
            vim.api.nvim_cmd({{ cmd = '{}', args = {{ '{}' }} }}, {{}})
            ]],
            {
                i(1, 'command'),
                i(2),
            }
        )
    ),

    s(
        'TEST',
        fmt(
            [[
            it('{}', function()
                {}
            end)
            ]],
            {
                i(1),
                i(2),
            }
        )
    ),

    s(
        'ASSERT',
        fmt(
            [[
        assert.{}({})
        ]],
            {
                c(1, {
                    t('are.same'),
                    t('is.same'),
                    t('are_not.equals'),
                    t('are_not.equal'),
                    t('is_not.equal'),
                    t('truthy'),
                    t('is.truthy'),
                    t('True'),
                    t('is_true'),
                    t('falsy'),
                    t('is.falsy'),
                    t('has_error(function() end)'),
                    t('has_no_errors(function() end)'),
                    t('are.unique'),
                }),
                i(2),
            }
        )
    ),

    -- }}}

    -- Luasnip functions

    -- This massive snippet is used to create snippets
    -- It features several choice nodes with a simple and complex version
    s(
        'snip snip',
        fmt(
            [=[
      ms(
          {{
            {}
          }},
        fmt(
          [[
          {}
          ]],
          {{
            {}
          }}{}
        )
      ),
      ]=],
            {
                c(1, {
                    sn(
                        1,
                        fmt(
                            [[
              {{
                trig = '{}', descr = '{}',
              }}
              ]],
                            {
                                r(1, 'snippet_trigger'),
                                i(3, 'description'),
                            }
                        )
                    ),

                    sn(
                        1,
                        fmt([['{}']], {
                            r(1, 'snippet_trigger'),
                        })
                    ),
                }),
                r(2, 'snippet_format'),
                r(3, 'snippet_nodes'),
                c(4, {
                    t(''),
                    sn(
                        nil,
                        fmt(
                            [[
                    ,
                    {{
                    -- Special callback functions to run. Use the index of the node to run it at or -1 to run before all nodes
                    callbacks = {{
                        [-1] = {{
                            -- Write needed using directives before expanding snippet so positions are not messed up
                            [events.pre_expand] = function()
                                add_csharp_using_statement_if_needed('NLua')
                            end,
                        }},
                    }},

                    -- For storing items for restore nodes
                    stored = {{
                        ['snippet_trigger'] = i(1, 'trigger'),
                        ['snippet_format'] = i(2),
                        ['snippet_nodes'] = i(3),
                    }},
                    }}

                    ]],
                            {}
                        )
                    ),
                }),
            }
        ),
        {
            stored = {
                ['snippet_trigger'] = i(1, 'trigger'),
                ['snippet_format'] = i(2),
                ['snippet_nodes'] = i(3),
            },
        }
    ),

    ms(
        {
            { trig = 'snip snap' },
        },
        fmt(
            [[
        {{ trig = '{}', snippetType = '{}', }},
        ]],
            {
                i(1, 'trigger'),
                c(2, {
                    t('snippet'),
                    t('autosnippet'),
                }),
            }
        )
    ),

    s(
        'snip simple',
        fmt([[s('{}', t('{}')),]], {
            i(1),
            i(2),
        })
    ),

    s(
        'snippet node',
        fmt(
            [[
            sn({},
                {}
            )
            ]],
            {
                c(1, {
                    t('nil'),
                    i(1, 'jump index'),
                }),
                c(2, {

                    -- Version that includes the fmt function
                    sn(
                        nil,
                        fmt(
                            [[
                            fmt(
                            {}
                            {}
                            {},
                            {{
                                {}
                            }}
                            )
                      ]],
                            {
                                t('[['),
                                i(1),
                                t(']]'),
                                i(2),
                            }
                        )
                    ),

                    -- Version where you just create your table of nodes
                    sn(
                        nil,
                        fmt(
                            [[
                      {{
                          {}
                      }}
                      ]],
                            {
                                i(1),
                            }
                        )
                    ),
                }),
            }
        )
    ),

    s(
        {
            trig = 'text node',
            descr = 'insert a text node',
        },
        fmt(
            [[
      t('{}'),
      {}
      ]],
            {
                i(1, 'text'),
                i(0),
            }
        )
    ),

    -- This snippet supports a choice between just insert position or position and place holder text
    s(
        {
            trig = 'insert node',
            descr = 'insert a new insert node',
        },
        fmt(
            [[
      i({}),
      {}
      ]],
            {
                c(1, {
                    sn(nil, {
                        -- i(1, '1'),
                        r(1, 'insert_node', i(1, '1')),
                        t([[, ']]),
                        i(2, 'default'),
                        t([[']]),
                    }),
                    sn(nil, {
                        r(1, 'insert_node', i(1, '1')),
                    }),
                }),
                i(0),
            }
        )
    ),

    s(
        -- This node is not a real node. It is just easier to remember by calling it this.
        'format node',
        fmta(
            [[
        fmt(
          <>
          <>
          <>,
          {
              <>
          })
        ]],
            {
                t('[['),
                i(1),
                t(']]'),
                i(2),
            }
        )
    ),

    s(
        {
            trig = 'function node',
            descr = 'insert a function node',
        },
        fmt(
            [[
      f(function(args, snip)
        {}
      end,
      {{ {} }}),
      {}
      ]],
            {
                i(1),
                i(2, ''),
                i(0),
            }
        )
    ),

    s(
        'choice node',
        fmt(
            [[
      c({},
      {{
        {}
      }}),
      {}
      ]],
            {
                i(1, 'node number'),
                sn(
                    2,
                    fmt([[{}('{}'),]], {
                        t('t'),
                        i(1, 'new text'),
                    })
                ),
                i(0),
            }
        )
    ),

    -- dynamic node
    -- The most glorious node of luasnip. You can use this to create anything!
    s(
        'dynamic node',
        fmt(
            [[
      d({}, function(args, snip)
          local nodes = {{}}

          -- Add nodes for snippet
          table.insert(nodes, t('Add this node'))
          {}

        return sn(nil, nodes)
       end,
        {{ {} }}
       {}),
      ]],
            {
                i(1, '1'),
                i(2),
                i(3, '1'),
                c(4, {
                    t(''),
                    sn(
                        nil,
                        fmt(
                            [[
                                , {{
                                        user_args = {{
                                            -- Pass the functions used to manually update the dynamicNode as user args.
                                            -- The n-th of these functions will be called by dynamic_node_external_update(n).
                                            -- These functions are pretty simple, there's probably some cool stuff one could do
                                            -- with `ui.input`
                                            function(snip)
                                                snip.rows = snip.rows + 1
                                            end,
                                            -- don't drop below one.
                                            function(snip)
                                                snip.rows = math.max(snip.rows - 1, 1)
                                        end,
                                    }},
                                }}
                   ]],
                            {}
                        )
                    ),
                }),
            }
        )
    ),

    -- end lua snip functions

    s(
        'var var',
        fmt(
            [[
      {}
      ]],
            {
                f(function()
                    return my_treesitter_functions.lua.get_recent_var()
                end, {}),
            }
        )
    ),

    -- {{{ Experiment snippets
    s('extras1', {
        i(1),
        t({ '', '' }),
        m(1, '^ABC$', 'A'),
    }),
    s('extras2', {
        i(1, 'INPUT'),
        t({ '', '' }),
        m(1, l._1:match(l._1:reverse()), 'PALINDROME'),
    }),
    s('extras3', {
        i(1),
        t({ '', '' }),
        i(2),
        t({ '', '' }),
        m({ 1, 2 }, l._1:match('^' .. l._2 .. '$'), l._1:gsub('a', 'e')),
    }),
    s('extras4', { i(1), t({ '', '' }), rep(1) }),
    s('extras5', { p(os.date, '%Y') }),
    s('extras6', { i(1, ''), t({ '', '' }), n(1, 'not empty!', 'empty!') }),
    s('extras7', { i(1), t({ '', '' }), dl(2, l._1 .. l._1, 1) }),
    -- s('extras8', {parse('"$1 is ${2|hard,easy,challenging|}"')}),
    parse('extras8', '"$TM_FILENAME"'),

    s(
        'conditional snippet',
        fmt(
            [[
        {}
        ]],
            {
                t('You are on an even line!'),
            }
        ),

        {
            show_condition = function()
                return true
            end,
            condition = function()
                local line_number = vim.api.nvim_win_get_cursor(0)[1]

                if line_number % 2 == 0 then
                    return true
                else
                    return false
                end
            end,
        }
    ),
    s(
        { trig = 'test (%d+) test', regTrig = true },
        fmt(
            [[
            {}
        ]],
            {
                f(function(args, snip)
                    return snip.captures[1]
                end, {}),
            }
        )
    ),

    s(
        { trig = 'for loop (%d+), (%d+)', regTrig = true },
        fmt(
            [[
        for i={} do
        end
        ]],
            {
                d(1, function(_, snip)
                    return sn(nil, {
                        t(snip.captures[1]),
                        t(', '),
                        t(snip.captures[2]),
                    })
                end, {}),
            }
        )
    ),
    --}}}
}

return snippets, autosnippets
