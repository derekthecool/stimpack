-- -- https://x-team.com/blog/neovim-flutter/
-- return {
--     {
--         'dart-lang/dart-vim-plugin',
--     },
--     { 'thosakwe/vim-flutter' },
--     { 'natebosch/vim-lsc' },
--     { 'natebosch/vim-lsc-dart' },
-- }

return {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim',
        'dart-lang/dart-vim-plugin',
    },
    config = true,
}
