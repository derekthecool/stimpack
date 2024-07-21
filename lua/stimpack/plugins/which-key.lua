-- Which-key is AMAZING to help you remember your mappings
return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    -- -- TODO: (Derek Lomax) 7/20/2024 8:55:46 PM, Figure out this hydra mode
    -- -- Show hydra mode for changing windows
    -- require('which-key').show({
    --     keys = '<c-w>',
    --     loop = true, -- this will keep the popup open until you hit <esc>
    -- })
    keys = {
        {
            '<leader>?',
            function()
                require('which-key').show({ global = false })
            end,
            desc = 'Buffer Local Keymaps (which-key)',
        },
    },
}
