require('dapui').setup({
    icons = { expanded = Icons.ui.arrowclosed2, collapsed = Icons.ui.arrowopen2 },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        edit = 'e',
        repl = 'r',
        toggle = 't',
    },
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = vim.fn.has('nvim-0.7'),
    -- Layouts define sections of the screen to place windows.
    -- The position can be "left", "right", "top" or "bottom".
    -- The size specifies the height/width depending on position.
    -- Elements are the elements shown in the layout (in order).
    -- Layouts are opened in order so that earlier layouts take priority in window sizing.
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = 'scopes', size = 0.25 },
                'breakpoints',
                'stacks',
                'watches',
            },
            size = 40,
            position = 'left',
        },
        {
            elements = {
                'console',
            },
            size = 15,
            position = 'bottom',
        },
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = 'single', -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { 'q', '<Esc>' },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
    },
})

local dap, dapui = require('dap'), require('dapui')
dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
end
