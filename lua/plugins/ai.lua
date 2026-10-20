local tabterm = require('config.tab-terminal')
local toggle_key = '<leader>ac'

---Run a Claude Code command, giving the terminal a tab page of its own when the
---command has to create its window. The terminal keeps its default split position
---so claudecode re-shows it through its own drift-free path.
---@param cmd string
---@return fun()
local function claude(cmd)
    return function()
        local ok, terminal = pcall(require, 'claudecode.terminal')
        if ok and tabterm.find_win(terminal.get_active_terminal_bufnr()) then
            vim.cmd(cmd)
        else
            tabterm.open(function()
                vim.cmd(cmd)
            end)
        end
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
            { toggle_key, claude('ClaudeCodeFocus'), desc = 'Toggle Claude' },
            { '<leader>af', claude('ClaudeCodeFocus'), desc = 'Focus Claude' },
            { '<leader>ar', claude('ClaudeCode --resume'), desc = 'Resume Claude' },
            { '<leader>aC', claude('ClaudeCode --continue'), desc = 'Continue Claude' },
            { '<leader>am', claude('ClaudeCodeSelectModel'), desc = 'Select Claude model' },
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
