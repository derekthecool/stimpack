# Luasnip Guide

## Luasnip Todo

- Set key maps for all choice nodes
- Set highlighting and virtual text in config
- Research all of the TM\_\* values
  - SELECTION
  - TM_SELECTED_TEXT
  - TM_CURRENT_LINE
  - TM_CURRENT_WORD
  - TM_LINE_INDEX
  - TM_LINE_NUMBER
  - TM_FILENAME
  - TM_DIRECTORY
  - TM_FILEPATH
- Look at telescope pickers

More advanced snippets to create

- Tree sitter to find all local variables and put them into the choice nodes
- Make amazing printf where each of the `%` are matched to an arg of the right type

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
