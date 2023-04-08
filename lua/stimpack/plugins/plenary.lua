return {
    -- 'nvim-lua/plenary.nvim',

    -- Use my custom fork which enables test harness on windows
    -- if this pull request ever gets merged then I'll switch back
    -- https://github.com/nvim-lua/plenary.nvim/pull/476
    'derekthecool/plenary.nvim',
    branch = 'patch-1',
    lazy = false,
    -- dir = [[D:\Programming\neovim\plenary.nvim]],
    -- dev = true,
}
