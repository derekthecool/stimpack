return {
    'L3MON4D3/LuaSnip',
    -- event = 'InsertEnter',
    config = function()
        -- Load my treesitter helper functions now
        require('stimpack.my-treesitter-functions')

        local types = require('luasnip.util.types')

        -- Setup location to load my custom lua snippets - NOTE: the value OS.snippets
        -- is a global table from my config which helps me have cross platform setup
        require('luasnip.loaders.from_lua').load({ paths = OS.snippets })

        -- It is possible to load VS**** snippets. However, I see no point.
        -- require('luasnip.loaders.from_vscode').lazy_load()

        -- Set my config options
        require('luasnip').config.set_config({
            history = false,
            update_events = { 'TextChanged', 'TextChangedI' }, -- update text as you type
            region_check_events = { 'CursorMoved', 'CursorHold', 'InsertEnter' }, -- update text as you type
            delete_check_events = { 'TextChanged', 'InsertLeave' },
            enable_autosnippets = true, -- I NEED autosnippets to live, default is false

            -- Add awesome highlights to help show where you are at in a snippet
            -- Think of them as a road map of where you're going
            ext_opts = {
                [types.insertNode] = {
                    -- Display bright orange icon when active
                    active = { virt_text = { { Icons.documents.write1, 'DevIconOPUS' } } },
                    -- Display gray icon when passive
                    passive = { virt_text = { { Icons.documents.write1, 'DevIconDefault' } } },
                },
                [types.functionNode] = {
                    -- Display green icon when active
                    active = { virt_text = { { string.format('%s ', Icons.coding.Function), 'DevIconCsv' } } },
                    -- Display gray icon when passive
                    passive = { virt_text = { { string.format('%s ', Icons.coding.Function), 'DevIconDefault' } } },
                },
                [types.dynamicNode] = {
                    -- Display purple icon when active
                    active = { virt_text = { { Icons.miscellaneous.react, 'DevIconSln' } } },
                    -- Display gray icon when passive
                    passive = { virt_text = { { Icons.miscellaneous.react, 'DevIconDefault' } } },
                },
                [types.choiceNode] = {
                    -- Display a yellow icon when active
                    active = { virt_text = { { Icons.nvim_dev_icon_filetype('c'), 'DevIconCoffee' } } },
                    -- Display gray icon when passive
                    passive = { virt_text = { { Icons.nvim_dev_icon_filetype('c'), 'DevIconIni' } } },
                },
            },
        })

        local luasnip_autocommands = vim.api.nvim_create_augroup('luasnip_autocommands_stimpack', { clear = true })

        vim.api.nvim_create_autocmd('User', {
            pattern = 'LuasnipInsertNodeEnter',
            callback = function()
                -- Disable mini.nvim animate right away
                vim.b.minianimate_disable = true

                -- Set timer to reenable mini.nvim animate after the delay period
                local delay_ms = 100
                vim.defer_fn(function()
                    vim.b.minianimate_disable = false
                end, delay_ms)
            end,
            group = luasnip_autocommands,
        })

        -- Global variable to optionally disable auto choice select
        LuasnipAutoChoice = true
        function ToggleLuasnipAutoChoiceExpand()
            LuasnipAutoChoice = not LuasnipAutoChoice
        end

        -- Autocommand to autoexpand choice-node snippets selection
        vim.api.nvim_create_autocmd('User', {
            pattern = 'LuasnipChoiceNodeEnter',
            callback = function()
                if LuasnipAutoChoice then
                    require('luasnip.extras.select_choice')()
                end
            end,
            group = luasnip_autocommands,
        })

        local map = require('stimpack.mapping-function')
        map('i', '<c-j>', function()
            require('luasnip').jump(1)
        end)
        map('s', '<c-j>', function()
            require('luasnip').jump(1)
        end)
        map('i', '<c-k>', function()
            require('luasnip').jump(-1)
        end)
        map('s', '<c-k>', function()
            require('luasnip').jump(-1)
        end)
        map('i', '👉👉', function()
            require('luasnip').jump(1)
        end)
        map('s', '👉👉', function()
            require('luasnip').jump(1)
        end)
        map('i', '👈👈', function()
            require('luasnip').jump(-1)
        end)
        map('s', '👈👈', function()
            require('luasnip').jump(-1)
        end)

        map('i', '☝', function()
            require('luasnip.extras.select_choice')()
        end)

        vim.keymap.set('n', '☝', function()
            ToggleLuasnipAutoChoiceExpand()
            vim.notify(
                string.format(
                    'Running function: ToggleLuasnipAutoChoiceExpand, new state of LuasnipAutoChoice: %s',
                    tostring(LuasnipAutoChoice)
                ),
                vim.log.levels.INFO,
                { title = 'Stimpack Notification' }
            )
        end, { silent = true, desc = 'ToggleLuasnipAutoChoiceExpand' })

        -- My mapping function causes an error
        vim.api.nvim_set_keymap('i', '👉', '<Plug>luasnip-next-choice', {})
        vim.api.nvim_set_keymap('s', '👉', '<Plug>luasnip-next-choice', {})
        vim.api.nvim_set_keymap('i', '👈', '<Plug>luasnip-prev-choice', {})
        vim.api.nvim_set_keymap('s', '👈', '<Plug>luasnip-prev-choice', {})

        -- STWHEUFL
        map('n', '👇', function()
            local current_filetype = vim.bo.filetype
            local expected_snippet_filename = string.format('%s.lua', current_filetype)
            local luasnip_snippet_path = OS.join_path(OS.snippets, expected_snippet_filename)
            if FileExists(luasnip_snippet_path) == false then
                vim.notify(
                    'Snippet file does not exist for this filetype - expected name should be: '
                        .. expected_snippet_filename,
                    vim.log.levels.INFO,
                    { title = 'Stimpack Notification' }
                )

                vim.ui.select({ 'yes', 'no' }, {
                    prompt = string.format('Create file %s?', luasnip_snippet_path),
                }, function(choice)
                    if choice == 'yes' then
                        vim.notify('Creating file now', vim.log.levels.INFO, { title = 'Stimpack Notification' })

                        local file = io.open(luasnip_snippet_path, 'w')
                        if not file then
                            vim.notify(
                                'Could not open file for writing',
                                vim.log.levels.ERROR,
                                { title = 'Stimpack Notification' }
                            )
                            return
                        end

                        local snippet_starter_contents = {
                            '---@diagnostic disable: undefined-global',
                            'local snippets = {',
                            '',
                            '}',
                            '',
                            'local autosnippets = {',
                            '',
                            '}',
                            '',
                            'return snippets, autosnippets',
                        }
                        for _, value in pairs(snippet_starter_contents) do
                            file:write(value .. '\n')
                        end
                        file:close()

                        vim.api.nvim_cmd({ cmd = 'split', args = { luasnip_snippet_path }, range = { 20 } }, {})
                    end
                end)
            else
                -- If file does exist, open it normally with luasnip opener

                if FileExists(luasnip_snippet_path) then
                    require('luasnip.loaders').edit_snippet_files({
                        edit = function(file)
                            vim.api.nvim_cmd({ cmd = 'split', args = { file }, range = { 20 } }, {})
                        end,
                    })
                end
            end
        end)

        -- Snippet extensions, AKA get snippets of one filetype to use another as well
        -- This enables the new filetypes to appear in the snippet edit menu
        -- Dotnet
        require('luasnip').filetype_extend('fsharp', { 'dotnet' })
        require('luasnip').filetype_extend('csharp', { 'dotnet' })
        require('luasnip').filetype_extend('cs', { 'dotnet' })
        require('luasnip').filetype_extend('toggleterm', { 'ps1' })

        -- C
        require('luasnip').filetype_set('h', { 'c' })

        -- Function for status line to show how many snippets available for current filetype
        function GetLuasnipAvailableSnippetCountForCurrentFile()
            local available_snippets = require('luasnip').available()

            -- I don't want anything from the 'all' snippets type to be counted
            available_snippets.all = nil

            local snippet_count = 0
            for _, value in pairs(available_snippets) do
                snippet_count = snippet_count + #value
            end

            return Icons.documents.cut3 .. ' ' .. snippet_count
        end
    end,
}
