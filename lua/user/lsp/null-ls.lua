local null_ls = require("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local hover = null_ls.builtins.hover

null_ls.setup({
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
          vim.cmd([[
          augroup LspFormatting
              autocmd! * <buffer>
              autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
          augroup END
          ]])
      end
  end,
	debug = false,
	sources = {
		formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
		-- formatting.clang_format,
		formatting.shfmt,
		diagnostics.markdownlint.with({filetypes =  {"markdown", "vimwiki"}}), -- https://github.com/DavidAnson/markdownlint
		diagnostics.write_good.with({filetypes =  {"markdown", "vimwiki", "gitcommit", "NeogitCommitMessage"}}), -- https://github.com/btford/write-good
		diagnostics.gitlint.with({filetypes = {"gitcommit","NeogitCommitMessage"}}),      -- https://jorisroovers.com/gitlint/
		hover.dictionary.with({filetypes =  {"markdown", "text", "vimwiki"}}),
		diagnostics.shellcheck, -- https://github.com/koalaman/shellcheck#installing Needs version 0.8.0 at least
    code_actions.shellcheck,
	},
})
