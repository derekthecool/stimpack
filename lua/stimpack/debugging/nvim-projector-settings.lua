-- takes an optional argument for path, default is './.vim/projector.json'
-- require('projector.config_utils').load_project_configurations('./projector.json')
-- require('projector.config_utils').load_dap_configurations()

--[[
Issues with new refactor projector
-- Legacy
- Parsing legacy json config reported success but then gave me a empty file
- After the parsing fairliure it throws an error that it could not parse json

-- New built in

]]

require('projector').setup({
    loaders = {
        {
            module = 'builtin',
            options = {
                path = vim.fn.getcwd() .. OS.separator .. 'projector.json',
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

local map = require('stimpack.mapping-function')

map('n', '<leader>dd', require('projector').continue)
map('n', '_', require('projector').continue)
