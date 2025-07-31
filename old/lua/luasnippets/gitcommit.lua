---@diagnostic disable: undefined-global
local snippets = {}

local autosnippets = {
    s(
        'FIRST',
        fmt(
            [[
         {}{}: {}

         # This commit is following the conventional commits guidelines
         # https://www.conventionalcommits.org/en/v1.0.0/
         {}
         ]],
            {
                c(1, {
                    t('feat'),
                    t('fix'),
                    t('build'),
                    t('chore'),
                    t('ci'),
                    t('docs'),
                    t('style'),
                    t('refactor'),
                    t('perf'),
                    t('test'),
                }),

                c(2, {
                    t(''),
                    sn(
                        1,
                        fmt([[({})]], {
                            i(1, 'scope'),
                        })
                    ),
                }),
                i(3),
                i(4),
            }
        )
    ),
}

return snippets, autosnippets
