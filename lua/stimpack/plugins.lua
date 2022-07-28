-- Packer plugin manager
-- https://github.com/wbthomason/packer.nvim

-- Bootstrap function to install packer.nvim if it does not exist {{{
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
  execute 'packadd packer.nvim'
end
-- }}}

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- My plugins {{{
  -- Use the local Linux development version if it is found
  -- Else pull it from GitHub
  if OS.OS == 'Linux' and io.open(OS.home .. '/dvp.nvim/README.md', 'r') ~= nil then
    use '~/dvp.nvim'
  else
    use 'derekthecool/dvp.nvim'
  end
  -- }}}

  -- Help neovim start faster and see what takes the most time to source
  use 'lewis6991/impatient.nvim'

  -- Vimwiki {{{
  use 'vimwiki/vimwiki'
  use 'mattn/calendar-vim'
  use 'godlygeek/tabular'
  use 'plasticboy/vim-markdown'
  -- }}}

  -- Tmux {{{
  -- TODO: replace with lua counterpart
  -- https://github.com/numToStr/Navigator.nvim
  -- https://github.com/aserowy/tmux.nvim
  use 'christoomey/vim-tmux-navigator'

  use 'tmux-plugins/vim-tmux-focus-events'
  -- }}}

  -- LSP setup {{{

  -- cmp plugins {{{
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  -- }}}

  -- Treesitter {{{
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/playground'
  -- }}}

  -- Code action {{{
  use 'kosayoda/nvim-lightbulb'
  use { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' }
  -- }}}
  -- }}}

  -- Snippets {{{
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
  -- }}}

  -- Colors and themes {{{
  use 'chriskempson/base16-vim' -- Visual plugins
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }
  use 'kyazdani42/nvim-web-devicons'
  use 'rcarriga/nvim-notify'
  -- }}}

  -- General helper plugins {{{
  -- use 'tpope/vim-surround' -- Easily surround text
  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  })
  use 'folke/which-key.nvim' -- Shows mappings with helpful pop up
  use 'akinsho/toggleterm.nvim' -- Awesome terminal helper in lua
  use 'ggandor/leap.nvim'
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require 'alpha'.setup(require 'alpha.themes.startify'.config)
    end
  }
  use 'karb94/neoscroll.nvim' -- Smooth scroll with <C-d> and <C-u>
  -- }}}

  -- Coding helpers {{{
  use 'rafcamlet/nvim-luapad' -- Real time nvim lua scratch pad
  use 'folke/lua-dev.nvim'

  -- Get installer to work better with Linux and windows
  local install_command
  if OS.OS == 'Linux' then
    install_command = 'bash install.sh'
  else
    install_command = 'powershell -file ./install.ps1'
  end
  use {
    'autozimu/LanguageClient-neovim',
    branch = 'next',
    run = install_command,
  } -- Bash LSP extension
  use 'szw/vim-maximizer' -- Maximize a vim pane, to be used with vimspector
  use 'skywind3000/asynctasks.vim' -- Async build resource
  use 'skywind3000/asyncrun.vim'
  use 'skywind3000/asyncrun.extra'
  use 'stefandtw/quickfix-reflector.vim'
  use 'dbeniamine/cheat.sh-vim' -- Another cheat sheet tool
  use { -- Comment plugin made with lua
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  -- }}}

  -- Debugging {{{
  use 'mfussenegger/nvim-dap'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'rcarriga/nvim-dap-ui'
  use 'kndndrj/nvim-projector'
  use 'nvim-telescope/telescope-dap.nvim'
  -- }}}

  -- File navigation {{{
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  -- Telescope extensions
  use 'xiyaowong/telescope-emoji.nvim'
  -- }}}

  -- Git helpers {{{
  use {
    'TimUntersberger/neogit',
    requires = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim'
    }
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  }
  use 'airblade/vim-rooter' -- Sets directory to git root
  -- }}}

  -- Markdown and Pandoc {{{
  use 'conornewton/vim-pandoc-markdown-preview'
  use {
    -- using cmd = 'MarkdownPreview' just causes problems and plugin does not load properly
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install'
  }
  -- }}}

end)
