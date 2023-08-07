return {
    'kndndrj/nvim-projector',
    keys = {
        '_',
    },
    config = function()
        require('projector').setup({
            loaders = {
                {
                    module = 'builtin',
                    options = {
                        -- path = vim.fn.getcwd() .. OS.separator .. 'projector.json',
                        path = OS.join_path(vim.fn.getcwd(), 'projector.json'),
                        configs = nil,
                    },
                },
            },
            display_format = function(_, scope, group, modes, name)
                return scope .. '  ' .. group .. '  ' .. modes .. '  ' .. name
            end,
            automatic_reload = true,
            -- local output_config = require("projector").config.outputs[mode]
            outputs = {
                task = {
                    module = 'builtin',
                    options = nil,
                },
                debug = {
                    module = 'dap',
                    options = nil,
                },
                database = {
                    module = 'dadbod',
                    options = nil,
                },
            },
            -- Reload configurations automatically before displaying task selector
            -- map of icons
            -- NOTE: "groups" use nvim-web-devicons if available
            icons = {
                enable = true,
                scopes = {
                    global = '',
                    project = '',
                },
                groups = {},
                loaders = {},
                modes = {
                    task = '',
                    debug = '',
                    database = '',
                },
            },
        })

        vim.keymap.set('n', '_', function()
            require('projector').continue()
        end, { silent = true, desc = 'Projector continue' })
    end,
}
