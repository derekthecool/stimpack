return {
    'nvim-lualine/lualine.nvim',
    -- config = function()
    --     -- Block lualines never ending warning message
    --     local notify_filter = vim.notify
    --     vim.notify = function(msg, ...)
    --         if msg:match(' Run :LualineNotices for details') then
    --             return
    --         end
    --
    --         notify_filter(msg, ...)
    --     end
    --
    --     require('lualine').setup({
    --         options = {
    --             icons_enabled = true,
    --             theme = 'auto',
    --             component_separators = { left = Icons.ui.rightarrowhollow, right = Icons.ui.leftarrowhollow },
    --             section_separators = { left = Icons.ui.rightarrowfilled, right = Icons.ui.leftarrowfilled },
    --             disabled_filetypes = {},
    --             always_divide_middle = true,
    --             globalstatus = true,
    --         },
    --         sections = {
    --             lualine_a = { 'mode' },
    --             lualine_b = { 'branch', 'diff', 'diagnostics' },
    --             lualine_c = { 'TapeyTape', 'StimpackTestSummary.success', 'StimpackTestSummary.failure' },
    --             -- Color does not work for globals
    --             -- lualine_c = { 'TapeyTape', color = 'WarningMsg' },
    --             lualine_x = { 'filesize', 'encoding', 'fileformat', 'filetype' },
    --             lualine_y = { 'progress', 'WatchFileJumpToEnd' },
    --             lualine_z = { 'location' },
    --         },
    --         inactive_sections = {
    --             lualine_a = {},
    --             lualine_b = {},
    --             lualine_c = { 'filename' },
    --             lualine_x = { 'location' },
    --             lualine_y = {},
    --             lualine_z = {},
    --         },
    --         tabline = {},
    --         winbar = {
    --             lualine_a = {},
    --             lualine_b = {},
    --             lualine_c = {},
    --             lualine_x = {},
    --             lualine_y = {},
    --             lualine_z = {},
    --         },
    --
    --         inactive_winbar = {
    --             lualine_a = {},
    --             lualine_b = {},
    --             lualine_c = { 'filename' },
    --             lualine_x = {},
    --             lualine_y = {},
    --             lualine_z = {},
    --         },
    --         extensions = { 'quickfix', 'man', 'toggleterm', 'nvim-tree', 'nvim-dap-ui', 'symbols-outline' },
    --     })
    -- end,
    -- opts = { options = { theme = 'auto' } },
    -- opts = { },
    config = function()
        local M = {}
        M.theme = function()
            local colors = {
                darkgray = '#16161d',
                gray = '#727169',
                innerbg = nil,
                outerbg = '#16161D',
                normal = '#7e9cd8',
                insert = '#98bb6c',
                visual = '#ffa066',
                replace = '#e46876',
                command = '#e6c384',
            }
            return {
                inactive = {
                    a = { fg = colors.gray, bg = colors.outerbg, gui = 'bold' },
                    b = { fg = colors.gray, bg = colors.outerbg },
                    c = { fg = colors.gray, bg = colors.innerbg },
                },
                visual = {
                    a = { fg = colors.darkgray, bg = colors.visual, gui = 'bold' },
                    b = { fg = colors.gray, bg = colors.outerbg },
                    c = { fg = colors.gray, bg = colors.innerbg },
                },
                replace = {
                    a = { fg = colors.darkgray, bg = colors.replace, gui = 'bold' },
                    b = { fg = colors.gray, bg = colors.outerbg },
                    c = { fg = colors.gray, bg = colors.innerbg },
                },
                normal = {
                    a = { fg = colors.darkgray, bg = colors.normal, gui = 'bold' },
                    b = { fg = colors.gray, bg = colors.outerbg },
                    c = { fg = colors.gray, bg = colors.innerbg },
                },
                insert = {
                    a = { fg = colors.darkgray, bg = colors.insert, gui = 'bold' },
                    b = { fg = colors.gray, bg = colors.outerbg },
                    c = { fg = colors.gray, bg = colors.innerbg },
                },
                command = {
                    a = { fg = colors.darkgray, bg = colors.command, gui = 'bold' },
                    b = { fg = colors.gray, bg = colors.outerbg },
                    c = { fg = colors.gray, bg = colors.innerbg },
                },
            }
        end
        require('lualine').setup({
            theme = M.theme(),
        })
    end,
}
