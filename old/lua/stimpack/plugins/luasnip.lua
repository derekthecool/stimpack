local function open_snippet_file()
    local current_filetype = vim.bo.filetype
    local expected_snippet_filename = string.format('%s.lua', current_filetype)
    local luasnip_snippet_path = OS.join_path(OS.snippets, expected_snippet_filename)
    local exists = FileExists(luasnip_snippet_path)
    V(string.format('Attempting to open snippet file: %s, exists: %s', luasnip_snippet_path, tostring(exists)))
    if exists == false then
        vim.notify(
            'Snippet file does not exist for this filetype - expected name should be: ' .. expected_snippet_filename,
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

                vim.api.nvim_cmd({ cmd = 'tabnew', args = { luasnip_snippet_path } }, {})
            end
        end)
    else
        -- If file does exist, open it normally with luasnip opener

        if FileExists(luasnip_snippet_path) then
            require('luasnip.loaders').edit_snippet_files({
                edit = function(file)
                    V(string.format('Opening snippet file: %s', file))
                    vim.api.nvim_cmd({ cmd = 'tabnew', args = { file } }, {})
                end,
            })
        else
            V(string.format('Snippet file seems to still not exist'))
        end
    end
end

return {
    'L3MON4D3/LuaSnip',
    event = 'CursorMoved',
    -- enabled = false,
    config = function()
        local luasnip = require('luasnip')

        -- Load my treesitter helper functions now
        require('config.my-treesitter-functions')

        local types = require('luasnip.util.types')

        -- Setup location to load my custom lua snippets - NOTE: the value OS.snippets
        -- is a global table from my config which helps me have cross platform setup
        require('luasnip.loaders.from_lua').load({ paths = OS.snippets })

        -- It is possible to load VS**** snippets. However, I see no point.
        -- require('luasnip.loaders.from_vscode').lazy_load()

        -- Set my config options
        luasnip.config.set_config({
            history = true,
            update_events = { 'TextChanged', 'TextChangedI' },
            region_check_events = { 'CursorMoved', 'CursorHold', 'InsertEnter' }, -- update text as you type
            -- delete_check_events = { 'TextChanged', 'InsertLeave' },
            enable_autosnippets = true,                                           -- I NEED autosnippets to live, default is false
            -- store_selection_keys = '<Tab>',
            store_selection_keys = '```',
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

        -- Clear all scratch pad files when they are opened
        vim.api.nvim_create_autocmd('BufNew', {
            pattern = '*snippet_scratch_pad_files*',
            callback = function()
                vim.api.nvim_buf_set_lines(0, 0, -1, false, { '' })
                vim.cmd('w')
            end,
            group = luasnip_autocommands,
        })

        -- -- Global variable to optionally disable auto choice select
        -- LuasnipAutoChoice = true
        -- function ToggleLuasnipAutoChoiceExpand()
        --     LuasnipAutoChoice = not LuasnipAutoChoice
        -- end
        -- -- Autocommand to autoexpand choice-node snippets selection
        -- vim.api.nvim_create_autocmd('User', {
        --     pattern = 'LuasnipChoiceNodeEnter',
        --     callback = function()
        --         if LuasnipAutoChoice then
        --             require('luasnip.extras.select_choice')()
        --         end
        --     end,
        --     group = luasnip_autocommands,
        -- })

        -- vim.keymap.set({ 'i', 's' }, '👉👉', function()
        --     luasnip.jump(1)
        -- end, { silent = true, desc = 'Snippet next' })
        -- vim.keymap.set({ 'i', 's' }, '👈👈', function()
        --     luasnip.jump(-1)
        -- end, { silent = true, desc = 'Snippet previous' })

        -- NORMIE keyboard support
        vim.keymap.set({ 'i', 's' }, '<c-j>', function()
            luasnip.jump(1)
        end, { silent = true, desc = 'Snippet next' })
        vim.keymap.set({ 'i', 's' }, '<c-k>', function()
            luasnip.jump(-1)
        end, { silent = true, desc = 'Snippet previous' })
        vim.keymap.set({ 'i', 's' }, '<c-u>', function()
            require('luasnip.extras.select_choice')()
        end, { silent = true, desc = 'Open snippet choice' })
        vim.keymap.set({ 'i', 's' }, '<c-h>', '<Plug>luasnip-next-choice', {})
        vim.keymap.set({ 'i', 's' }, '<c-l>', '<Plug>luasnip-prev-choice', {})

        -- Steno keyboard support
        vim.keymap.set({ 'i', 's' }, '§', function()
            luasnip.jump(1)
        end, { silent = true, desc = 'Snippet next' })
        vim.keymap.set({ 'i', 's' }, '∏', function()
            luasnip.jump(-1)
        end, { silent = true, desc = 'Snippet previous' })
        vim.keymap.set({ 'i', 's' }, '∄', function()
            require('luasnip.extras.select_choice')()
        end, { silent = true, desc = 'Open snippet choice' })

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

        vim.keymap.set({ 'i', 's' }, '∃', '<Plug>luasnip-next-choice', {})
        vim.keymap.set({ 'i', 's' }, '∀', '<Plug>luasnip-prev-choice', {})

        -- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#on-the-fly-snippets
        vim.cmd([[vnoremap <c-y>  "lc<cmd>lua require('luasnip.extras.otf').on_the_fly("l")<cr>]])
        vim.keymap.set('i', '<c-y>', function()
            require('luasnip.extras.otf').on_the_fly()
        end, { silent = true, desc = 'Luasnip on the fly activate snippet' })

        local auxiliary = require('luasnippets.functions.auxiliary')
        vim.cmd('map <c-t> <nop>')
        vim.keymap.set({ 's', 'i' }, '<c-t>', function()
            auxiliary.dynamic_node_external_update(1)
        end, { desc = 'Dynamic_node_external_update(1)' })

        vim.cmd('map <c-p> <nop>')
        vim.keymap.set({ 's', 'i' }, '<c-p>', function()
            M.dynamic_node_external_update(2)
        end, { desc = 'Dynamic_node_external_update(2)' })

        -- Open snippet files to create new snippets
        -- A choice menu will popup if file has never been written
        -- A selection for which specific filetype selection
        -- STWHEUFL
        vim.keymap.set({ 'n', 'i', 's' }, '👇', open_snippet_file, { desc = 'Open snippets' })
        vim.keymap.set({ 'n' }, '<leader>lz', open_snippet_file, { desc = 'Open snippets' })

        -- Snippet extensions, AKA get snippets of one filetype to use another as well
        -- This enables the new filetypes to appear in the snippet edit menu
        -- Dotnet
        luasnip.filetype_extend('fsharp', { 'dotnet' })
        luasnip.filetype_extend('csharp', { 'dotnet' })
        luasnip.filetype_extend('cs', { 'dotnet' })
        luasnip.filetype_extend('ps1', { 'dotnet' })
        luasnip.filetype_extend('toggleterm', { 'ps1' })

        -- Lua
        luasnip.filetype_extend('lua', { 'neovim_snippets', 'wireshark_snippets', 'luasnip_snippet_creation_snippets' })

        -- C
        luasnip.filetype_set('h', { 'c' })
        -- Add microcontroller specific code snippets (all in C of course)
        luasnip.filetype_extend('c', { 'mcu_ESP32', 'inline_assembly' })

        luasnip.filetype_extend('cpp', { 'c', 'mcu_ESP32' })

        -- Create group for flutter
        luasnip.filetype_extend('dart', { 'flutter' })

        -- yaml files for specific configs
        luasnip.filetype_extend('yaml', { 'yaml_docker_compose', 'github_actions', 'azure_pipelines' })

        -- Markdown snippets
        luasnip.filetype_set('vimwiki', { 'markdown', 'hugo', 'mermaid' })
        luasnip.filetype_extend('markdown', { 'hugo', 'mermaid' })

        -- SQL
        -- I want every type to be able to use every type
        -- SQL is a mess but I want database specific snippets separated and general sql together
        local sql_types_wanted = { 'sql', 'mysql', 'sqlserver', 'postgresql', 'sqlite' }
        for _, sql in pairs(sql_types_wanted) do
            luasnip.filetype_set(sql, sql_types_wanted)
            luasnip.filetype_extend(sql, sql_types_wanted)
        end
    end,
}
