-- Ｄｅｒｅｋ'ｓ ｉｎｉｔ.ｌｕａ

-- Map leader to comma instead of space since switching to stenography.
-- Spacing is done after each word so comma is better for me now.
vim.g.mapleader = ','

-- Enable project configuration, since neovim 0.9.0 you can use .nvim.lua
vim.opt.exrc = true

require('stimpack.global-helpers')

-- Load lazy.nvim
require('stimpack.package-manager-config')

-- Load my configuration later
vim.api.nvim_create_autocmd('User', {
    pattern = { 'VeryLazy' },
    callback = function()
        -- Lua basic configuration
        require('stimpack.settings')
        require('stimpack.auto-commands')
        require('stimpack.mappings')
        require('stimpack.visualsettings')
        require('stimpack.code-auto-run')
        require('stimpack.file-watcher')
        require('stimpack.dotfile-jumper')

        -- Personal boosters e.g. mini plugins that are to narrow scoped to create into full plugins
        -- See ./lua/stimpack/boosters/init.lua for all the boosters
        require('stimpack.boosters')
    end,
})
