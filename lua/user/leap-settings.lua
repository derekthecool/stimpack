-- if not pcall(require, GetPackageNameFromCurrentFile(debug.getinfo(1).source)) then return else print(GetPackageNameFromCurrentFile(debug.getinfo(1).source))end
-- if not  then return end

require('leap').setup {
  highlight_ahead_of_time = true,
  highlight_unlabeled = false,
  case_sensitive = false,
  -- Groups of characters that should match each other.
  -- E.g.: { "([{<", ")]}>", "'\"`", }
  character_classes = {},
  -- Leaving the appropriate list empty effectively disables "smart" mode,
  -- and forces auto-jump to be on or off.
  -- safe_labels = { . . . },
  -- labels = { . . . },
  -- These keys are captured directly by the plugin at runtime.
  special_keys = {
    repeat_search = '<enter>',
    next_match    = '<enter>',
    prev_match    = '<tab>',
    next_group    = '<space>',
    prev_group    = '<tab>',
    eol           = '<space>',
  },
}

-- Searching in all windows (including the current one) on the tab page:
local function leap_all_windows()
  require 'leap'.leap {
    target_windows = vim.tbl_filter(
      function(win) return vim.api.nvim_win_get_config(win).focusable end,
      vim.api.nvim_tabpage_list_wins(0)
    )
  }
end

-- Bidirectional search in the current window is just a specific case of the
-- multi-window mode - set `target-windows` to a table containing the current
-- window as the only element:
local function leap_bidirectional()
  require 'leap'.leap { target_windows = { vim.api.nvim_get_current_win() } }
end

local map = require('user.mapping-function')
map("n", "\\", leap_all_windows)
map("n", "√", leap_bidirectional)
