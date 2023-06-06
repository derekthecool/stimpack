local luasnip = require('luasnip')

-- Get available snippets for current filetype
local available_snippets = luasnip.available()
available_snippets.all = nil

print(available_snippets)

local snippet_count = 0
for _, value in pairs(available_snippets) do
    snippet_count = snippet_count + #value
     print(#value)
end

print(string.format('Total snippets available for current filetype: %d', snippet_count))

-- Get snip_env
local environment = luasnip.get_snip_env()
print(environment)

