return {
    {
        'coder/claudecode.nvim',
        opts = {
            -- Diff Integration
            diff_opts = {
                layout = 'vertical', -- "vertical" or "horizontal"
                open_in_new_tab = true,
                keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens
                hide_terminal_in_new_tab = false,
                -- on_new_file_reject = "keep_empty", -- "keep_empty" or "close_window"

                -- Legacy aliases (still supported):
                -- vertical_split = true,
                -- open_in_current_tab = true,
            },
        },
        keys = {
            { '<leader>a', '', desc = '+ai', mode = { 'n', 'v' } },
            { '<leader>ac', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude' },
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
