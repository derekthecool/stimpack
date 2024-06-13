return {
    'tpope/vim-dadbod',
    dependencies = {
        'kristijanhusak/vim-dadbod-ui',
        'kristijanhusak/vim-dadbod-completion',
    },
    -- Lazy load on these commands
    cmd = { 'DB', 'DBUI', 'DBUIToggle' },
    config = function()
        vim.g.db_ui_use_nvim_notify = 1
        vim.g.db_ui_use_nerd_fonts = 1
        vim.g.db_ui_show_database_icon = 1
    end,
}
