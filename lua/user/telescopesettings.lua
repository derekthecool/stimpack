if not pcall(require, 'telescope') then return end
local map = require('user.mapping-function')

-- useful icons:    

local layout_config = 'vertical'

require('telescope').setup({
  defaults = {
    layout_config = {
      vertical = { width = 0.85 },
    },
    mappings = {
      i = {
        ["<esc>"] = require('telescope.actions').close,
        -- ["<c-f>"] = vim.cmd[[<plug>Telescope<CR>]],
      },
    },
    -- other defaults configuration here
  },

  pickers = {
    find_files = {
      layout_strategy = layout_config,
      prompt_prefix = " : ",
    },
    git_files = {
      layout_strategy = layout_config,
      prompt_prefix = " : ",
      show_untracked = true,
    },
    help_tags = {
      layout_strategy = layout_config,
      prompt_prefix = " : ",
      show_untracted = true,
    },
    buffers = {
      layout_strategy = layout_config,
      prompt_prefix = " : ",
      sort_mru = true,
      sort_lastused = true,
      ignore_current_buffer = true,
    },
    live_grep = {
      -- borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      prompt_prefix = " : ",
      results_title = "Found",
      preview_title = "Preview",
      prompt_title = "File Content Search",
      disable_coordinates = true,
      disable_devicons = true,
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--multiline-dotall",
        "--smart-case"
      },
    },
  },

  -- other configuration values here
})

-- Extensions to load
require("telescope").load_extension("emoji")

local function gitfiles_or_findfiles()
  local builtin = require('telescope.builtin')
  if Execute("git rev-parse --is-inside-work-tree").ret == 0 then
    return builtin.git_files()
  else
    return builtin.find_files()
  end
end

map('n', '<C-f>', gitfiles_or_findfiles)
map('n', '<C-b>',
  "<cmd>lua require ('telescope.builtin').buffers({sort_mru=true, sort_lastused=true, ignore_current_buffer=true})<CR>")


local which_key_mapper = require('user.which-key-mapping')
local builtins = require('telescope.builtin')
which_key_mapper({
  f = {
    name = "file", -- optional group name
    f = { "<cmd>Telescope<cr>", "Telescope" }, -- create a binding with label
    F = { builtins.find_files, "Find Files" },
    G = { builtins.git_files, "Git Files" },
    E = { "<cmd>Telescope emoji<CR>", "Telescope extension: emoji" },
    b = { builtins.buffers, "Local buffers" },
    g = { builtins.live_grep, "Live grep" }, -- search locally with live grep (uses ripgrep in the background)
    h = { builtins.help_tags, "Help Search" },

    -- v = { builtins.find_files {
    --   cwd = OS.nvim,
    --   prompt_title = 'Search vim config'
    -- }, "Search vim config" }, -- search vim config files

    V = { "<cmd>lua require ('telescope.builtin').live_grep({layout_strategy='vertical'        , cwd='~/.config/nvim'                            , prompt_title='Live grep through vim config'})<CR>",
      "Search vim config live grep" }, -- grep over vim config files
    d = { "<cmd>lua require ('telescope.builtin').find_files({cwd='~/'                         , prompt_title='Search WSL home directory'})<CR>",
      "Find files" }, -- find files
    m = { builtins.keymaps, "List key maps" }, -- list keymaps
  },

  l = {
    name = "LSP",
    -- A = { builtins.code_actions{}, "Telescope: code action" },
  },
})
