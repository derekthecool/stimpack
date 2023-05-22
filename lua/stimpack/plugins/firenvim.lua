return {
    'glacambre/firenvim',
    enabled = false,
    event = 'VeryLazy',
    priority = 1, -- very low priority
    cond = (vim.fn.has('wsl') ~= 1),
    config = function()
        if vim.g.started_by_firenvim == true then
            vim.opt.laststatus = 0
            vim.opt.winbar = nil
        end
    end,
}
