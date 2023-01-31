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
require('lazy').setup('stimpack.plugins')
