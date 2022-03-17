--  ____                _    _       _       _ _     _
-- |  _ \  ___ _ __ ___| | _( )___  (_)_ __ (_) |_  | |_   _  __ _
-- | | | |/ _ \ '__/ _ \ |/ /// __| | | '_ \| | __| | | | | |/ _` |
-- | |_| |  __/ | |  __/   <  \__ \ | | | | | | |_ _| | |_| | (_| |
-- |____/ \___|_|  \___|_|\_\ |___/ |_|_| |_|_|\__(_)_|\__,_|\__,_|

-- Lua basic configuration
require('user.plugins')                              -- Source lua file ~/.config/nvim/lua/user/plugins.lua
require('user.settings')                             -- Source lua file ~/.config/nvim/lua/user/settings.lua
require('user.disable-vim-builtins')                 -- Source lua file ~/.config/nvim/lua/user/disable-vim-builtins.lua
require('user.visualsettings')                       -- Source lua file ~/.config/nvim/lua/user/visualsettings.lua
require('user.mappings')                             -- Source lua file ~/.config/nvim/lua/user/mappings.lua
require('user.syntaxsettings')                       -- Source lua file ~/.config/nvim/lua/user/syntaxsettings.lua

-- Lua plugin configuration
-- require('user.lsp-setup')                            -- Source lua file ~/.config/nvim/lua/lsp-setup.lua
require('user.telescopesettings')                    -- Source lua file ~/.config/nvim/lua/telescopesettings.lua
require('user.vim-pandoc-markdown-preview-settings') -- Source lua file ~/.config/nvim/lua/vim-pandoc-markdown-preview-settings.lua
require('user.treesitter')                           -- Source lua file ~/.config/nvim/lua/treesitter.lua
require('user.vimwikisettings')                      -- Vimwiki is a great personal wiki and diary
require('user.which-key')                            -- Which-key is AMAZING to help you remember your mappings
require('user.startify')                             -- Very good startup up application helper
require('user.markdown-preview')                     -- Preview markdown in browser
require('user.vim_blob')

-- Configuration for my personal plugins that I wrote
require('user.dereks-plugins-config')                -- Source lua file ~/.config/nvim/lua/dereks-plugins-config.lua
