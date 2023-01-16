--[[
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

]]

return {

    -- Essential building block dependencies for my config and many plugins
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',

    -- Web
    -- Only run firenvim from the actual host, don't use WSL
    -- I use windows and WSL
    -- if vim.fn.has('wsl') ~= 1 then
    --     use({
    --         'glacambre/firenvim',
    --         run = function()
    --             vim.fn['firenvim#install'](0)
    --         end,
    --     })
    -- end

    -- Help neovim start faster and see what takes the most time to source
    'lewis6991/impatient.nvim',

    -- Vimwiki {{{
    'vimwiki/vimwiki',
    -- 'mattn/calendar-vim', -- TODO: 2022-09-25, suspension state. Do I really use this plugin??
    'godlygeek/tabular',
    -- 'plasticboy/vim-markdown', -- TODO: 2022-09-25, suspension state. Do I really use this plugin??
    -- }}}

    -- Tmux {{{
    -- TODO: replace with lua counterpart
    -- https://github.com/numToStr/Navigator.nvim
    -- https://github.com/aserowy/tmux.nvim
    'christoomey/vim-tmux-navigator',
    -- 'tmux-plugins/vim-tmux-focus-events', -- TODO: 2022-09-25, suspension state. Do I really use this plugin??
    -- }}}

    -- Database helpers {{{
    'tpope/vim-dadbod',
    'kristijanhusak/vim-dadbod-ui',
    -- }}}

    -- LSP setup {{{

    -- cmp plugins {{{
    'hrsh7th/nvim-cmp', -- The completion plugin
    'hrsh7th/cmp-buffer', -- buffer completions
    'hrsh7th/cmp-path', -- path completions
    'hrsh7th/cmp-cmdline', -- cmdline completions
    'hrsh7th/cmp-nvim-lsp-signature-help', -- Show function help while typing
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    -- 'hrsh7th/cmp-emoji', -- TODO: 2022-09-25, suspension state. Do I really use this plugin??
    'hrsh7th/cmp-calc',
    'saadparwaiz1/cmp_luasnip', -- snippet completions
    'neovim/nvim-lspconfig', -- enable LSP
    -- Successor to 'williamboman/nvim-lsp-installer' which supports LSP, DAP, and other tools like linters etc.
    {
        'williamboman/mason.nvim',
        dependencies = { 'williamboman/mason-lspconfig.nvim' },
    },
    -- LSP for F#, make sure to run 'dotnet tool install -g fsautocomplete'
    'ionide/Ionide-vim',
    -- I'm using the old nvim-lsp-installer only for omnisharp because it is not working on windows
    -- This is a requirement for me. I've created this GitHub issue to track
    -- https://github.com/williamboman/mason.nvim/issues/455
    'williamboman/nvim-lsp-installer', -- language server settings defined in json for
    -- 'tamago324/nlsp-settings.nvim', -- language server settings defined in json for -- TODO: 2022-09-25, suspension state. Do I really use this plugin??
    'jose-elias-alvarez/null-ls.nvim', -- for formatters and linters
    -- }}}

    -- Treesitter {{{
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/playground',
    -- }}}

    -- Code action {{{
    'kosayoda/nvim-lightbulb',
    { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' },
    -- }}}
    -- }}}

    -- Snippets {{{
    -- 'L3MON4D3/LuaSnip', --snippet engine
    -- 'rafamadriz/friendly-snippets', -- a bunch of snippets to use -- TODO: 2022-09-27, suspension state. Do I really use this plugin? I believe this one is stunting my snippet growth creation!
    -- }}}

    -- Colors and themes {{{
    'rcarriga/nvim-notify',
    -- use({
    --     'norcalli/nvim-colorizer.lua',
    --     config = function()
    --         require('colorizer').setup()
    --     end,
    -- })
    -- use({
    --     'ziontee113/color-picker.nvim',
    --     config = function()
    --         require('color-picker')
    --     end,
    -- })
    -- }}}

    -- General helper plugins {{{
    -- use({
    --     'kylechui/nvim-surround',
    --     config = function()
    --         require('nvim-surround').setup({
    --             -- Configuration here, or leave empty to use defaults
    --         })
    --     end,
    -- })
    'folke/which-key.nvim', -- Shows mappings with helpful pop up
    'ggandor/leap.nvim',
    -- use({ -- TODO: 2022-09-25, suspension state. Do I really use this plugin??
    --   'goolord/alpha-nvim',
    --   config = function()
    --     require('alpha').setup(require('alpha.themes.startify').config)
    --   end,
    -- })
    'karb94/neoscroll.nvim', -- Smooth scroll with <C-d> and <C-u>
    -- }}}

    -- Coding helpers {{{
    'rafcamlet/nvim-luapad', -- Real time nvim lua scratch pad
    'folke/neodev.nvim',
    -- 'szw/vim-maximizer', -- Maximize a vim pane, to be used with vimspector -- TODO: 2022-09-25, suspension state. Do I really use this plugin??
    'stefandtw/quickfix-reflector.vim',
    -- 'dbeniamine/cheat.sh-vim', -- Another cheat sheet tool

    -- Debugging {{{
    'mfussenegger/nvim-dap',
    'theHamsta/nvim-dap-virtual-text',
    'rcarriga/nvim-dap-ui',
    'jbyuki/one-small-step-for-vimkind',
    -- 'kndndrj/nvim-projector',
    -- { get_my_plugin_path('nvim-projector'), branch = 'master' },
    'nvim-telescope/telescope-dap.nvim',
    -- }}}

    -- File navigation {{{
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
    -- Telescope extensions
    'xiyaowong/telescope-emoji.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    -- }}}

    -- Git helpers {{{
    -- use({
    --     'TimUntersberger/neogit',
    --     requires = {
    --         'sindrets/diffview.nvim',
    --     },
    -- })
    'tpope/vim-fugitive',
    -- 'lewis6991/gitsigns.nvim',
    -- 'airblade/vim-rooter', -- Sets directory to git root
    -- }}}

    -- Markdown and Pandoc {{{
    'conornewton/vim-pandoc-markdown-preview',
    -- use({
    --     -- using cmd = 'MarkdownPreview' just causes problems and plugin does not load properly
    --     'iamcco/markdown-preview.nvim',
    --     run = 'cd app && yarn install',
    -- })
    -- }}}
}
