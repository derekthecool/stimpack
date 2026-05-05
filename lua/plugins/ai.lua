local toggle_key = '<leader>ac'

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
                    position = 'float',
                    width = 0.9,
                    height = 0.9,
                    keys = {
                        claude_hide = {
                            toggle_key,
                            function(self)
                                self:hide()
                            end,
                            mode = 't',
                            desc = 'Hide',
                        },
                    },
                },
            },
        },
        keys = {
            { '<leader>a', '', desc = '+ai', mode = { 'n', 'v' } },
            { toggle_key, '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude' },
            { '<leader>af', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
            { '<leader>ar', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
            { '<leader>aC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
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
