-- Vimwiki is a great personal wiki and diary
return {
    'vimwiki/vimwiki',
    enabled = false,
    ft = { 'markdown', 'vimwiki' },
    -- Startup is different when using lazy loading. The links are not concealed.
    init = function()
        vim.filetype.add({ extension = { md = 'vimwiki' }, priority = 100 })
    end,
    dependencies = {
        'godlygeek/tabular',
    },
    config = function()
        vim.filetype.add({ pattern = { ['*.md'] = 'vimwiki' } })

        -- Autocommand to trigger diary template using plugin template.nvim
        local VimwikiSettingsGroup = vim.api.nvim_create_augroup('Vimwiki snippets', { clear = true })
        vim.api.nvim_create_autocmd('BufNewFile', {
            pattern = '*/diary/*.md',
            callback = function()
                vim.cmd([[Template vimwiki_diary_starter]])
            end,
            group = VimwikiSettingsGroup,
        })

        -- Personal Wiki Setup
        local personal = {
            path = OS.join_path(OS['vimwiki'], 'personal'),
            syntax = 'markdown',
            ext = '.md',
            auto_diary_index = 1,
            list_margin = 0,
        }

        -- Work Wiki Setup
        local work = {
            path = OS.join_path(OS['vimwiki'], 'work'),
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
                l = {
                    -- Vimwiki function VimwikiToggleListItem is limiting
                    -- These series of commands make it easier for me to use
                    function()
                        local currentLine = vim.api.nvim_get_current_line()
                        local match = currentLine:match('- %[.%]')
                        if not match or match == '' then
                            vim.cmd('/- \\[.\\]')
                            vim.cmd('nohlsearch')
                        end

                        vim.cmd('VimwikiToggleListItem')
                        local cursor = vim.api.nvim_win_get_cursor(0)
                        cursor[1] = cursor[1] + 1
                        vim.api.nvim_win_set_cursor(0, cursor)
                    end,
                    'Toggle list item',
                },
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

        local path = OS.join_path(OS.nvim, 'lua', 'stimpack', 'markdown-textobjects-codeblock.vim')
        vim.cmd('source ' .. path)

        ---@diagnostic disable: redundant-parameter
        vim.fn.matchadd('Conceal', '[\\ \\]', nil, -1, { conceal = '⬛' })
        vim.fn.matchadd('Conceal', '[X\\]', nil, -1, { conceal = '✅' })
        vim.fn.matchadd('Conceal', '[x\\]', nil, -1, { conceal = '✅' })
        vim.fn.matchadd('Conceal', '[\\.\\]', nil, -1, { conceal = '🐌' })
        vim.fn.matchadd('Conceal', '[o\\]', nil, -1, { conceal = '🚙' })
        vim.fn.matchadd('Conceal', '[O\\]', nil, -1, { conceal = '🚁' })

        vim.wo.colorcolumn = '80' -- Display color column at 80 characters
        vim.opt.shiftwidth = 2

        vim.defer_fn(function()
            vim.api.nvim_set_hl(0, 'ColorColumn', { fg = '#750495' })
        end, 50)
    end,
}
