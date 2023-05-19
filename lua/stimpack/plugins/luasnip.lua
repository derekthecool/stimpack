return {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    config = function()
        -- Load my treesitter helper functions now
        require('stimpack.my-treesitter-functions')

        local types = require('luasnip.util.types')

        -- Setup location to load my custom lua snippets - NOTE: the value OS.snippets
        -- is a global table from my config which helps me have cross platform setup
        require('luasnip.loaders.from_lua').load({ paths = OS.snippets })
        -- Setup VSCode snippet loader with loads snippets from the plugin: rafamadriz/friendly-snippets
        require('luasnip.loaders.from_vscode').lazy_load()

        -- Set my config options
        require('luasnip').config.set_config({
            history = false,
            update_events = { 'TextChanged', 'TextChangedI' }, -- update text as you type
            region_check_events = { 'CursorMoved', 'CursorHold', 'InsertEnter' }, -- update text as you type
            delete_check_events = { 'TextChanged', 'InsertLeave' },
            enable_autosnippets = true, -- I NEED autosnippets to live, default is false
            -- store_selection_keys = '<Tab>', -- I'm not sure about this, the default has it nil
            -- Add awesome highlights to help show where you are at in a snippet
            -- Think of them as a road map of where you're going
            ext_opts = {
                -- Nodes that don't need highlights:
                -- Text node. It just makes a mess and does not help anything

                -- [types.snippet] = {
                --     -- show nothing when active
                --     active = { virt_text = { { '' } } },
                --     -- Display a blue icon after leaving snippet. This'll help remind to use snippet history
                --     snippet_passive = { virt_text = { { Icons.documents.cut, 'DevIconDropbox' } } },
                -- },

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
        -- map('i', '<c-d>', function()
        --     require('luasnip').jump(1)
        -- end)
        -- map('s', '<c-d>', function()
        --     require('luasnip').jump(1)
        -- end)
        -- map('i', '<c-u>', function()
        --     require('luasnip').jump(-1)
        -- end)
        -- map('s', '<c-u>', function()
        --     require('luasnip').jump(-1)
        -- end)

        map('i', '☝', function()
            require('luasnip.extras.select_choice')()
        end)

        -- My mapping function causes an error
        -- map('i', '👉', '<Plug>luasnip-next-choice<CR>')
        -- map('s', '👉', '<Plug>luasnip-next-choice<CR>')
        -- map('i', '👈', '<Plug>luasnip-prev-choice<CR>')
        -- map('s', '👈', '<Plug>luasnip-prev-choice<CR>')
        vim.api.nvim_set_keymap('i', '👉', '<Plug>luasnip-next-choice', {})
        vim.api.nvim_set_keymap('s', '👉', '<Plug>luasnip-next-choice', {})
        vim.api.nvim_set_keymap('i', '👈', '<Plug>luasnip-prev-choice', {})
        vim.api.nvim_set_keymap('s', '👈', '<Plug>luasnip-prev-choice', {})

        -- STWHEUFL
        map('n', '👇', function()
            require('luasnip.loaders').edit_snippet_files({
                edit = function(file)
                    vim.api.nvim_cmd({ cmd = 'split', args = { file }, range = { 20 } }, {})
                end,
            })
        end)
        -- STWHEUFLS
        map('n', '👇👇', '<cmd>source ' .. OS.nvim .. 'lua/stimpack/luasnip-settings.lua<cr>')

        -- Snippet extensions, AKA get snippets of one filetype to use another as well
        -- This enables the new filetypes to appear in the snippet edit menu
        -- Dotnet
        require('luasnip').filetype_extend('fsharp', { 'dotnet' })
        require('luasnip').filetype_extend('csharp', { 'dotnet' })
        require('luasnip').filetype_extend('cs', { 'dotnet' })
        require('luasnip').filetype_extend('toggleterm', { 'ps1' })

        -- C
        require('luasnip').filetype_set('h', { 'c' })
        -- require('luasnip').filetype_extend('c', { 'h' })
    end,
}
