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
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format('%s', Icons.coding[vim_item.kind])
            vim_item.menu = ({
                nvim_lsp = '[LSP]',
                nvim_lua = '[Nvim LSP]',
                luasnip = string.format('[Lua Snip %s ]', Icons.documents.cut),
                buffer = '[Buffer]',
                path = '[Path]',
            })[entry.source.name]
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
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
