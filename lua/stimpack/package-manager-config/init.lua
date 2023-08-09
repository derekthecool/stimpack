-- Bootstrap the plugin to install if needed using git
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end

-- adjust runtime path
vim.opt.rtp:prepend(lazypath)

-- Load plugin manager
require('lazy').setup('stimpack.plugins', {
    change_detection = { enabled = false },
    checker = {
        enabled = true,
        concurrency = 4,
        notify = false,
        frequency = 3600 * 5, -- In seconds
    },
    install = {
        missing = true,
        colorscheme = { 'base16-atelier-sulphurpool', 'habamax' },
    },
    performance = {
        cache = {
            enabled = true,
        },
        reset_packpath = true, -- reset the package path to improve startup time
        rtp = {
            reset = true,      -- reset the runtime path to $VIMRUNTIME and your config directory
            ---@type string[]
            paths = {},        -- add any custom paths here that you want to includes in the rtp
            ---@type string[] list any plugins you want to disable here
            disabled_plugins = {
                'gzip',
                'matchit',
                'matchparen',
                'netrwPlugin',
                'tarPlugin',
                'tohtml',
                -- "tutor",
                'zipPlugin',
            },
        },
    },
})
