--  ____                _    _       _       _ _     _
-- |  _ \  ___ _ __ ___| | _( )___  (_)_ __ (_) |_  | |_   _  __ _
-- | | | |/ _ \ '__/ _ \ |/ /// __| | | '_ \| | __| | | | | |/ _` |
-- | |_| |  __/ | |  __/   <  \__ \ | | | | | | |_ _| | |_| | (_| |
-- |____/ \___|_|  \___|_|\_\ |___/ |_|_| |_|_|\__(_)_|\__,_|\__,_|

-- Lua basic configuration
require('user.plugins')                              -- Source lua file ~/.config/nvim/lua/plugins.lua
require('user.settings')                             -- Source lua file ~/.config/nvim/lua/settings.lua
require('user.visualsettings')                       -- Source lua file ~/.config/nvim/lua/visualsettings.lua
require('user.mappings')                             -- Source lua file ~/.config/nvim/lua/mappings.lua
require('user.syntaxsettings')                       -- Source lua file ~/.config/nvim/lua/syntaxsettings.lua

-- Lua plugin configuration
-- require('user.lsp-setup')                            -- Source lua file ~/.config/nvim/lua/lsp-setup.lua
require('user.telescopesettings')                    -- Source lua file ~/.config/nvim/lua/telescopesettings.lua
require('user.vim-pandoc-markdown-preview-settings') -- Source lua file ~/.config/nvim/lua/vim-pandoc-markdown-preview-settings.lua
require('user.treesitter')                           -- Source lua file ~/.config/nvim/lua/treesitter.lua
require('user.vimwikisettings')                      -- Vimwiki is a great personal wiki and diary
require('user.which-key')                            -- Which-key is AMAZING to help you remember your mappings
require('user.startify')                             -- Very good startup up application helper
require('user.markdown-preview')                     -- Preview markdown in browser

-- Configuration for my personal plugins that I wrote
require('user.dereks-plugins-config')                -- Source lua file ~/.config/nvim/lua/dereks-plugins-config.lua

--Plugin specific configuration
vim.cmd[[
source ./viml/coc.vim              " Customizable popup window with MANY uses

source $HOME/.config/nvim/viml/floaterm.vim         " Customizable popup window with MANY uses
source $HOME/.config/nvim/viml/easymotion.vim       " Easy motion makes jumping around a file easier
source $HOME/.config/nvim/viml/tmuxline.vim         " Tmuxline vim/tmux plugin settings
source $HOME/.config/nvim/viml/asynctasks.vim       " Async build options
source $HOME/.config/nvim/viml/syntaxsettings.vim   " Lua file is not working so I am keeping this
source $HOME/.config/nvim/viml/mappings.vim         " My mapped commands not pertaining to any plugins
]]
