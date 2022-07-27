require('git.diffview')
require('git.neogit')
require('git.gitsigns-settings')

local which_key_mapper = require('stimpack.which-key-mapping')
which_key_mapper({
  g = {
    name = "git", -- optional group name
    g = {
      "<cmd>lua require('neogit').open()<cr>",
      "Neogit"
    },
    G = {
      "<cmd>Gitsigns toggle_deleted<cr>",
      "Gitsigns toggle display of deleted lines"
    },
    B = {
      "<cmd>Gitsigns toggle_current_line_blame<cr>",
      "Gitsigns toggle display of deleted lines"
    },
    j = {
      "<cmd>lua require 'gitsigns'.next_hunk()<cr>",
      "Next Hunk"
    },
    k = {
      "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
      "Prev Hunk"
    },
    l = {
      "<cmd>lua require 'gitsigns'.blame_line()<cr>",
      "Blame"
    },
    p = {
      "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
      "Preview Hunk"
    },
    r = {
      "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
      "Reset Hunk"
    },
    R = {
      "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
      "Reset Buffer"
    },
    s = {
      "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
      "Stage Hunk"
    },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = {
      "<cmd>Telescope git_status<cr>",
      "Telescope: Open changed file"
    },
    b = {
      "<cmd>Telescope git_branches<cr>",
      "Telescope: Checkout branch"
    },
    c = {
      "<cmd>Telescope git_commits<cr>",
      "Telescope: Checkout commit"
    },
    d = {
      "<cmd>lua require('diffview').open()<cr>",
      "DiffViewOpen",
    },
    D = {
      "<cmd>lua require('diffview').close()<cr>",
      "DiffViewClose",
    },
    t = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  }
})
