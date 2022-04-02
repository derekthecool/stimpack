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
-- map('n' , '<leader>ff' , "<cmd>Telescope<CR>"                                                                 )
map('n' , '<leader>fg' , "<cmd>lua require ('telescope.builtin').live_grep({layout_strategy='vertical'})<CR>" )
map('n' , '<C-b>'      , "<cmd>lua require ('telescope.builtin').buffers({sort_mru=true                       , sort_lastused=true                              , ignore_current_buffer=true})<CR>"                  )
map('n' , '<leader>fs' , "<cmd>lua require ('telescope.builtin').help_tags({layout_strategy='vertical'})<CR>" )
map("n" , "<leader>fW" , "<cmd>lua require ('telescope.builtin').live_grep({layout_strategy='vertical'        , cwd='~/.mywiki'                                 , prompt_title='Live grep through .mywiki'})<CR>"    )
map('n' , '<leader>fw' , "<cmd>lua require ('telescope.builtin').find_files({cwd='~/.mywiki'                  , prompt_title='Search .mywiki'})<CR>"            )
map("n" , "<leader>fv" , "<cmd>lua require ('telescope.builtin').find_files({cwd='~/.config/nvim'             , prompt_title='Search vim config'})<CR>"         )
map("n" , "<leader>fV" , "<cmd>lua require ('telescope.builtin').live_grep({layout_strategy='vertical'        , cwd='~/.config/nvim'                            , prompt_title='Live grep through vim config'})<CR>" )
map("n" , "<leader>fd" , "<cmd>lua require ('telescope.builtin').find_files({cwd='~/'                         , prompt_title='Search WSL home directory'})<CR>" )
map("n" , "<leader>fm" , "<cmd>lua require ('telescope.builtin').keymaps()<CR>"                               , { noremap = true })

local which_key_mapper = require('user.which-key-mapping')
which_key_mapper({
f = {
  name = "file", -- optional group name
  f = { "<cmd>Telescope<cr>", "Telescope" }, -- create a binding with label
}
})

