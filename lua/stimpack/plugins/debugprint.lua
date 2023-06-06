return {
    'andrewferrier/debugprint.nvim',
    -- Basic plugin settings
    -- enabled = true,
    -- cond = function()
    --    return true
    -- end,
    -- dependencies = {
    --     'other plugins to load first',
    -- },

    -- Plugin version settings
    -- branch = 'branch name',
    -- tag = 'tag name',
    -- commit = 'commit hash',
    -- version = 'semver version string',
    -- pin = true, -- if true, never update
    -- submodules = true, -- if false git submodules will not be fetched
    -- priority = 50, -- Only needed for start plugins, default 50

    -- Lazy loading settings
    -- lazy = true,
    -- event = 'VeryLazy',
    -- cmd = 'MyExCommandNameToLoadThisPlugin',
    -- ft = { 'cs', 'help', 'lua' },
    -- keys = { "<C-a>", { "<C-x>", mode = "i" } }, -- LazyKeys table

    -- Configuration
    -- opts = configuration table to be passed to plugin's setup function
    -- config = function to execute when plugin loads
    -- init = function that is always run on startup
    opts = {},
    -- Plugin development
    -- dir = 'plugin local path',
    -- dev = true,
}
