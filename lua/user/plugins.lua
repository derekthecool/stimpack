-- Using packer.nvim to manage plugins
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

  -- My plugins {{{
  use '~/dvp.nvim'
  -- }}}

  -- Vimwiki {{{
  use 'vimwiki/vimwiki'
  use 'mattn/calendar-vim'
  use 'godlygeek/tabular'
  use 'plasticboy/vim-markdown'
  -- }}}

  -- Pandoc / Latex {{{
  use 'conornewton/vim-pandoc-markdown-preview'
  -- }}}

  -- Tmux {{{
  use 'christoomey/vim-tmux-navigator'
  use 'tmux-plugins/vim-tmux-focus-events'
  use 'edkolev/tmuxline.vim'
  -- }}}

  -- Tree sitter, I can't get past the ABI errors https://github.com/nvim-treesitter/nvim-treesitter/issues/994 {{{
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/playground'
  -- }}}

  -- LSP setup {{{
  -- use 'neovim/nvim-lspconfig'
  -- use 'hrsh7th/cmp-nvim-lsp'
  -- use 'hrsh7th/cmp-buffer'
  -- use 'hrsh7th/cmp-path'
  -- use 'hrsh7th/cmp-cmdline'
  -- use 'hrsh7th/nvim-cmp'
  -- use 'quangnguyen30192/cmp-nvim-ultisnips'
  -- }}}

  -- Colors and themes {{{
  use 'chriskempson/base16-vim'                         -- Visual plugins
  use 'vim-airline/vim-airline'                         -- Nice looking bottom status bar
  use {'rrethy/vim-hexokinase', run = 'make hexokinase' } -- Color highlighter
  use 'kyazdani42/nvim-web-devicons'
  -- }}}

  -- General helper plugins {{{
  use 'tpope/vim-surround'                              -- Easily surround text
  use 'tpope/vim-unimpaired'                            -- Easily surround text
  use 'liuchengxu/vim-which-key'                        -- Convenience pop up guide
  use 'voldikss/vim-floaterm'                           -- Awesome floating terminal in vim
  use 'easymotion/vim-easymotion'                       -- Navigate similar to vimimum web browsing
  use 'mhinz/vim-startify'                              -- Really nice start menu for vim
  -- }}}

  -- Telescope Setup {{{
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'nvim-telescope/telescope-vimspector.nvim'
  use 'fannheyward/telescope-coc.nvim'
  -- }}}

  -- Coding helpers {{{
  use {'neoclide/coc.nvim', branch = 'release'}        -- Auto complete awesomeness
  use 'rafcamlet/nvim-luapad'                          -- Real time nvim lua scratch pad
  use 'folke/lua-dev.nvim'
  use {'autozimu/LanguageClient-neovim', branch = 'next', run = 'bash install.sh', }                  -- Bash LSP extension
  use 'honza/vim-snippets'                              -- Snippet resource
  use 'sheerun/vim-polyglot'                            -- Syntax highlight for many additional languages
  use 'puremourning/vimspector'                         -- Code debugger for vim
  use 'szw/vim-maximizer'                               -- Maximize a vim pane, to be used with vimspector
  use 'skywind3000/asynctasks.vim'                      -- Async build resource
  use 'skywind3000/asyncrun.vim'
  use 'skywind3000/asyncrun.extra'
  use 'RishabhRD/popfix'                                -- Needed for nvim-cheat.sh
  use 'RishabhRD/nvim-cheat.sh'                         -- Easy coding help from vim
  use 'AndrewRadev/linediff.vim'                        -- Diff items from the same file
  use 'dbeniamine/cheat.sh-vim'                         -- Another cheat sheet tool
  use {                                                 -- Comment plugin made with lua
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }
  -- }}}

  -- Git helpers {{{
  use 'airblade/vim-rooter'                             -- Sets directory to git root
  use 'tpope/vim-fugitive'                              -- Git client helper
  use 'tpope/vim-rhubarb'                               -- Git helper to open file in github
  use 'airblade/vim-gitgutter'                          -- Git gutter to see changes in files
  -- }}}

  -- Plugins can have post-install/update hooks

  -- using cmd = 'MarkdownPreview' just causes problems and plugin does not load properly
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install'
  }

end)

-- vim set foldmethod=marker
