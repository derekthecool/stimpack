local test_adapters = {
    'nvim-neotest/neotest-plenary',
    'nvim-neotest/neotest-python',
    'vim-test/vim-test',
    'Issafalcon/neotest-dotnet',
    -- { 'Issafalcon/neotest-dotnet', enabled = false },
    -- 'nsidorenco/neotest-vstest',
    'sidlatau/neotest-dart',
}

return {
    {
        test_adapters,
        'nvim-neotest/neotest',
        opts = { adapters = test_adapters },
    },
}
