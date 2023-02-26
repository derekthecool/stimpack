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
        require('mini.misc').setup()

        -- Very magic plugin that shows indentscope with a nice animation. This will be wonderful for fsharp.
        require('mini.indentscope').setup()

        -- Auto underline the word under cursor after set amount of time. Quite nice for easy spell check in code.
        require('mini.cursorword').setup()

        require('mini.doc').setup()
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
