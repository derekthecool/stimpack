-- https://github.com/echasnovski/mini.nvim
return {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
        -- Amazing text alignment
        -- Replaces plugin: https://github.com/godlygeek/tabular
        -- Though I still need tabular because vimwiki needs it for nice markdown table auto formatting
        require('mini.align').setup()

        -- A serious collection of awesome features
        -- function setup_auto_root() replaces https://github.com/airblade/vim-rooter
        -- function zoom() replaces https://github.com/szw/vim-maximizer which I used to use for vimspector
        require('mini.misc').setup({ make_global = { 'put' } })
        MiniMisc.setup_auto_root()
        MiniMisc.setup_restore_cursor()

        -- Very magic plugin that shows indentscope with a nice animation. This will be wonderful for fsharp.
        require('mini.indentscope').setup()

        -- Auto underline the word under cursor after set amount of time. Quite nice for easy spell check in code.
        -- TODO: find a way to not do it on commentstring
        require('mini.cursorword').setup()

        -- Generate vim help docs by calling 'lua MiniDoc.generate()
        require('mini.doc').setup()

        -- Amazing plugin for nice movement animations
        -- Replaces plugin https://github.com/karb94/neoscroll.nvim
        require('mini.animate').setup()

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
        require('mini.bracketed').setup()

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

        require('mini.trailspace').setup()
        vim.keymap.set('n', '<leader>mt', MiniTrailspace.trim, { silent = true, desc = 'MiniTrailspace.trim' })
        vim.keymap.set(
            'n',
            '<leader>mT',
            MiniTrailspace.trim_last_lines,
            { silent = true, desc = 'MiniTrailspace.trim_last_lines' }
        )

        require('mini.ai').setup()
    end,
}

--[[

# Mini align demo https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-align.md
# Press gaip to start formatting the block
# Press s to choose delimiter
# Press , to align on commas boom-boom-boom
cord, dog, cow, supercalifragilisticexpialidocious
log, trig, micron, blockyinging

cord, dog , cow   , supercalifragilisticexpialidocious
log , trig, micron, blockyinging

]]
