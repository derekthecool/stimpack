-- Packer plugin manager
-- https://github.com/wbthomason/packer.nvim

-- Bootstrap function to install packer.nvim if it does not exist {{{
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
---@diagnostic disable-next-line: missing-parameter
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.api.nvim_command('packadd packer.nvim')
end
-- }}}

return require('packer').startup(function()
    -- Packer can manage itself
    use('wbthomason/packer.nvim')

    -- My plugins {{{
    -- Use the local Linux development version if it is found
    -- Else pull it from GitHub
    local function get_my_plugin_path(plugin_name)
        local plugin_development_path = OS.my_plugins .. '/' .. plugin_name
        local plugin_readme_path = plugin_development_path .. '/README.md'
        if OS.OS == 'Linux' and io.open(plugin_readme_path, 'r') ~= nil then
            return plugin_development_path
        else
            return 'derekthecool/' .. plugin_name
        end
    end

    use(get_my_plugin_path('dvp.nvim'))
    use(get_my_plugin_path('plover-tapey-tape.nvim'))
    -- }}}

    -- Essential building block dependencies for my config and many plugins
    use('nvim-lua/plenary.nvim')
    use('kyazdani42/nvim-web-devicons')

    -- Help neovim start faster and see what takes the most time to source
    use('lewis6991/impatient.nvim')

    -- Vimwiki {{{
    use('vimwiki/vimwiki')
    -- use('mattn/calendar-vim') -- TODO: 2022-09-25, suspension state. Do I really use this plugin??
    use('godlygeek/tabular')
    -- use('plasticboy/vim-markdown') -- TODO: 2022-09-25, suspension state. Do I really use this plugin??
    -- }}}

    -- Tmux {{{
    -- TODO: replace with lua counterpart
    -- https://github.com/numToStr/Navigator.nvim
    -- https://github.com/aserowy/tmux.nvim
    use('christoomey/vim-tmux-navigator')
    -- use('tmux-plugins/vim-tmux-focus-events') -- TODO: 2022-09-25, suspension state. Do I really use this plugin??
    -- }}}

    -- LSP setup {{{

    -- cmp plugins {{{
    use('hrsh7th/nvim-cmp') -- The completion plugin
    use('hrsh7th/cmp-buffer') -- buffer completions
    use('hrsh7th/cmp-path') -- path completions
    use('hrsh7th/cmp-cmdline') -- cmdline completions
    use('hrsh7th/cmp-nvim-lsp-signature-help') -- Show function help while typing
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-nvim-lua')
    -- use('hrsh7th/cmp-emoji') -- TODO: 2022-09-25, suspension state. Do I really use this plugin??
    use('hrsh7th/cmp-calc')
    use('saadparwaiz1/cmp_luasnip') -- snippet completions
    use('neovim/nvim-lspconfig') -- enable LSP
    -- Successor to 'williamboman/nvim-lsp-installer' which supports LSP, DAP, and other tools like linters etc.
    use({
        'williamboman/mason.nvim',
        requires = { 'williamboman/mason-lspconfig.nvim' },
    })
    -- I'm using the old nvim-lsp-installer only for omnisharp because it is not working on windows
    -- This is a requirement for me. I've created this GitHub issue to track
    -- https://github.com/williamboman/mason.nvim/issues/455
    use('williamboman/nvim-lsp-installer') -- language server settings defined in json for
    -- use('tamago324/nlsp-settings.nvim') -- language server settings defined in json for -- TODO: 2022-09-25, suspension state. Do I really use this plugin??
    use('jose-elias-alvarez/null-ls.nvim') -- for formatters and linters
    -- }}}

    -- Treesitter {{{
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use('nvim-treesitter/nvim-treesitter-textobjects')
    use('nvim-treesitter/playground')
    -- }}}

    -- Code action {{{
    use('kosayoda/nvim-lightbulb')
    use({ 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' })
    -- }}}
    -- }}}

    -- Snippets {{{
    use('L3MON4D3/LuaSnip') --snippet engine
    -- use('rafamadriz/friendly-snippets') -- a bunch of snippets to use -- TODO: 2022-09-27, suspension state. Do I really use this plugin? I believe this one is stunting my snippet growth creation!
    -- }}}

    -- Colors and themes {{{
    use('chriskempson/base16-vim') -- Visual plugins
    use('nvim-lualine/lualine.nvim')
    use('rcarriga/nvim-notify')
    use({
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end,
    })
    -- }}}

    -- General helper plugins {{{
    use({
        'kylechui/nvim-surround',
        config = function()
            require('nvim-surround').setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    })
    use('folke/which-key.nvim') -- Shows mappings with helpful pop up
    use('stevearc/dressing.nvim')
    use('akinsho/toggleterm.nvim') -- Awesome terminal helper in lua
    use('ggandor/leap.nvim')
    -- use({ -- TODO: 2022-09-25, suspension state. Do I really use this plugin??
    --   'goolord/alpha-nvim',
    --   config = function()
    --     require('alpha').setup(require('alpha.themes.startify').config)
    --   end,
    -- })
    use('karb94/neoscroll.nvim') -- Smooth scroll with <C-d> and <C-u>
    -- }}}

    -- Coding helpers {{{
    use({ 'rafcamlet/nvim-luapad', requires = 'antoinemadec/FixCursorHold.nvim' }) -- Real time nvim lua scratch pad
    use('folke/lua-dev.nvim')

    -- Get installer to work better with Linux and windows
    -- -- use({ -- TODO: 2022-09-25, suspension state. Do I really use this plugin??
    --   'autozimu/LanguageClient-neovim',
    --   branch = 'next',
    --   run = function()
    --     if OS.OS == 'Linux' then
    --       return 'bash install.sh'
    --     else
    --       return 'powershell -file ./install.ps1'
    --     end
    --   end,
    -- })
    -- use('szw/vim-maximizer') -- Maximize a vim pane, to be used with vimspector -- TODO: 2022-09-25, suspension state. Do I really use this plugin??
    use('skywind3000/asynctasks.vim') -- Async build resource
    use('skywind3000/asyncrun.vim')
    use('skywind3000/asyncrun.extra')
    use('stefandtw/quickfix-reflector.vim')
    use('dbeniamine/cheat.sh-vim') -- Another cheat sheet tool
    use({ -- Comment plugin made with lua
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    })
    -- }}}

    -- Debugging {{{
    use('mfussenegger/nvim-dap')
    use('theHamsta/nvim-dap-virtual-text')
    use('rcarriga/nvim-dap-ui')
    use('jbyuki/one-small-step-for-vimkind')
    -- use('kndndrj/nvim-projector')
    use(get_my_plugin_path('nvim-projector'))
    use('nvim-telescope/telescope-dap.nvim')
    -- }}}

    -- File navigation {{{
    use('kyazdani42/nvim-tree.lua')
    use('nvim-telescope/telescope.nvim')
    use('nvim-telescope/telescope-file-browser.nvim')
    -- Telescope extensions
    use('xiyaowong/telescope-emoji.nvim')
    use({ 'nvim-telescope/telescope-ui-select.nvim' })
    -- }}}

    -- Git helpers {{{
    use({
        'TimUntersberger/neogit',
        requires = {
            'sindrets/diffview.nvim',
        },
    })
    use('tpope/vim-fugitive')
    use('lewis6991/gitsigns.nvim')
    use('airblade/vim-rooter') -- Sets directory to git root
    -- }}}

    -- Markdown and Pandoc {{{
    use('conornewton/vim-pandoc-markdown-preview')
    use({
        -- using cmd = 'MarkdownPreview' just causes problems and plugin does not load properly
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
    })
    -- }}}
end)
