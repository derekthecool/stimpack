return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-buffer', -- buffer completions
        'hrsh7th/cmp-path', -- path completions
        'hrsh7th/cmp-cmdline', -- cmdline completions
        'hrsh7th/cmp-nvim-lsp-signature-help', -- Show function help while typing
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-calc',
        'saadparwaiz1/cmp_luasnip', -- snippet completions
    },
    event = 'InsertEnter',
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        local check_backspace = function()
            local col = vim.fn.col('.') - 1
            return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
        end

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = {
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                ['<C-e>'] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                -- Accept currently selected item. If none selected, `select` first item.
                -- Set `select` to `false` to only confirm explicitly selected items.
                ['∃'] = cmp.mapping.confirm({ select = true }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expandable() then
                        luasnip.expand()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif check_backspace() then
                        fallback()
                    else
                        fallback()
                    end
                end, {
                    'i',
                    's',
                }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {
                    'i',
                    's',
                }),
            },
            formatting = {
                fields = { 'abbr', 'kind', 'menu' },
                format = function(entry, vim_item)
                    -- Kind icons
                    vim_item.kind = string.format('%s %s', Icons.coding[vim_item.kind], vim_item.kind)
                    -- vim_item.menu = ({
                    --     nvim_lsp = '[LSP]',
                    --     nvim_lua = '[Nvim LSP]',
                    --     luasnip = '[Lua Snip]',
                    --     buffer = '[Buffer]',
                    --     path = '[Path]',
                    -- })[entry.source.name]
                    return vim_item
                end,
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
                { name = 'nvim_lsp_signature_help' },
                { name = 'emoji' },
                { name = 'calc' },
            },
            confirm_opts = {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            },
            window = {
                completion = {
                    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
                    winhighlight = 'Normal:DevIconEex,FloatBorder:DevIconGitIgnore,CursorLine:DevIconJpg,Search:None',
                    scrolloff = 0,
                    col_offset = 0,
                    side_padding = 1,
                },
                documentation = {
                    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
                    -- max_height = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
                    -- max_width = math.floor((WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
                    winhighlight = 'FloatBorder:NormalFloat',
                },
            },
            view = {
                native_menu = true,
            },
            experimental = {
                ghost_text = true,
            },
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        -- cmp.setup.cmdline({ '/', '?' }, {
        --     mapping = cmp.mapping.preset.cmdline(),
        --     sources = {
        --         { name = 'buffer' },
        --     },
        -- })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' },
            }, {
                { name = 'cmdline' },
            }),
        })

        -- Custom colors
        vim.api.nvim_set_hl(0, 'CmpItemKindText', { fg = '#28d0ff' })
        vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { fg = '#aa5a7d' })
        vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { fg = '#6ee65f' })
        vim.api.nvim_set_hl(0, 'CmpItemKindConstructor', { fg = '#a8807d' })
        vim.api.nvim_set_hl(0, 'CmpItemKindField', { fg = '#3200ff' })
        vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { fg = '#003c87' })
        vim.api.nvim_set_hl(0, 'CmpItemKindClass', { fg = '#323264' })
        vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { fg = '#99664d' })
        vim.api.nvim_set_hl(0, 'CmpItemKindModule', { fg = '#335ab3' })
        vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { fg = '#7800ff' })
        vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { fg = '#1e4db3' })
        vim.api.nvim_set_hl(0, 'CmpItemKindValue', { fg = '#e6331a' })
        vim.api.nvim_set_hl(0, 'CmpItemKindEnum', { fg = '#e6e6b3' })
        vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { fg = '#3232ff' })
        vim.api.nvim_set_hl(0, 'CmpItemKindSnippet', { fg = '#b33366' })
        vim.api.nvim_set_hl(0, 'CmpItemKindColor', { fg = '#e600ff' })
        vim.api.nvim_set_hl(0, 'CmpItemKindFile', { fg = '#4d4d00' })
        vim.api.nvim_set_hl(0, 'CmpItemKindReference', { fg = '#cccc33' })
        vim.api.nvim_set_hl(0, 'CmpItemKindFolder', { fg = '#cccccc' })
        vim.api.nvim_set_hl(0, 'CmpItemKindEnummember', { fg = '#334d66' })
        vim.api.nvim_set_hl(0, 'CmpItemKindConstant', { fg = '#b399f0' })
        vim.api.nvim_set_hl(0, 'CmpItemKindStruct', { fg = '#e64d33' })
        vim.api.nvim_set_hl(0, 'CmpItemKindEvent', { fg = '#b333e6' })
        vim.api.nvim_set_hl(0, 'CmpItemKindOperator', { fg = '#33e6b3' })
        vim.api.nvim_set_hl(0, 'CmpItemKindTypeparameter', { fg = '#004d00' })
    end,
}
