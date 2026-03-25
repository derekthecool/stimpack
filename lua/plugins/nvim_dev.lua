return {
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        dependencies = { 'DrKJeff16/wezterm-types' },
        opts = {
            library = {
                -- Library paths can be absolute
                '~/neovim/neotest-pester',
                -- Or relative, which means they will be resolved from the plugin dir.
                'lazy.nvim',
                -- It can also be a table with trigger words / mods
                -- Only load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                -- Only load the lazyvim library when the `LazyVim` global is found
                { path = 'LazyVim', words = { 'LazyVim' } },
                -- Load the wezterm types when the `wezterm` module is required
                -- Needs `DrKJeff16/wezterm-types` to be installed
                { path = 'wezterm-types', mods = { 'wezterm' } },
            },
            -- always enable unless `vim.g.lazydev_enabled = false`
            -- This is the default
            enabled = function(root_dir)
                return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
            end,
        },
    },
}
