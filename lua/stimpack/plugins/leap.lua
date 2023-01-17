return {
    'ggandor/leap.nvim',
    keys = {'√', '\\'},
    config = function()
        require('leap').setup({
            max_phase_one_targets = nil,
            highlight_unlabeled_phase_one_targets = false,
            max_highlighted_traversal_targets = 10,
            case_sensitive = false,
            equivalence_classes = { ' \t\r\n' },
            substitute_chars = {},
            -- safe_labels = { 's', 'f', 'n', 'u', 't', . . . },
            -- labels = { 's', 'f', 'n', 'j', 'k', . . . },
            special_keys = {
                repeat_search = '<enter>',
                next_phase_one_target = '<enter>',
                next_target = { '<enter>', ';' },
                prev_target = { '<tab>', ',' },
                next_group = '<space>',
                prev_group = '<tab>',
                multi_accept = '<enter>',
                multi_revert = '<backspace>',
            },
        })
        require('leap').add_default_mappings()

        -- Searching in all windows (including the current one) on the tab page:
        local function leap_all_windows()
            -- require('leap').leap({
            --     target_windows = vim.tbl_filter(function(win)
            --         return vim.api.nvim_win_get_config(win).focusable
            --     end, vim.api.nvim_tabpage_list_wins(0)),
            -- })

            require('leap').leap({
                target_windows = vim.tbl_filter(function(win)
                    return vim.api.nvim_win_get_config(win).focusable
                end, vim.api.nvim_tabpage_list_wins(0)),
            })
        end

        -- Bidirectional search in the current window is just a specific case of the
        -- multi-window mode - set `target-windows` to a table containing the current
        -- window as the only element:
        local function leap_bidirectional()
            -- require('leap').leap({ target_windows = { vim.api.nvim_get_current_win() } })
            require('leap').leap({ target_windows = { vim.fn.win_getid() } })
        end

        local map = require('stimpack.mapping-function')
        map('n', '\\', leap_all_windows)
        map('n', '√', leap_bidirectional)
    end,
}
