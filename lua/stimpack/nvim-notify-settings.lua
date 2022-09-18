require('notify').setup({
    -- Minimum level to show
    level = 'info',

    -- Animation style (see below for details)
    stages = 'fade_in_slide_out',

    -- Function called when a new window is opened, use for changing win settings/config
    on_open = nil,

    -- Function called when a window is closed
    on_close = nil,

    -- Render function for notifications. See notify-render()
    render = 'default',

    -- Default timeout for notifications
    timeout = 5000,

    -- Max number of columns for messages
    max_width = nil,
    -- Max number of lines for a message
    max_height = nil,

    -- For stages that change opacity this is treated as the highlight behind the window
    -- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
    background_colour = 'Normal',

    -- Minimum width for notification windows
    minimum_width = 50,

    -- Icons for the different levels
    icons = {
        ERROR = Icons.diagnostics.error1,
        WARN = Icons.diagnostics.warning,
        INFO = Icons.diagnostics.information,
        DEBUG = Icons.debugging.bug,
        TRACE = Icons.documents.write2,
    },
})

-- Set as default notify system
vim.notify = require('notify')
