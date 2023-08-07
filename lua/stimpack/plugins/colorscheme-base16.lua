return {
    'RRethy/nvim-base16',
    priority = 1000, --set high priority for colorscheme
    event = 'BufEnter',
    config = function()
        vim.api.nvim_cmd({ cmd = 'colorscheme', args = { 'base16-atelier-sulphurpool' } }, {})
    end,
}
