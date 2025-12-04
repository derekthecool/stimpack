-- The LazyExtras command can enable the sql extra
-- Everything is nearly perfect except a few settings to DBUI
-- which are modified here to overwrite the defaults
return {
    {
        'kristijanhusak/vim-dadbod-ui',
        cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
        dependencies = 'vim-dadbod',
        keys = {
            { '<leader>D', '<cmd>DBUIToggle<CR>', desc = 'Toggle DBUI' },
        },
        init = function()
            local data_path = vim.fn.stdpath('data')

            vim.g.db_ui_auto_execute_table_helpers = 1
            vim.g.db_ui_save_location = data_path .. '/dadbod_ui'
            vim.g.db_ui_show_database_icon = true
            -- Default temp query location is local the same as the current connection in the db_ui_save_location which is nice
            -- vim.g.db_ui_tmp_query_location = data_path .. '/dadbod_ui/tmp'
            vim.g.db_ui_use_nerd_fonts = true
            vim.g.db_ui_use_nvim_notify = true

            -- Disabled by default, but I love running the query on save
            vim.g.db_ui_execute_on_save = true

            -- New query file name generator
            local function buffer_name_generator(opts)
                if not opts.table or opts.table == '' then
                    return 'myquery-' .. vim.fn.localtime() .. '.sql'
                end

                return 'myquery-fortable-' .. opts.table .. '-' .. vim.fn.localtime() .. '.sql'
            end
            vim.g.Db_ui_buffer_name_generator = buffer_name_generator
        end,
    },
}
