--[[
This file is for mission critical plugins that are needed by my own configuration as well as
many other plugins.

Every item in here should be set to lazy loading.

This file should never be deleted, as such I can reduce adding dependencies to plugins such as telescope
if I don't want to include them.
]]

return {
    {
        'kyazdani42/nvim-web-devicons',
        lazy = true,
        opts = {
            -- globally enable default icons (default to false)
            default = true,
        },
    },

    -- Used for testing lua code, and many more helper functions such as:
    -- Path spec to recursively search for files - used in my luasnippets
    {
        'nvim-lua/plenary.nvim',
        cmd = 'PlenaryBustedDirectory',
        lazy = true,
    },

    -- My packaged version of the luafun library. lazy.nvim does not support lua rocks
    -- So forking the luafun repo and putting it in a sourcable plugin packaging was done instead.
    {
        'derekthecool/luafun_neovim',
        lazy = true,
        pin = true,
    },
}
