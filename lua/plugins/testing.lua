return {
    -- 'nvim-neotest/neotest-plenary',
    -- 'nvim-neotest/neotest-python',
    -- 'vim-test/vim-test',
    -- 'nsidorenco/neotest-vstest', -- part of LazyExtra: dotnet
    -- 'sidlatau/neotest-dart', -- part of LazyExtra: dart
    {
        'nvim-neotest/neotest',
        dependencies = {
            {
                'derekthecool/neotest-pester',
                -- Development location ~/neovim/neotest-pester/
                dev = true,
            },
        },
        opts = {
            adapters = {
                -- 'nvim-neotest/neotest-plenary',
                -- 'nvim-neotest/neotest-python',
                -- 'vim-test/vim-test',
                -- 'nsidorenco/neotest-vstest', -- part of LazyExtra: dotnet
                -- 'sidlatau/neotest-dart', -- part of LazyExtra: dart
                'neotest-pester',
            },
            log_level = vim.log.levels.TRACE,
        },
    },
    { 'nvim-mini/mini.test', version = '*', opts = {} },
}
