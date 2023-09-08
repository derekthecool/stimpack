return {
    'nvim-lualine/lualine.nvim',
    event = 'UIEnter',
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
                lualine_a = {
                    'mode',
                },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'TapeyTape', 'StimpackTestSummary.success', 'StimpackTestSummary.failure' },
                lualine_x = {
                    -- TODO: 8/7/2023 3:32:28 PM, find a way to get this working again without nil references
                    -- {
                    --     GetLuasnipAvailableSnippetCountForCurrentFile or 0,
                    --     color = { fg = '#1155ff', bg = 'Normal' },
                    -- },
                    '%S',
                    'filesize',
                    'selectioncount',
                    'encoding',
                    'fileformat',
                    'filetype',
                    {
                        function()
                            local lazyStartTime = require('lazy').stats().startuptime or 0
                            local time = string.format('%dms', lazyStartTime)
                            return time
                        end,
                        color = { fg = '#ffff64', bg = 'Normal' },
                    },
                    {
                        require('lazy.status').updates,
                        cond = require('lazy.status').has_updates,
                        color = { fg = '#ff9e64', bg = 'Normal' },
                    },
                },
                lualine_y = {
                    'progress',
                    'WatchFileJumpToEnd',
                },
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
            tabline = {
                lualine_a = {
                    -- 'filename',
                    {
                        'tabs',
                        -- max_length = vim.o.columns / 3, -- Maximum width of tabs component.
                        max_length = vim.o.columns, -- Maximum width of tabs component.
                        -- Note:
                        -- It can also be a function that returns
                        -- the value of `max_length` dynamically.
                        mode = 2, -- 0: Shows tab_nr
                        -- 1: Shows tab_name
                        -- 2: Shows tab_nr + tab_name

                        -- Automatically updates active tab color to match color of other components (will be overidden if buffers_color is set)
                        use_mode_colors = false,
                        -- tabs_color = {
                        --     -- Same values as the general color option can be used here.
                        --     active = 'lualine_{section}_normal', -- Color for active tab.
                        --     inactive = 'lualine_{section}_inactive', -- Color for inactive tab.
                        -- },
                        fmt = function(name, context)
                            -- Show + if buffer is modified in tab
                            local buflist = vim.fn.tabpagebuflist(context.tabnr)
                            local winnr = vim.fn.tabpagewinnr(context.tabnr)
                            local bufnr = buflist[winnr]
                            local mod = vim.fn.getbufvar(bufnr, '&mod')

                            return name .. (mod == 1 and ' ' or '')
                        end,
                    },
                    -- lualine_a = { 'buffers'
                },
                lualine_b = {},
                -- lualine_c = { 'filename' },
                lualine_x = {},
                lualine_y = {},
                lualine_z = { 'tabs' },
            },
            extensions = { 'quickfix', 'man', 'toggleterm', 'nvim-tree', 'nvim-dap-ui', 'symbols-outline' },
        })

        vim.api.nvim_set_hl(0, 'lualine_a_inactive', { link = 'Normal' })
    end,
}
