---@diagnostic disable: undefined-global, missing-parameter

local shareable = require('luasnippets.functions.shareable_snippets')

local snippets = {
    s(
        'hugo_front',
        fmt(
            [[
      ---
      title: "{Title}"
      date: {Date}
      image: {Image}
      categories:
        - {Categories}
      draft: {Draft}
      ---

      {OptionalHeader}
      ]],
            {

                Title = f(function()
                    return (vim.fn.expand('%:t'):gsub('-', ' '):gsub('.md', ''))
                end),
                Date = t(os.date('%Y-%m-%dT%H:%M:%S')),
                Image = i(1),
                Categories = i(2, 'C'),
                Draft = c(3, {
                    t('false'),
                    t('true'),
                }),

                OptionalHeader = i(4),
            }
        )
    ),

    -- }}}
}

local autosnippets = {}

return snippets, autosnippets
