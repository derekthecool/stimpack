local tabterm = require('config.tab-terminal')
local toggle_key = '<leader>ac'

---Claude's own tab page makes hiding pointless: closing the window to get out of
---the way takes the tab page with it and the terminal has to be rebuilt to come
---back. So step out of the tab instead when we are standing in Claude, and focus it
---(creating it if it does not exist yet) from anywhere else.
local function focus_or_leave()
    local ok, terminal = pcall(require, 'claudecode.terminal')
    local buf = ok and terminal.get_active_terminal_bufnr()
    if buf and buf == vim.api.nvim_get_current_buf() then
        tabterm.leave()
    else
        vim.cmd.ClaudeCodeFocus()
    end
end

return {
    {
        'coder/claudecode.nvim',
        opts = {
            -- Diff Integration
            diff_opts = {
                layout = 'vertical', -- "vertical" or "horizontal"
                open_in_new_tab = true,
                keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens
                hide_terminal_in_new_tab = true,
                -- on_new_file_reject = "keep_empty", -- "keep_empty" or "close_window"

                -- Legacy aliases (still supported):
                -- vertical_split = true,
                -- open_in_current_tab = true,
            },
            terminal = {
                ---@module "snacks"
                ---@type snacks.win.Config|{}
                snacks_win_opts = {
                    -- Take the whole tab page claimed in `on_buf`. The default split
                    -- is a third of the screen that `tab-terminal` then widens, and
                    -- Claude never recovers from being resized that early
                    position = 'current',
                    -- Snacks opens the window right after this, so the tab claimed
                    -- here is the one Claude lands in, however it was started
                    on_buf = function()
                        tabterm.claim()
                    end,
                    keys = {
                        -- Snacks maps `q` to hide, which closes the window and takes
                        -- the tab page with it; stepping out keeps both
                        q = {
                            'q',
                            function()
                                tabterm.leave()
                            end,
                            desc = 'Leave Claude tab',
                        },
                        claude_leave = {
                            toggle_key,
                            function()
                                tabterm.leave()
                            end,
                            mode = 't',
                            desc = 'Leave Claude tab',
                        },
                    },
                },
            },
        },
        cmd = {
            'ClaudeCode',
            'ClaudeCodeFocus',
            'ClaudeCodeSelectModel',
            'ClaudeCodeAdd',
            'ClaudeCodeSend',
            'ClaudeCodeTreeAdd',
            'ClaudeCodeStatus',
            'ClaudeCodeStart',
            'ClaudeCodeStop',
            'ClaudeCodeOpen',
            'ClaudeCodeClose',
            'ClaudeCodeDiffAccept',
            'ClaudeCodeDiffDeny',
            'ClaudeCodeCloseAllDiffs',
        },
        keys = {
            { '<leader>a', '', desc = '+ai', mode = { 'n', 'v' } },
            { toggle_key, focus_or_leave, desc = 'Focus or leave Claude' },
            { '<leader>af', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
            { '<leader>ar', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
            { '<leader>aC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
            { '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select Claude model' },
            { '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
            { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude' },
            {
                '<leader>as',
                '<cmd>ClaudeCodeTreeAdd<cr>',
                desc = 'Add file',
                ft = { 'NvimTree', 'neo-tree', 'oil' },
            },
            -- Diff management
            { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
            { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
        },
    },
}
