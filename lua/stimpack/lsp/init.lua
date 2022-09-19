-- Load mason.nvim first
require('stimpack.lsp.mason-mega-lsp-setup')
-- Load mason-lspconfig.nvim second

-- Load lspconfig third
require('lspconfig')

-- TODO: likely don't need this anymore
-- require('stimpack.lsp.lsp-config-setup')

-- require('stimpack.lsp.lsp-installer')
require('stimpack.lsp.nvim-lightbulb-settings')
require('stimpack.lsp.nvim-code-action-menu-settings')
require('stimpack.lsp.handlers').setup()
require('stimpack.lsp.null-ls')
