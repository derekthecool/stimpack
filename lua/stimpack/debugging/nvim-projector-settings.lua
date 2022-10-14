-- takes an optional argument for path, default is './.vim/projector.json'
-- require('projector.config_utils').load_project_configurations('./projector.json')
-- require('projector.config_utils').load_dap_configurations()

require('projector').setup({
  -- array of loader names with parameters (for available outputs see LOADERS.md)
  loaders = {
    {
      module = 'builtin',
      opt = vim.fn.getcwd() .. 'projector.json',
    },
    {
      module = 'dap',
      opt = '',
    },
  },
  -- map of outputs per mode (for available outputs see OUTPUTS.md)
  outputs = {
    task = 'builtin',
    debug = 'dap',
    database = 'dadbod',
  },
  -- function that formats the task selector output
  display_format = function(loader, scope, group, modes, name)
    return loader .. '  ' .. scope .. '  ' .. group .. '  ' .. modes .. '  ' .. name
  end,
  -- Reload configurations automatically before displaying task selector
  automatic_reload = false,
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
