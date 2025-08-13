return {
    -- -- Make tokyonight transparent. I don't love it because some plugins still have bad highlights.
    -- {
    --     'folke/tokyonight.nvim',
    --     opts = {
    --         transparent = true,
    --         styles = {
    --             sidebars = 'transparent',
    --             floats = 'transparent',
    --         },
    --     },
    -- },

    -- -- Old favorite colorscheme base16-atelier-sulphurpool
    -- 'RRethy/nvim-base16',

    {
        'ziontee113/color-picker.nvim',
        cmd = { 'PickColor', 'PickColorInsert' },
        opts = {},
    },
}
