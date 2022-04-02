-- Using packer.nvim to mantage plugins
-- https://github.com/wbthomason/packer.nvim

-- Bootstrap function to install packer.nvim if it does not exist
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- My plugins
  -- Use the local development version if it is found
  -- Else pull it from GitHub
  local HOME = os.getenv('HOME')
  if HOME ~= nil and io.open(HOME .. '/dvp.nvim/README.md','r') ~= nil then
    use '~/dvp.nvim'
  else
    use 'derekthecool/dvp.nvim'
  end

  -- Vimwiki
  use 'vimwiki/vimwiki'
  use 'mattn/calendar-vim'
  use 'godlygeek/tabular'
  use 'plasticboy/vim-markdown'

  -- Pandoc / Latex
  use 'conornewton/vim-pandoc-markdown-preview'

  -- Tmux
  use 'christoomey/vim-tmux-navigator'
  use 'tmux-plugins/vim-tmux-focus-events'
  use 'edkolev/tmuxline.vim'

  -- Tree sitter, I can't get past the ABI errors https://github.com/nvim-treesitter/nvim-treesitter/issues/994
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/playground'

  -- LSP setup
  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  -- Colors and themes
  use 'chriskempson/base16-vim'                         -- Visual plugins
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  -- Very nice but I don't need it always, so leave commented
  -- use {'rrethy/vim-hexokinase', run = 'make hexokinase' } -- Color highlighter
  use 'kyazdani42/nvim-web-devicons'

  -- General helper plugins
  use 'tpope/vim-surround'                              -- Easily surround text
  use 'tpope/vim-unimpaired'                            -- Easily surround text
  use 'folke/which-key.nvim'                            -- Shows mappings with helpful pop up
  use 'voldikss/vim-floaterm'                           -- Awesome floating terminal in vim
  use 'ggandor/lightspeed.nvim'
  use 'mhinz/vim-startify'                              -- Really nice start menu for vim
  use 'karb94/neoscroll.nvim'                           -- Smooth scroll with <C-d> and <C-u>

  -- Telescope Setup
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  -- use 'nvim-telescope/telescope-vimspector.nvim'
  -- use 'fannheyward/telescope-coc.nvim'

  -- Coding helpers
  -- use {'neoclide/coc.nvim', branch = 'release'}        -- Auto complete awesomeness
  use 'rafcamlet/nvim-luapad'                          -- Real time nvim lua scratch pad
  use 'folke/lua-dev.nvim'
  use {'autozimu/LanguageClient-neovim', branch = 'next', run = 'bash install.sh', }                  -- Bash LSP extension
  -- use 'sheerun/vim-polyglot'                            -- Syntax highlight for many additional languages
  use 'mfussenegger/nvim-dap'
  -- use 'puremourning/vimspector'                         -- Code debugger for vim
  use 'szw/vim-maximizer'                               -- Maximize a vim pane, to be used with vimspector
  use 'skywind3000/asynctasks.vim'                      -- Async build resource
  use 'skywind3000/asyncrun.vim'
  use 'skywind3000/asyncrun.extra'
  use {'RishabhRD/nvim-cheat.sh',  -- Easy coding help from vim
       requires = {
        'RishabhRD/popfix'
       },
     }
  -- TODO: not sure if this is needed
  -- use 'dbeniamine/cheat.sh-vim'                         -- Another cheat sheet tool

  use 'AndrewRadev/linediff.vim'                        -- Diff items from the same file
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end
  }
  use {                                                 -- Comment plugin made with lua
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }

  -- Git helpers
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
  use 'airblade/vim-rooter'                             -- Sets directory to git root
  -- use 'airblade/vim-gitgutter'                          -- Git gutter to see changes in files
  -- use 'tpope/vim-fugitive'                              -- Git client helper
  -- use 'tpope/vim-rhubarb'                               -- Git helper to open file in github

  -- Plugins can have post-install/update hooks

  -- using cmd = 'MarkdownPreview' just causes problems and plugin does not load properly
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install'
  }

end)
