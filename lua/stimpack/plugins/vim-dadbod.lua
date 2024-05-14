return {
    'tpope/vim-dadbod',
    dependencies = {
        'kristijanhusak/vim-dadbod-ui',
        'kristijanhusak/vim-dadbod-completion',
    },
    -- Lazy load on these commands
    cmd = { 'DB', 'DBUI', 'DBUIToggle' },
}
