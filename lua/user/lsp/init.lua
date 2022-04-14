require("lspconfig")

require "user.lsp.lsp-installer"
require "user.lsp.nvim-lightbulb-settings"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"
