-- Ｄｅｒｅｋ'ｓ ｉｎｉｔ.ｌｕａ

--[[ TODO:
fix nvim tree not closing on last file
fix nvim tree not closing when opening file

try out nvim-dap debugger -- needs more work

find function to check OS
try alpha as a replacement for startify
clear out the vim_blob file and move to lua
add auto command to set formatoptions
]]

-- Lua basic configuration
require('user.plugins')                              -- Source lua file ~/.config/nvim/lua/user/plugins.lua
require('user.settings')                             -- Source lua file ~/.config/nvim/lua/user/settings.lua
require('user.disable-vim-builtins')                 -- Source lua file ~/.config/nvim/lua/user/disable-vim-builtins.lua
require('user.visualsettings')                       -- Source lua file ~/.config/nvim/lua/user/visualsettings.lua
require('user.mappings')                             -- Source lua file ~/.config/nvim/lua/user/mappings.lua

-- Lua plugin configuration
require('user.telescopesettings')                    -- Source lua file ~/.config/nvim/lua/telescopesettings.lua
require('user.vim-pandoc-markdown-preview-settings') -- Source lua file ~/.config/nvim/lua/vim-pandoc-markdown-preview-settings.lua
require('user.treesitter')                           -- Source lua file ~/.config/nvim/lua/treesitter.lua
require('user.vimwikisettings')                      -- Vimwiki is a great personal wiki and diary
require('user.which-key')                            -- Which-key is AMAZING to help you remember your mappings
require('user.startify')                             -- Very good startup up application helper
require('user.markdown-preview')                     -- Preview markdown in browser
require('user.nvim-dap-settings')                    -- Debugging plugin
require('user.vim_blob')
require('user.lualine-settings')
require('user.nvim-tree-settings')
require('git.diffview')
require('git.neogit')
require('git.gitsigns-settings')
require('user.cmp')
require('user.lsp')
require('user.neoscroll')

-- Configuration for my personal plugins that I wrote
      require('user.dereks-plugins-config')                -- Source lua file ~/.config/nvim/lua/dereks-plugins-config.lua
