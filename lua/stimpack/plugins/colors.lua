-- This spec contains everything related to colors
return {
    {
        'RRethy/nvim-base16',
        priority = 1000, --set high priority for colorscheme
        dependencies = {
            'xiyaowong/nvim-transparent',
        },
        event = 'BufEnter',
        config = function()
            vim.api.nvim_cmd({ cmd = 'colorscheme', args = { 'base16-atelier-sulphurpool' } }, {})
            vim.api.nvim_cmd({ cmd = 'TransparentEnable' }, {})
        end,
    },

    {
        'ziontee113/color-picker.nvim',
        cmd = { 'PickColor', 'PickColorInsert' },
        opts = {},
    },

    {
        'NvChad/nvim-colorizer.lua',
        event = 'CursorMoved',
        config = function()
            require('colorizer').setup({

                filetypes = { '*' },
                user_default_options = {
                    RGB = true, -- #RGB hex codes
                    RRGGBB = true, -- #RRGGBB hex codes
                    names = true, -- "Name" codes like Blue or blue
                    RRGGBBAA = false, -- #RRGGBBAA hex codes
                    AARRGGBB = true, -- 0xAARRGGBB hex codes
                    rgb_fn = false, -- CSS rgb() and rgba() functions
                    hsl_fn = false, -- CSS hsl() and hsla() functions
                    css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                    css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                    -- Available modes for `mode`: foreground, background,  virtualtext
                    mode = 'background', -- Set the display mode.
                    -- Available methods are false / true / "normal" / "lsp" / "both"
                    -- True is same as normal
                    tailwind = false, -- Enable tailwind colors
                    -- parsers can contain values used in |user_default_options|
                    sass = { enable = false, parsers = { css } }, -- Enable sass colors
                    virtualtext = '■',
                    -- update color values even if buffer is not focused
                    always_update = false,
                },
                -- all the sub-options of filetypes apply to buftypes
                buftypes = {},
            })

            -- Activate now because plugin is lazy loaded (not needed when enabled at start up)
            vim.cmd([[ColorizerToggle]])
        end,
    },

    -- Transparent visual plugin.
    {
        'xiyaowong/nvim-transparent',
        opts = {
            groups = { -- table: default groups
                'Normal',
                'NormalNC',
                'Comment',
                'Constant',
                'Special',
                'Identifier',
                'Statement',
                'PreProc',
                'Type',
                'Underlined',
                'Todo',
                'String',
                'Function',
                'Conditional',
                'Repeat',
                'Operator',
                'Structure',
                'LineNr',
                'NonText',
                'SignColumn',
                'CursorLineNr',
                'EndOfBuffer',
            },
            extra_groups = { -- table/string: additional groups that should be cleared
                -- In particular, when you set it to 'all', that means all available groups

                -- example of akinsho/nvim-bufferline.lua
                'BufferLineTabClose',
                -- 'BufferlineBufferSelected',
                'BufferLineFill',
                'BufferLineBackground',
                'BufferLineSeparator',
                -- 'BufferLineIndicatorSelected',

                -- Floating windows
                'NormalFloat',

                -- TODO: needs work, but it is better than default
                'TelescopeBorder',
                'TelescopeMatching',
                'TelescopeMultiIcon',
                -- 'TelescopeMultiSelection',
                'TelescopeNormal',
                'TelescopePreviewBlock',
                'TelescopePreviewBorder',
                'TelescopePreviewCharDev',
                'TelescopePreviewDate',
                'TelescopePreviewDirectory',
                'TelescopePreviewExecute',
                'TelescopePreviewGroup',
                'TelescopePreviewHyphen',
                'TelescopePreviewLine',
                'TelescopePreviewLink',
                'TelescopePreviewMatch',
                'TelescopePreviewMessage',
                'TelescopePreviewMessageFillchar',
                'TelescopePreviewNormal',
                'TelescopePreviewPipe',
                'TelescopePreviewRead',
                'TelescopePreviewSize',
                'TelescopePreviewSocket',
                'TelescopePreviewSticky',
                -- 'TelescopePreviewTitle',
                'TelescopePreviewUser',
                'TelescopePreviewWrite',
                'TelescopePromptBorder',
                'TelescopePromptCounter',
                'TelescopePromptNormal',
                'TelescopePromptPrefix',
                -- 'TelescopePromptTitle',
                -- 'TelescopeResultsBorder',
                -- 'TelescopeResultsClass',
                -- 'TelescopeResultsComment',
                -- 'TelescopeResultsConstant',
                -- 'TelescopeResultsDiffAdd',
                -- 'TelescopeResultsDiffChange',
                -- 'TelescopeResultsDiffDelete',
                -- 'TelescopeResultsDiffUntracked',
                -- 'TelescopeResultsField',
                -- 'TelescopeResultsFunction',
                -- 'TelescopeResultsIdentifier',
                -- 'TelescopeResultsLineNr',
                -- 'TelescopeResultsMethod',
                -- 'TelescopeResultsNormal',
                -- 'TelescopeResultsNumber',
                -- 'TelescopeResultsOperator',
                -- 'TelescopeResultsSpecialComment',
                -- 'TelescopeResultsStruct',
                -- 'TelescopeResultsTitle',
                -- 'TelescopeResultsVariable',
                -- 'TelescopeSelection',
                -- 'TelescopeSelectionCaret',
                -- 'TelescopeTitle',

                -- 'lualine_a_normal',
                -- 'lualine_a_insert',
                'lualine_b_normal',
                'lualine_b_insert',
                'lualine_c_normal',
                'lualine_c_insert',

                -- RenderMarkdown plugin highlights https://github.com/MeanderingProgrammer/render-markdown.nvim#colors
                -- The colors do not seem to cooperate well with this plugin because they use some builtin colors like colorcolumn and clearing that messes up other stuff
                -- TODO: (Derek Lomax) 1/20/2025 9:36:58 AM, but I could consider markdown buffer specific fixes for this later
            },
            exclude_groups = {
                -- 'TelescopeBorder',
            }, -- table: groups you don't want to clear
        },
    },
}
