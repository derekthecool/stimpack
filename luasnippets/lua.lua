---@diagnostic disable: undefined-global

local my_treesitter_functions = require('stimpack.my-treesitter-functions')
local shiftwidth = vim.bo.shiftwidth
local shiftwidth_match_string = string.rep(' ', shiftwidth)

local snippets = {

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
      ---@diagnostic disable: undefined-global
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
            {{ pattern = {{ '{}' }}, command = '{}', group = {} }}
        )
        ]],
            {
                i(1, 'autocommandGroupName'),
                rep(1),
                i(2, 'Event'),
                i(3, 'File pattern'),
                i(4, 'Command'),
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
                i(2),
                rep(1),
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
        'wireshark easy post',
        fmt(
            [[

-- EASYPOST.lua
-- https://wiki.wireshark.org/uploads/6f35ec7531e1557df3f2964c81d80510/EASYPOST.lua
-- Replace occurrences of "easypost/EASYPOST" with protocol/dissector name.
-- Grab and format fields as needed

-- Step 1 - document as you go. See header above and set_plugin_info().
local easypost_info = {{
    version = '1.0.0',
    author = 'Good Coder',
    description = 'Important EASYPOST stuff',
    repository = 'Floppy in top drawer',
}}

set_plugin_info(easypost_info)

-- Step 2 - create a protocol to attach new fields to
local easypost_p = Proto.new('easypost', 'Important EASYPOST Protocol')

-- Step 3 - add some field(s) to Step 2 protocol
local pf = {{ payload = ProtoField.string('easypost.payload', 'EASYPOST data') }}

easypost_p.fields = pf

-- Step 4 - create a Field extractor to copy packet field data.
easypost_payload_f = Field.new('frame.protocols')

-- Step 5 - create the postdissector function that will run on each frame/packet
function easypost_p.dissector(tvb, pinfo, tree)
    local subtree = nil

    -- copy existing field(s) into table for processing
    finfo = {{ easypost_payload_f() }}

    if #finfo > 0 then
        if not subtree then
            subtree = tree:add(easypost_p)
        end
        for k, v in pairs(finfo) do
            -- process data and add results to the tree
            local field_data = string.format('%s', v):upper()
            subtree:add(pf.payload, field_data)
        end
    end
end

-- Step 6 - register the new protocol as a postdissector
register_postdissector(easypost_p)
        ]],
            {}
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
                i(1),
                i(2),
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
        {}function{}({})
          {}
        end

        {}
        ]],
            {
                c(1, {
                    t(''),
                    t('local '),
                }),

                c(2, {
                    sn(nil, {
                        t(' '),
                        i(1, 'FunctionName'),
                    }),
                    t(''),
                }),

                i(3),
                i(4),
                i(0),
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
        for {} in pairs({}) do
            {}
        end

        {}
        ]],
            {
                i(1, 'item'),
                i(2, 'table'),
                i(3),
                i(0),
            }
        )
    ),

    s(
        'FOR',
        fmt(
            [[
        for index, value in {}pairs(t) do
            {}
        end
        ]],
            {
                c(1, {
                    t(''),
                    t('i'),
                }),
                i(2),
            }
        )
    ),

    s(
        'WHILE',
        fmt(
            [[
        while({}) do
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

    s(
        'snip snip',
        fmt(
            [=[
      s(
        '{}',
        fmt(
          [[
          {}
          ]],
          {{
            {}
          }}
        )
      ),
      ]=],
            {
                c(1, {
                    i(1, 'trigger'),
                    sn(
                        1,
                        fmt(
                            [[
              {{
                trig = '{}',
                regTrig = {},
                descr = '{}',
              }}
              ]],
                            {
                                i(1, 'long trigger'),
                                c(2, {
                                    t('true'),
                                    t('false'),
                                }),
                                i(3, 'description'),
                            }
                        )
                    ),
                }),
                i(2),
                i(3),
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
                        i(1, '1'),
                    }),
                    sn(nil, {
                        i(1, '1'),
                        t([[, ']]),
                        i(2, 'default'),
                        t([[']]),
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

    -- add dynamic node
    s(
        'dynamic node',
        fmt(
            [[
      d({}, function(args, snip)
        return sn(nil,{{
          {}
        }}) end,
        {{ {} }}
       )
       {}
      ]],
            {
                i(1, '1'),
                i(2),
                i(3, '1'),
                i(0),
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
