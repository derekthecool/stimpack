return {
    {
        -- pounce is my favorite quick jumper since it works well with stenography
        -- oftentimes I can write the entire word I want to jump to quicker than 2-3 chars of that word
        -- e.g. to jump to the word 'great' with pounce I can just press my '\' keymap and then write
        -- the entire word 'great' with one single steno stroke and then press the suggestion letter to accept.
        -- To do the same thing with flash/hop and friends I would have to fingerspell several letters of the
        -- word which is much slower!
        'rlane/pounce.nvim',
        keys = { '\\' },
        config = function()
            vim.keymap.set({ 'n', 'o', 'x' }, '\\', function()
                require('pounce').pounce({})
            end)
            require('pounce').setup()
        end,
    },
    { 'nvim-mini/mini.pairs', enabled = false },
    { 'folke/flash.nvim', enabled = false },
    {
        'folke/snacks.nvim',
        opts = {
            picker = {
                layout = {
                    preset = 'ivy_split',
                },
            },
        },
    },
    {
        'monaqa/dial.nvim',
        opts = function()
            local augend = require('dial.augend')

            local logical_alias = augend.constant.new({
                elements = { '&&', '||' },
                word = false,
                cyclic = true,
            })

            local ordinal_numbers = augend.constant.new({
                -- elements through which we cycle. When we increment, we go down
                -- On decrement we go up
                elements = {
                    'first',
                    'second',
                    'third',
                    'fourth',
                    'fifth',
                    'sixth',
                    'seventh',
                    'eighth',
                    'ninth',
                    'tenth',
                },
                -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
                word = false,
                -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
                -- Otherwise nothing will happen when there are no further values
                cyclic = true,
            })

            local months = augend.constant.new({
                elements = {
                    'January',
                    'February',
                    'March',
                    'April',
                    'May',
                    'June',
                    'July',
                    'August',
                    'September',
                    'October',
                    'November',
                    'December',
                },
                word = true,
                cyclic = true,
            })

            return {
                dials_by_ft = {
                    css = 'css',
                    vue = 'vue',
                    javascript = 'typescript',
                    typescript = 'typescript',
                    typescriptreact = 'typescript',
                    javascriptreact = 'typescript',
                    json = 'json',
                    lua = 'lua',
                    markdown = 'markdown',
                    sass = 'css',
                    scss = 'css',
                    python = 'python',
                },
                groups = {
                    default = {
                        augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
                        augend.integer.alias.decimal_int, -- nonnegative and negative decimal number
                        augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
                        augend.date.alias['%Y/%m/%d'], -- date (2022/02/19, etc.)
                        augend.constant.alias.en_weekday, -- Mon, Tue, ..., Sat, Sun
                        augend.constant.alias.en_weekday_full, -- Monday, Tuesday, ..., Saturday, Sunday
                        ordinal_numbers,
                        months,
                        augend.constant.alias.bool, -- boolean value (true <-> false)
                        augend.constant.alias.Bool, -- boolean value (True <-> False)
                        logical_alias,
                        augend.semver.alias.semver, -- versioning (v1.1.2)
                    },
                    vue = {
                        augend.constant.new({ elements = { 'let', 'const' } }),
                        augend.hexcolor.new({ case = 'lower' }),
                        augend.hexcolor.new({ case = 'upper' }),
                    },
                    typescript = {
                        augend.constant.new({ elements = { 'let', 'const' } }),
                    },
                    css = {
                        augend.hexcolor.new({
                            case = 'lower',
                        }),
                        augend.hexcolor.new({
                            case = 'upper',
                        }),
                    },
                    markdown = {
                        augend.constant.new({
                            elements = { '[ ]', '[x]' },
                            word = false,
                            cyclic = true,
                        }),
                        augend.misc.alias.markdown_header,
                    },
                    lua = {
                        augend.constant.new({
                            elements = { 'and', 'or' },
                            word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
                            cyclic = true, -- "or" is incremented into "and".
                        }),
                    },
                    python = {
                        augend.constant.new({
                            elements = { 'and', 'or' },
                        }),
                    },
                },
            }
        end,
    },
}
