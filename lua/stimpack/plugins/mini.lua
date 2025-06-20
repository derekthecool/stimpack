-- https://github.com/echasnovski/mini.nvim
return {
    'echasnovski/mini.nvim',
    event = 'VeryLazy',
    config = function()
        -- Amazing text alignment
        -- Replaces plugin: https://github.com/godlygeek/tabular
        -- Though I still need tabular because vimwiki needs it for nice markdown table auto formatting

        --[[
        Mini align demo https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-align.md
        Press gaip to start formatting the block
        Press s to choose delimiter
        Press , to align on commas boom-boom-boom

        cord, dog, cow, supercalifragilisticexpialidocious
        log, trig, micron, blockyinging

        cord, dog , cow   , supercalifragilisticexpialidocious
        log , trig, micron, blockyinging

        ]]
        require('mini.align').setup({
            -- Module mappings. Use `''` (empty string) to disable one.
            mappings = {
                start = 'ga',
                start_with_preview = 'gA',
            },
            -- Modifiers changing alignment steps and/or options
            -- modifiers = {
            --   -- Main option modifiers
            --   ['s'] = --<function: enter split pattern>,
            --   ['j'] = --<function: choose justify side>,
            --   ['m'] = --<function: enter merge delimiter>,
            --
            --   -- Modifiers adding pre-steps
            --   ['f'] = --<function: filter parts by entering Lua expression>,
            --   ['i'] = --<function: ignore some split matches>,
            --   ['p'] = --<function: pair parts>,
            --   ['t'] = --<function: trim parts>,
            --
            --   -- Delete some last pre-step
            --   ['<BS>'] = --<function: delete some last pre-step>,
            --
            --   -- Special configurations for common splits
            --   ['='] = --<function: enhanced setup for '='>,
            --   [','] = --<function: enhanced setup for ','>,
            --   [' '] = --<function: enhanced setup for ' '>,
            -- },

            -- Default options controlling alignment process
            options = {
                split_pattern = '',
                justify_side = 'right',
                merge_delimiter = '',
            },
            -- Default steps performing alignment (if `nil`, default is used)
            steps = {
                pre_split = {},
                split = nil,
                pre_justify = {},
                justify = nil,
                pre_merge = {},
                merge = nil,
            },
            -- Whether to disable showing non-error feedback
            silent = false,
        })

        -- A serious collection of awesome features
        -- function setup_auto_root() replaces https://github.com/airblade/vim-rooter
        -- function zoom() replaces https://github.com/szw/vim-maximizer which I used to use for vimspector
        require('mini.misc').setup({ make_global = { 'put' } })

        -- local directory_root = MiniMisc.find_root()
        -- V(string.format('directory_root: %s', directory_root))
        -- if
        --     directory_root ~= nil
        --     and (directory_root:match('Exercism') == nil or directory_root:match('FreeusAdapter') == nil)
        -- then
        MiniMisc.setup_auto_root()
        -- end

        -- MiniMisc.setup_auto_root({ '.exercism', 'Makefile', '.git', '.nvim.lua', '.gitignore', 'projector.json' })
        -- MiniMisc.setup_restore_cursor()

        -- Very magic plugin that shows indentscope with a nice animation. This will be wonderful for fsharp.
        require('mini.indentscope').setup()

        -- -- Easy tabline
        -- -- Awesome tabline, but I don't like how it makes each buffer a tab. Too disorienting.
        -- vim.api.nvim_set_hl(0, 'MiniTablineCurrent', { fg = '#7d14ff' })
        -- vim.api.nvim_set_hl(0, 'MiniTablineModifiedCurrent', { fg = '#5f00e1' })
        -- vim.api.nvim_set_hl(0, 'MiniTablineFill', { link = 'Normal' })
        -- vim.api.nvim_set_hl(0, 'MiniTablineVisible', { fg = '#0000ff' })
        -- vim.api.nvim_set_hl(0, 'MiniTablineHidden', { link = 'DevIconConf' })
        -- vim.api.nvim_set_hl(0, 'MiniTablineModifiedVisible', { fg = '#3300ff' })
        -- vim.api.nvim_set_hl(0, 'MiniTablineModifiedHidden', { fg = '#7777ff' })
        -- vim.api.nvim_set_hl(0, 'MiniTablineTabpagesection', { link = 'Normal' })
        -- require('mini.tabline').setup({ tabpage_section = 'right' })

        -- Auto underline the word under cursor after set amount of time. Quite nice for easy spell check in code.
        -- TODO: find a way to not do it on commentstring
        require('mini.cursorword').setup()

        -- Generate vim help docs by calling 'lua MiniDoc.generate()
        require('mini.doc').setup()

        -- Amazing plugin for nice movement animations
        -- Replaces plugin https://github.com/karb94/neoscroll.nvim
        require('mini.animate').setup({
            cursor = { enable = true },
            scroll = { enable = true },
            open = { enable = false },
            resize = { enable = false },
            close = { enable = false },
        })

        local miniAnimateAutocommands = vim.api.nvim_create_augroup('miniAnimateAutocommands', { clear = true })

        -- Disable mini.animate for toggleterm.
        -- It is too slow an annoying to scroll terminal output.
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'toggleterm' },
            callback = function()
                vim.b.minianimate_disable = true
            end,
            group = miniAnimateAutocommands,
        })

        -- Does most of what base16 colorscheme plugin can do, however colorcolumn and others look bad
        -- require('mini.base16').setup()

        -- A true powerhose of movement commands, I really like ]f to go to next file on disk
        -- TODO: plover work needed here, this is a good use for a python dictionary
        require('mini.bracketed').setup({
            -- First-level elements are tables describing behavior of a target:
            -- - <suffix> - single character suffix. Used after `[` / `]` in mappings.
            --   For example, with `b` creates `[B`, `[b`, `]b`, `]B` mappings.
            --   Supply empty string `''` to not create mappings.
            -- - <options> - table overriding target options.

            buffer = { suffix = 'b', options = {} },
            -- Disable the comment movements
            comment = { suffix = '', options = {} },
            conflict = { suffix = 'x', options = {} },
            diagnostic = { suffix = 'd', options = {} },
            file = { suffix = 'f', options = {} },
            indent = { suffix = 'i', options = {} },
            jump = { suffix = 'j', options = {} },
            location = { suffix = 'l', options = {} },
            oldfile = { suffix = 'o', options = {} },
            quickfix = { suffix = 'q', options = {} },
            treesitter = { suffix = 't', options = {} },
            undo = { suffix = 'u', options = {} },
            window = { suffix = 'w', options = {} },
            yank = { suffix = 'y', options = {} },
        })

        -- Awesome function which seems to work as well as Comment.nvim
        -- 2023-02-27 comment string settings are not as awesome for F#, and C
        -- require('mini.comment').setup()

        -- Awesome plugin for moving highlighted text easily
        require('mini.move').setup({
            -- Module mappings. Use `''` (empty string) to disable one.
            mappings = {
                -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
                -- left = '<M-h>',
                -- right = '<M-l>',
                -- down = '<M-j>',
                -- up = '<M-k>',

                -- Move current line in Normal mode
                line_left = '<',
                line_right = '>',
                -- line_down = '',
                -- line_up = '<M-k>',
            },
            -- Options which control moving behavior
            options = {
                -- Automatically reindent selection during linewise vertical move
                reindent_linewise = true,
            },
        })

        -- Sessions
        require('mini.sessions').setup()

        -- Start screen, works nice with sessions
        require('mini.starter').setup()

        -- Simple surround. Does everything I need it to.
        -- Replaces plugin https://github.com/kylechui/nvim-surround
        -- Use sr, sa, sd, to replace, add, and delete surrounds
        require('mini.surround').setup()

        -- TODO: get a function or mini surround to do this wrap for sql queries instead
        -- This just sets the register s with a mapping that will wrap like this
        -- '%s',
        vim.fn.setreg('s', [[I'A',^]])

        require('mini.trailspace').setup()
        vim.keymap.set('n', '<leader>mt', MiniTrailspace.trim, { silent = true, desc = 'MiniTrailspace.trim' })
        vim.keymap.set(
            'n',
            '<leader>mT',
            MiniTrailspace.trim_last_lines,
            { silent = true, desc = 'MiniTrailspace.trim_last_lines' }
        )

        -- Amazing additional text objects
        -- require('mini.ai').setup()

        -- Amazing commands with mappings starting with g
        -- additional operators for cool commands such as

        -- Evaluate text and replace with output.
        -- Exchange text regions.
        -- Multiply (duplicate) text.
        -- Replace text with register.
        -- Sort text.
        require('mini.operators').setup()
    end,
}
