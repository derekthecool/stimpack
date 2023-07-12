return {
    'nvim-neotest/neotest',
    -- Basic plugin settings
    -- enabled = true,
    -- cond = function()
    --    return true
    -- end,
    dependencies = {
        -- Plugin requirements
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'antoinemadec/FixCursorHold.nvim',

        -- Test runners
        'nvim-neotest/neotest-plenary',
        'nvim-neotest/neotest-vim-test',
        'vim-test/vim-test',
        'Issafalcon/neotest-dotnet',
    },
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

    config = function()
        require('neotest').setup({
            adapters = {
                require('neotest-plenary'),
                require('neotest-dotnet'),
                require('neotest-vim-test')({
                    ignore_file_types = { 'python', 'vim', 'lua' },
                }),
            },
        })
    end,
    -- Plugin development
    -- dir = 'plugin local path',
    -- dev = true,
}
