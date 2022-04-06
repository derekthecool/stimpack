local map = require('user.mapping-function')

require('telescope').setup({
    defaults = {
      layout_config = {
        vertical = { width = 0.85 }
        -- other layout configuration here
      },
      mappings = {
        i = {
          ["<exc>"] = close
        },
      },
      -- other defaults configuration here
    },

    pickers = {
      find_files = {
        layout_strategy='vertical',
      },
    },

    -- other configuration values here
  })

map('n' , '<C-f>'      , "<cmd>lua require ('telescope.builtin').git_files()<CR>"                            )
map('n' , '<M-f>'      , "<cmd>lua require ('telescope.builtin').find_files()<CR>"                            )
map('n' , '<C-b>'      , "<cmd>lua require ('telescope.builtin').buffers({sort_mru=true                       , sort_lastused=true                              , ignore_current_buffer=true})<CR>"                  )


local which_key_mapper = require('user.which-key-mapping')
which_key_mapper({
f = {
  name = "file", -- optional group name
  f = { "<cmd>Telescope<cr>", "Telescope" }, -- create a binding with label
  F = {"<cmd>lua require ('telescope.builtin').find_files({layout_strategy='vertical'})<CR>" , "Find Files"},
  G = {"<cmd>lua require ('telescope.builtin').git_files({layout_strategy='vertical'})<CR>" , "Git Files"},
  b = {"<cmd>lua require ('telescope.builtin').buffers({sort_mru=true,sort_lastused=true,ignore_current_buffer=true})<CR>" , "Local buffers"},
  g = {"<cmd>lua require ('telescope.builtin').live_grep({layout_strategy='vertical'})<CR>" , "Live grep"}, -- search locally with live grep
  v = {"<cmd>lua require ('telescope.builtin').find_files({cwd='~/.config/nvim'             , prompt_title='Search vim config'})<CR>"         , "Search vim config"}, -- search vim config files
  V = {"<cmd>lua require ('telescope.builtin').live_grep({layout_strategy='vertical'        , cwd='~/.config/nvim'                            , prompt_title='Live grep through vim config'})<CR>" , "Search vim config live grep"}, -- grep over vim config files
  d = {"<cmd>lua require ('telescope.builtin').find_files({cwd='~/'                         , prompt_title='Search WSL home directory'})<CR>" , "Find files"}, -- find files
  m = {"<cmd>lua require ('telescope.builtin').keymaps()<CR>"                               , "List key maps"}, -- list keymaps
}
})

