require('lspconfig')

require('stimpack.lsp.lsp-installer')
require('stimpack.lsp.nvim-lightbulb-settings')
require('stimpack.lsp.nvim-code-action-menu-settings')
require('stimpack.lsp.handlers').setup()
require('stimpack.lsp.null-ls')
