-- Helpful mapping function from oroques.dev
-- https://oroques.dev/notes/neovim-init/#mappings
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

require('telescope').setup({
    defaults = {
      layout_config = {
        -- vertical = { width = 0.85 }
        -- other layout configuration here
      },
      mappings = {
        i = {
          ["<exc>"] = close
        },
      },
      -- other defaults configuration here
    },

    -- pickers = {
    --   find_files = {
    --     layout_strategy='vertical',
    --   },
    -- },

    -- other configuration values here
  })

-- Find files using Telescope command-line sugar.
--
-- Old way of mapping
-- map('n' , '<leader>fw' , '<cmd>Telescope find_files cwd=~/.mywiki<CR>'              , { noremap = true })
--
-- New way

map('n' , '<C-f>'      , "<cmd>lua require ('telescope.builtin').find_files({hidden=false})<CR>"                            , { noremap = true })
map('n' , '<leader>ff' , "<cmd>Telescope<CR>"                                                                 , { noremap = true })
map('n' , '<leader>fg' , "<cmd>lua require ('telescope.builtin').live_grep({layout_strategy='vertical'})<CR>" , { noremap = true })
map('n' , '<C-b>'      , "<cmd>lua require ('telescope.builtin').buffers({sort_mru=true                       , sort_lastused=true                              , ignore_current_buffer=true})<CR>"                  , { noremap = true })
map('n' , '<leader>fs' , "<cmd>lua require ('telescope.builtin').help_tags({layout_strategy='vertical'})<CR>" , { noremap = true })
map("n" , "<leader>fW" , "<cmd>lua require ('telescope.builtin').live_grep({layout_strategy='vertical'        , cwd='~/.mywiki'                                 , prompt_title='Live grep through .mywiki'})<CR>"    , { noremap = true })
map('n' , '<leader>fw' , "<cmd>lua require ('telescope.builtin').find_files({cwd='~/.mywiki'                  , prompt_title='Search .mywiki'})<CR>"            , { noremap = true })
map("n" , "<leader>fv" , "<cmd>lua require ('telescope.builtin').find_files({cwd='~/.config/nvim'             , prompt_title='Search vim config'})<CR>"         , { noremap = true })
map("n" , "<leader>fV" , "<cmd>lua require ('telescope.builtin').live_grep({layout_strategy='vertical'        , cwd='~/.config/nvim'                            , prompt_title='Live grep through vim config'})<CR>" , { noremap = true })
map("n" , "<leader>fd" , "<cmd>lua require ('telescope.builtin').find_files({cwd='~/'                         , prompt_title='Search WSL home directory'})<CR>" , { noremap = true })
map("n" , "<leader>fm" , "<cmd>lua require ('telescope.builtin').keymaps()<CR>"                               , { noremap = true })
-- lg = lua require ('telescope.builtin').live_grep(
--   {
--     layout_strategie = 'vertical'
--   }
--   )
require('telescope').load_extension('coc')
