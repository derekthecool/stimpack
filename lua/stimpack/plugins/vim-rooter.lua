return {
    'airblade/vim-rooter',
    enabled = false,
    event = 'VeryLazy',
    config = function()
        vim.g.rooter_patterns = { '.git', '*.sln', 'lua' } -- Set which directories should be set as root project directories
        vim.g.rooter_resolve_links = 0
        vim.g.rooter_manual_only = 0
    end,
}
