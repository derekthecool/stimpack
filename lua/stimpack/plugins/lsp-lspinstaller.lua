-- I'm using the old nvim-lsp-installer only for omnisharp because it is not working on windows
-- This is a requirement for me. I've created this GitHub issue to track
-- https://github.com/williamboman/mason.nvim/issues/455
return {
    'williamboman/nvim-lsp-installer',
    dependencies = {
        'neovim/nvim-lspconfig',
    },
    event = 'VeryLazy',
    config = function()
        local lsp_installer = require('nvim-lsp-installer')
        lsp_installer.on_server_ready(function(server)
            local opts = {
                -- on_attach = require('stimpack.lsp.handlers').on_attach,
                capabilities = vim.lsp.protocol.make_client_capabilities(),
            }
            server:setup(opts)
        end)
    end,
}
