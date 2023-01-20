-- Vimwiki is a great personal wiki and diary
return {
    'vimwiki/vimwiki',
    lazy = false,
    -- ft = { 'markdown', 'vimwiki' },
    -- init = function()
    --     vim.filetype.add({
    --         pattern = { ['*.md'] = 'vimwiki' },
    --     })
    -- end,
    dependencies = {
        'godlygeek/tabular',
    },
    config = function()
        -- Autocommand to trigger diary template.
        -- TODO: find a way to fully trigger the snippet
        local VimwikiSettingsGroup = vim.api.nvim_create_augroup('Vimwiki snippets', { clear = true })
        vim.api.nvim_create_autocmd('BufNewFile', {
            pattern = '*/diary/*.md',
            callback = function()
                vim.api.nvim_feedkeys('ivimwikiDiaryStarter', 'nti', false)
            end,
            group = VimwikiSettingsGroup,
        })

        -- Personal Wiki Setup
        local personal = {
            path = OS.home .. '/.mywiki/personal/',
            syntax = 'markdown',
            ext = '.md',
            auto_diary_index = 1,
            list_margin = 0,
        }

        -- Work Wiki Setup
        local work = {
            path = OS.home .. '/.mywiki/work/',
            syntax = 'markdown',
            ext = '.md',
            auto_diary_index = 1,
            list_margin = 0,
        }

        -- Apply the different Wiki's into the setup vimwiki_list
        vim.g.vimwiki_list = { personal, work }

        -- Allow automatic syntax check for code blocks
        vim.g.automatic_nested_syntaxes = 1

        local which_key_mapper = require('stimpack.which-key-mapping')
        which_key_mapper({
            f = {
                name = 'file', -- optional group name
                W = {
                    '<cmd>lua require (\'telescope.builtin\').live_grep({layout_strategy=\'vertical\', cwd=\'~/.mywiki\', prompt_title=\'Live grep through .mywiki\'})<CR>',
                    'Live grep my wiki',
                },
                w = {
                    '<cmd>lua require (\'telescope.builtin\').find_files({cwd=\'~/.mywiki\', prompt_title=\'Search .mywiki\'})<CR>',
                    'Search my wiki',
                },
            },

            v = {
                name = 'vimwiki',
                D = {
                    '<cmd>VimwikiDiaryNextDay<cr>',
                    'Diary next day',
                },
                d = { '<cmd>VimwikiDiaryPrevDay<cr>', 'Diary previous day' },
                h = { '<cmd>VimwikiSplitLink<cr>', 'Follow Link Horizontal' },
                l = { '<cmd>VimwikiToggleListItem<cr>', 'Toggle list item' },
                ['/'] = { '<cmd>VimwikiSearch<cr>', 'Vimwiki Search' },
                j = { '<cmd>lnext<cr>', 'Next search result' },
                k = { '<cmd>lprevious<cr>', 'Previous search result' },
                o = { '<cmd>lopen<cr>', 'Open list of all search results' },
                v = { '<cmd>VimwikiVSplitLink<cr>', 'Follow Link Verical' },
                u = { '<cmd>VimwikiNextTask<cr>', 'Find Next Unfinished Task' },
                T = { '<cmd>VimwikiTable<cr>', 'Vimwiki Table Insert' },
                t = { ':Tabularize /', 'Tabularize formatting' },
            },
        })

        local path = OS.join_path({ OS.nvim, 'lua', 'stimpack', 'markdown-textobjects-codeblock.vim' })
        vim.cmd('source ' .. path)

        ---@diagnostic disable: redundant-parameter
        vim.fn.matchadd('Conceal', '[\\ \\]', nil, -1, { conceal = '⬛' })
        vim.fn.matchadd('Conceal', '[X\\]', nil, -1, { conceal = '✅' })
        vim.fn.matchadd('Conceal', '[x\\]', nil, -1, { conceal = '✅' })
        vim.fn.matchadd('Conceal', '[\\.\\]', nil, -1, { conceal = '🐌' })
        vim.fn.matchadd('Conceal', '[o\\]', nil, -1, { conceal = '🚙' })
        vim.fn.matchadd('Conceal', '[O\\]', nil, -1, { conceal = '🚁' })
    end,
}
