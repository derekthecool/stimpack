# Luasnip Guide

## Helpful Links

- [Luasnip GitHub](https://github.com/L3MON4D3/LuaSnip)
- [Detailed lua snip doc](https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#lua)
- [How to avoid setting all the local variables for every snippet file](https://github.com/L3MON4D3/LuaSnip/blob/69cb81cf7490666890545fef905d31a414edc15b/lua/luasnip/config.lua#L82-L104)
- [Basic guide to luasnip](https://sbulav.github.io/vim/neovim-setting-up-luasnip/)
- [Awesome guide with YouTube video on luasnip by zionteel113](https://github.com/ziontee113/luasnip-tutorial)

## Guide to creating snippets

Use the locals at the top of this file for shorter writing
for example you can define a snippet with "s" because of this line at the top
local s = ls.snippet

Escape characters:
$ --> $$
Quotes are tough, but the following should work:
" --> \"
"word"..'"'.."text wrapped in quotes"..'"'
-- For use in fmt
{ --> {{
} --> }}

Examples: Use captures from the regex-trigger using a functionNode:

>

    s({trig = "b(%d)", regTrig = true},
        f(function(args, snip) return
            "Captured Text: " .. snip.captures[1] .. "." end, {})
    )

]]
