return {
    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        -- 2024-03-26, trying to make this plugin lazy does not always work. I've had success using the keys and cmd to load this plugin.
        -- It says "not an editor command". So, just load on filetype instead.
        ft = { 'markdown', 'vimwiki' },
        build = function()
            vim.fn['mkdp#util#install']()
        end,
        keys = {
            { '<leader>fM', desc = 'MarkdownPreview' },
        },
        config = function()
            vim.keymap.set('n', '<leader>fM', function()
                vim.cmd('MarkdownPreviewToggle')
            end, { silent = true, desc = 'MarkdownPreviewToggle' })

            vim.g.mkdp_filetypes = { 'markdown', 'vimwiki' }
            vim.g.mkdp_theme = 'light'
        end,
    },

    {
        'vimwiki/vimwiki',
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
    },

    {
        'epwalsh/obsidian.nvim',
        enabled = false,
        version = '*', -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = 'markdown',
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        -- event = {
        --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
        --   "BufReadPre path/to/my-vault/**.md",
        --   "BufNewFile path/to/my-vault/**.md",
        -- },
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        opts = {
            workspaces = {
                {
                    name = 'personal',
                    path = '~/.mywiki',
                },
            },
        },

        -- Optional, set to true to use the current directory as a vault; otherwise
        -- the first workspace is opened by default.
        detect_cwd = false,

        -- Optional, if you keep notes in a specific subdirectory of your vault.
        notes_subdir = 'notes',

        -- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
        -- levels defined by "vim.log.levels.*".
        log_level = vim.log.levels.INFO,

        daily_notes = {
            -- Optional, if you keep daily notes in a separate directory.
            folder = 'work/diary',
            -- Optional, if you want to change the date format for the ID of daily notes.
            date_format = '%Y-%m-%d',
            -- Optional, if you want to change the date format of the default alias of daily notes.
            alias_format = '%B %-d, %Y',
            -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
            template = 'daily_diary.md',
        },

        -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
        completion = {
            -- Set to false to disable completion.
            nvim_cmp = true,

            -- Trigger completion at 2 chars.
            min_chars = 2,

            -- Where to put new notes created from completion. Valid options are
            --  * "current_dir" - put new notes in same directory as the current buffer.
            --  * "notes_subdir" - put new notes in the default notes subdirectory.
            new_notes_location = 'current_dir',

            -- Control how wiki links are completed with these (mutually exclusive) options:
            --
            -- 1. Whether to add the note ID during completion.
            -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
            -- Mutually exclusive with 'prepend_note_path' and 'use_path_only'.
            prepend_note_id = false,
            -- 2. Whether to add the note path during completion.
            -- E.g. "[[Foo" completes to "[[notes/foo|Foo]]" assuming "notes/foo.md" is the path of the note.
            -- Mutually exclusive with 'prepend_note_id' and 'use_path_only'.
            prepend_note_path = false,
            -- 3. Whether to only use paths during completion.
            -- E.g. "[[Foo" completes to "[[notes/foo]]" assuming "notes/foo.md" is the path of the note.
            -- Mutually exclusive with 'prepend_note_id' and 'prepend_note_path'.
            use_path_only = true,
        },

        -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
        -- way then set 'mappings = {}'.
        mappings = {
            -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
            ['gf'] = {
                action = function()
                    return require('obsidian').util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            -- Toggle check-boxes.
            ['<leader>ch'] = {
                action = function()
                    return require('obsidian').util.toggle_checkbox()
                end,
                opts = { buffer = true },
            },
        },

        -- Optional, customize how names/IDs for new notes are created.
        note_id_func = function(title)
            -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
            -- In this case a note with the title 'My new note' will be given an ID that looks
            -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
            local suffix = ''
            if title ~= nil then
                -- If title is given, transform it into valid file name.
                suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
            else
                -- If title is nil, just add 4 random uppercase letters to the suffix.
                for _ = 1, 4 do
                    suffix = suffix .. string.char(math.random(65, 90))
                end
            end
            return tostring(os.time()) .. '-' .. suffix
        end,

        -- Optional, boolean or a function that takes a filename and returns a boolean.
        -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
        disable_frontmatter = false,

        -- Optional, alternatively you can customize the frontmatter data.
        note_frontmatter_func = function(note)
            -- This is equivalent to the default frontmatter function.
            local out = { id = note.id, aliases = note.aliases, tags = note.tags }
            -- `note.metadata` contains any manually added fields in the frontmatter.
            -- So here we just make sure those fields are kept in the frontmatter.
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                for k, v in pairs(note.metadata) do
                    out[k] = v
                end
            end
            return out
        end,

        -- Optional, for templates (see below).
        templates = {
            subdir = 'obsidian_helpers/templates',
            date_format = '%Y-%m-%d',
            time_format = '%H:%M',
            -- A map for custom variables, the key should be the variable and the value a function
            substitutions = {},
        },

        -- Optional, customize the backlinks interface.
        backlinks = {
            -- The default height of the backlinks pane.
            height = 10,
            -- Whether or not to wrap lines.
            wrap = true,
        },

        -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
        -- URL it will be ignored but you can customize this behavior here.
        follow_url_func = function(url)
            -- Open the URL in the default web browser.
            vim.fn.jobstart({ 'open', url }) -- Mac OS
            -- vim.fn.jobstart({"xdg-open", url})  -- linux
        end,

        -- Optional, set to true if you use the Obsidian Advanced URI plugin.
        -- https://github.com/Vinzent03/obsidian-advanced-uri
        use_advanced_uri = false,

        -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
        open_app_foreground = false,

        -- Optional, by default commands like `:ObsidianSearch` will attempt to use
        -- telescope.nvim, fzf-lua, fzf.vim, or mini.pick (in that order), and use the
        -- first one they find. You can set this option to tell obsidian.nvim to always use this
        -- finder.
        finder = 'telescope.nvim',

        -- Optional, configure key mappings for the finder. These are the defaults.
        -- If you don't want to set any mappings this way then set
        finder_mappings = {
            -- Create a new note from your query with `:ObsidianSearch` and `:ObsidianQuickSwitch`.
            -- Currently only telescope supports this.
            new = '<C-x>',
        },

        -- Optional, sort search results by "path", "modified", "accessed", or "created".
        -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
        -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
        sort_by = 'modified',
        sort_reversed = true,

        -- Optional, determines how certain commands open notes. The valid options are:
        -- 1. "current" (the default) - to always open in the current window
        -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
        -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
        open_notes_in = 'current',

        -- Optional, configure additional syntax highlighting / extmarks.
        -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
        ui = {
            enable = true,         -- set to false to disable all additional syntax features
            update_debounce = 200, -- update delay after a text change (in milliseconds)
            -- Define how various check-boxes are displayed
            checkboxes = {
                -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
                [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
                ['x'] = { char = '', hl_group = 'ObsidianDone' },
                ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
                ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
                -- Replace the above with this if you don't have a patched font:
                -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
                -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

                -- You can also add more custom ones...
            },
            external_link_icon = { char = '', hl_group = 'ObsidianExtLinkIcon' },
            -- Replace the above with this if you don't have a patched font:
            -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
            reference_text = { hl_group = 'ObsidianRefText' },
            highlight_text = { hl_group = 'ObsidianHighlightText' },
            tags = { hl_group = 'ObsidianTag' },
            hl_groups = {
                -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
                ObsidianTodo = { bold = true, fg = '#f78c6c' },
                ObsidianDone = { bold = true, fg = '#89ddff' },
                ObsidianRightArrow = { bold = true, fg = '#f78c6c' },
                ObsidianTilde = { bold = true, fg = '#ff5370' },
                ObsidianRefText = { underline = true, fg = '#c792ea' },
                ObsidianExtLinkIcon = { fg = '#c792ea' },
                ObsidianTag = { italic = true, fg = '#89ddff' },
                ObsidianHighlightText = { bg = '#75662e' },
            },
        },

        -- Specify how to handle attachments.
        attachments = {
            -- The default folder to place images in via `:ObsidianPasteImg`.
            -- If this is a relative path it will be interpreted as relative to the vault root.
            -- You can always override this per image by passing a full path to the command instead of just a filename.
            img_folder = 'assets/imgs', -- This is the default
            -- A function that determines the text to insert in the note when pasting an image.
            -- It takes two arguments, the `obsidian.Client` and a plenary `Path` to the image file.
            -- This is the default implementation.
            ---@param client obsidian.Client
            ---@param path Path the absolute path to the image file
            ---@return string
            img_text_func = function(client, path)
                local link_path
                local vault_relative_path = client:vault_relative_path(path)
                if vault_relative_path ~= nil then
                    -- Use relative path if the image is saved in the vault dir.
                    link_path = vault_relative_path
                else
                    -- Otherwise use the absolute path.
                    link_path = tostring(path)
                end
                local display_name = vim.fs.basename(link_path)
                return string.format('![%s](%s)', display_name, link_path)
            end,
        },

        -- Optional, set the YAML parser to use. The valid options are:
        --  * "native" - uses a pure Lua parser that's fast but potentially misses some edge cases.
        --  * "yq" - uses the command-line tool yq (https://github.com/mikefarah/yq), which is more robust
        --    but much slower and needs to be installed separately.
        -- In general you should be using the native parser unless you run into a bug with it, in which
        -- case you can temporarily switch to the "yq" parser until the bug is fixed.
        yaml_parser = 'native',
    },
}
