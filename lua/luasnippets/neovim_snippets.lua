---@diagnostic disable: undefined-global, missing-parameter

local fun = require('luafun.fun')
local scan = require('plenary.scandir')

local snippets = {

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

    -- Using leader key here causes delays in insert mode
    local keymap_starter_key = '`'

    local mapping_options = { 't', 'n', 'i', }

    local build = '<>'
	vim.keymap.set(mapping_options, keymap_starter_key .. "u;", function()
		toggleterm.exec(build)
	end, { silent = true, desc = build })

    local test = '<>'
	vim.keymap.set(mapping_options, keymap_starter_key .. "ui", function()
		toggleterm.exec(test)
	end, { silent = true, desc = test })

    local run = '<>'
	vim.keymap.set(mapping_options, keymap_starter_key .. "uu", function()
		toggleterm.exec(run)
	end, { silent = true, desc = run })

    -- Set current working directory
    vim.cmd('cd <>')

    -- Run initial start up commands in the terminal
    vim.cmd('ToggleTerm direction=<>')
    toggleterm.exec('<>')

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
                    t('dotnet test'),
                    t('ctest'),
                    i(1, 'custom command'),
                }),
                c(3, {
                    t('dotnet run'),
                    t('idf.py build flash monitor'),
                    i(1, 'custom command'),
                }),
                d(4, function(args, snip)
                    local nodes = {}

                    -- Add nodes for snippet
                    local dirs = fun.map(function(a)
                        return t(vim.fs.normalize(a))
                    end, scan.scan_dir(
                        '.',
                        { respect_gitignore = true, only_dirs = true, depth = 2 }
                    )):totable()

                    return sn(nil, c(1, dirs))
                end, {}),
                c(5, {
                    t('tab'),
                    t('vertical'),
                    t('horizontal'),
                    t('float'),
                }),

                i(6, 'ls -la'),
            },
            {
                delimiters = '<>',
            }
        )
    ),

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

    ms(
        {
            { trig = 'vim REGMATCH', snippetType = 'snippet' },
        },
        fmt(
            [[
        local {} = vim.fn.matchlist({}, '\\v{}')

        if next({}) then
            {}
        end
        ]],
            {
                i(1, 'match_table'),
                i(2, 'input_string'),
                i(3, '^(.*)'),
                rep(1),
                i(4),
            }
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
