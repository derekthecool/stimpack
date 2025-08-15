---@diagnostic disable: undefined-global, missing-parameter

-- local fun = require('luafun.fun')
local scan = require('plenary.scandir')

local snippets = {
    ms(
        {
            { trig = 'filename', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        vim.split(vim.fn.expand('%:t'), '.')[1]
        ]],
            {}
        )
    ),

    -- which-key snippet
    ms(
        {
            { trig = 'whichkey', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
        {{ '{Key}{Letter}', {Mapping}, desc = '{Description}' }},
        ]],
            {
                Key = i(1, '<leader>'),
                Letter = i(2, 'ff'),
                Mapping = c(3, {
                    sn(
                        nil,
                        fmt([[function() {Code} end]], {
                            Code = i(1),
                        })
                    ),
                    sn(
                        nil,
                        fmt([['{Text}']], {
                            Text = '<cmd>Telescope find_files<CR>',
                        })
                    ),
                }),
                Description = i(4, 'This mapping does ....'),
            }
        )
    ),

    ms(
        {
            { trig = 'treesitter_basic_query', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [=[
local ts_query = require("vim.treesitter.query")
local parsers = require("vim.treesitter")

local lang = "c"
local bufnr = vim.api.nvim_get_current_buf()
local parser = parsers.get_parser(bufnr, lang)
local solutionFunctionsQuery = ts_query.parse(
	lang,
	[[
(function_definition
  declarator: (pointer_declarator
    declarator: (function_declarator
      declarator: (identifier) @function.name (#match? @function.name "solution\\d+")
    )
  )
) @function.definition
]]
)

for _, tree in ipairs(parser:parse()) do
	local function_names = {{}}
	for id, node in solutionFunctionsQuery:iter_captures(tree:root(), bufnr, 0, -1) do
		local name = solutionFunctionsQuery.captures[id] -- This gets the capture name
		if name == "function.name" then -- We only care about the function name captures
			local text = vim.treesitter.get_node_text(node, bufnr)
			print("Matched function: " .. text)
			table.insert(function_names, text)
		end
	end
end
        ]=],
            {}
        )
    ),

    ms(
        {
            { trig = 'setreg', snippetType = 'snippet', condition = conds.line_begin },
            { trig = 'vim%.fn%.setreg', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
        vim.fn.setreg('{}', {})
        ]],
            {
                i(1, 'register name .... a'),
                i(2, '"register contents"'),
            }
        )
    ),

    ms(
        {
            { trig = 'feedkeys', snippetType = 'snippet', condition = nil },
            { trig = 'nvim_feedkeys', snippetType = 'snippet', condition = nil },
        },
        fmt([[vim.api.nvim_feedkeys('{}', "n", nil)]], {
            i(1, 'yiw'),
        })
    ),

    ms(
        {
            { trig = 'nvim_virtual_text_above', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
        local bufnr = vim.api.nvim_get_current_buf()

        -- Clear namespace once before updating virtual texts
        local namespace = vim.api.nvim_create_namespace('log-timestamp-visualizer')
        vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)

        vim.api.nvim_buf_set_extmark(bufnr, namespace, index - 2, 0, {
            virt_lines_above = true,
            virt_lines = { { { '<Text>', '<HighlightGroup>' } } },
        })
        ]],
            {
                Text = i(1, 'Text to insert'),
                HighlightGroup = i(2, 'Comment'),
            },
            {
                delimiters = '<>',
            }
        )
    ),

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

    ms(
        {
            { trig = 'keymap', snippetType = 'snippet', condition = nil },
        },
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

    -- TODO: (Derek Lomax) 8/15/2025 9:51:45 AM, requires luafun
    -- ms(
    --     {
    --         '.nvim.lua',
    --         'nvim.lua',
    --     },
    --     fmt(
    --         [[
    --  -- Simple .nvim.lua
    --  local delay_ms = 3000
    --
    --  vim.defer_fn(function()
    --  	local toggleterm = require("toggleterm")
    --
    -- -- Using leader key here causes delays in insert mode
    -- local keymap_starter_key = '`'
    --
    -- local mapping_options = { 't', 'n', 'i', }
    --
    -- local build = '<>'
    --  	vim.keymap.set(mapping_options, keymap_starter_key .. "u;", function()
    --  		toggleterm.exec(build)
    --  	end, { silent = true, desc = build })
    --
    -- local test = '<>'
    --  	vim.keymap.set(mapping_options, keymap_starter_key .. "ui", function()
    --  		toggleterm.exec(test)
    --  	end, { silent = true, desc = test })
    --
    -- local run = '<>'
    --  	vim.keymap.set(mapping_options, keymap_starter_key .. "uu", function()
    --  		toggleterm.exec(run)
    --  	end, { silent = true, desc = run })
    --
    -- -- Set current working directory
    -- vim.cmd('cd <>')
    --
    -- -- Run initial start up commands in the terminal
    -- vim.cmd('ToggleTerm direction=<>')
    -- toggleterm.exec('<>')
    --
    -- vim.notify('Ready to run', vim.log.levels.INFO, { title = '.nvim.lua commands' })
    --  end, delay_ms)
    --     ]],
    --         {
    --             c(1, {
    --                 t('dotnet build'),
    --                 t('idf.py build'),
    --                 i(1, 'custom command'),
    --             }),
    --             c(2, {
    --                 t('dotnet test'),
    --                 t('ctest'),
    --                 i(1, 'custom command'),
    --             }),
    --             c(3, {
    --                 t('dotnet run'),
    --                 t('idf.py build flash monitor'),
    --                 i(1, 'custom command'),
    --             }),
    --             d(4, function(args, snip)
    --                 local nodes = {}
    --
    --                 -- Add nodes for snippet
    --                 -- TODO: (Derek Lomax) 8/4/2025 3:41:28 PM, fix this with luafun
    --                 -- local dirs = fun.map(function(a)
    --                     return t(vim.fs.normalize(a))
    --                 end, scan.scan_dir(
    --                     '.',
    --                     { respect_gitignore = true, only_dirs = true, depth = 2 }
    --                 )):totable()
    --
    --                 return sn(nil, c(1, dirs))
    --             end, {}),
    --             c(5, {
    --                 t('tab'),
    --                 t('vertical'),
    --                 t('horizontal'),
    --                 t('float'),
    --             }),
    --
    --             i(6, 'ls -la'),
    --         },
    --         {
    --             delimiters = '<>',
    --         }
    --     )
    -- ),

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
