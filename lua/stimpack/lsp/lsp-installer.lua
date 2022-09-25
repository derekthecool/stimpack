-- I'm using the old nvim-lsp-installer only for omnisharp because it is not working on windows
-- This is a requirement for me. I've created this GitHub issue to track
-- https://github.com/williamboman/mason.nvim/issues/455
local lsp_installer = require('nvim-lsp-installer')
lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require('stimpack.lsp.handlers').on_attach,
    capabilities = require('stimpack.lsp.handlers').capabilities,
  }
  server:setup(opts)
end)
