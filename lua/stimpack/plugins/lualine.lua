return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    config = function()
        require('lualine').setup({
            options = {
                icons_enabled = true,
                theme = 'base16',
                component_separators = { left = Icons.ui.rightarrowhollow, right = Icons.ui.leftarrowhollow },
                section_separators = { left = Icons.ui.rightarrowfilled, right = Icons.ui.leftarrowfilled },
                disabled_filetypes = {},
                always_divide_middle = true,
                globalstatus = true,
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'TapeyTape', 'StimpackTestSummary.success', 'StimpackTestSummary.failure' },
                -- Color does not work for globals
                -- lualine_c = { 'TapeyTape', color = 'WarningMsg' },
                lualine_x = { 'filesize', 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress', 'WatchFileJumpToEnd' },
                lualine_z = { 'location' },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            extensions = { 'quickfix', 'man', 'toggleterm', 'nvim-tree', 'nvim-dap-ui', 'symbols-outline' },
        })
    end,
}
