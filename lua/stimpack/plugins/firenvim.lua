return {
    'glacambre/firenvim',
    event = 'VeryLazy',
    cond = (vim.fn.has('wsl') ~= 1),
    config = function()
        if vim.g.started_by_firenvim == true then
            vim.opt.laststatus = 0
            vim.opt.winbar = nil
        end
    end,
}
