-- Load mason.nvim first
require('stimpack.lsp.mason-mega-lsp-setup')
require('stimpack.lsp.lsp-installer')
-- Load mason-lspconfig.nvim second

-- Load lspconfig third
require('lspconfig')

-- TODO: Get LSP document scrolling to work. I want to look at csharp function overloads!
-- require('stimpack.lsp.lsp-installer')
require('stimpack.lsp.nvim-lightbulb-settings')
require('stimpack.lsp.nvim-code-action-menu-settings')
require('stimpack.lsp.handlers').setup()
require('stimpack.lsp.null-ls')
