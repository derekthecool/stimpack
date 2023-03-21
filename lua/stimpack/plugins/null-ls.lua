return {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'VeryLazy',
    config = function()
        local null_ls = require('null-ls')

        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
        local formatting = null_ls.builtins.formatting

        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
        local diagnostics = null_ls.builtins.diagnostics
        local code_actions = null_ls.builtins.code_actions
        local hover = null_ls.builtins.hover

        null_ls.setup({
            debug = false,
            sources = {
                formatting.csharpier,
                formatting.prettier.with({ extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' } }),
                formatting.black.with({ extra_args = { '--fast' } }),
                formatting.stylua,
                formatting.prettier.with({
                    filetypes = { 'markdown', 'vimwiki' },
                    extra_args = { '--embedded-language-formatting=off' },
                }),

                -- This is getting really annoying to see write good errors
                -- diagnostics.write_good.with({ filetypes = { 'markdown', 'vimwiki', 'gitcommit', 'NeogitCommitMessage' } }), -- https://github.com/btford/write-good

                diagnostics.gitlint.with({ filetypes = { 'gitcommit', 'NeogitCommitMessage' } }), -- https://jorisroovers.com/gitlint/
                hover.dictionary.with({ filetypes = { 'markdown', 'text', 'vimwiki' } }),

                -- Shell scripting
                -- args = { "-i 2", "-filename", "$FILENAME"}, -- You can't use extra args with this as all args must be before filename
                formatting.shfmt,
                diagnostics.shellcheck, -- https://github.com/koalaman/shellcheck#installing Needs version 0.8.0 at least
                code_actions.shellcheck,
            },
        })
    end,
}
