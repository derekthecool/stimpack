return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local harpoon = require('harpoon')
        -- REQUIRED
        harpoon:setup()
        vim.keymap.set('n', '<leader>ha', function()
            harpoon:list():add()
        end, { desc = 'Add item to harpoon' })

        -- Steno mappings:
        -- add: <leader>ha - -FPL
        -- next: <leader>hb - *L
        -- prev: <leader>hc - *F
        -- pick: <leader>hc - *P
        -- 1: <leader>h1 - R*
        -- 2: <leader>h2 - W*
        -- 3: <leader>h3 - WR*
        -- 4: <leader>h4 - K*
        -- 5: <leader>h5 - KR*
        -- 6: <leader>h6 - KR*
        -- 7: <leader>h7 - KR*
        -- 8: <leader>h8 - KR*
        -- 9: <leader>h9 - KR*
        -- 10: <leader>hA - KR*
        for i = 1, 9 do
            local hex_index = string.format('%X', i)
            vim.keymap.set('n', string.format('<leader>h%s', hex_index), function()
                harpoon:list():select(i)
            end, { desc = string.format('Harpoon go to %s', hex_index) })
        end

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set('n', '<leader>hb', function()
            harpoon:list():prev()
        end, { desc = 'Harpoon next' })
        vim.keymap.set('n', '<leader>hc', function()
            harpoon:list():next()
        end, { desc = 'Harpoon previous' })

        -- basic telescope configuration
        local conf = require('telescope.config').values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require('telescope.pickers')
                .new({}, {
                    prompt_title = 'Harpoon',
                    finder = require('telescope.finders').new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                })
                :find()
        end

        vim.keymap.set('n', '<leader>hp', function()
            toggle_telescope(harpoon:list())
        end, { desc = 'Pick harpoon item' })
    end,
}
