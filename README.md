# Stim Pack

Derek's Neovim config setup. The name stim pack comes from the StarCraft
Terran upgrade that allows your troops to shoot faster. But of course unlike the
game, there is no self harm from using this repo. Also stim sounds like vim.

![stim pack image](https://imgs.search.brave.com/V_nzTEk0ywpLC6F8D1hqxCqz-HMsh-qvmW9AJ3PzqeU/rs:fit:592:225:1/g:ce/aHR0cHM6Ly90c2Uz/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5u/UWZkLWRMZ0JCY1BR/Z2xMOENBQnl3SGFG/NyZwaWQ9QXBp)

## TODO

- [ ] Get nvim.dap working for debugging:
  - [ ] csharp on Windows
  - [x] c on Linux
- [ ] Adjust all vim.cmd blobs to lua api calls

  Fix these warnings:

```
which_key: health#which_key#check

WhichKey: checking conflicting keymaps
- WARNING: conflicting keymap exists for mode **"n"**, lhs: **"←"**
- INFO: rhs: `:cprev<CR>`
- WARNING: conflicting keymap exists for mode **"n"**, lhs: **"[y"**
- INFO: rhs: `<Plug>(unimpaired-string-encode)`
- WARNING: conflicting keymap exists for mode **"n"**, lhs: **"[x"**
- INFO: rhs: `<Plug>(unimpaired-xml-encode)`
- WARNING: conflicting keymap exists for mode **"n"**, lhs: **"[u"**
- INFO: rhs: `<Plug>(unimpaired-url-encode)`
- WARNING: conflicting keymap exists for mode **"n"**, lhs: **"[C"**
- INFO: rhs: `<Plug>(unimpaired-string-encode)`
- WARNING: conflicting keymap exists for mode **"n"**, lhs: **"]y"**
- INFO: rhs: `<Plug>(unimpaired-string-decode)`
- WARNING: conflicting keymap exists for mode **"n"**, lhs: **"]x"**
- INFO: rhs: `<Plug>(unimpaired-xml-decode)`
- WARNING: conflicting keymap exists for mode **"n"**, lhs: **"]u"**
- INFO: rhs: `<Plug>(unimpaired-url-decode)`
- WARNING: conflicting keymap exists for mode **"n"**, lhs: **"]C"**
- INFO: rhs: `<Plug>(unimpaired-string-decode)`
- WARNING: conflicting keymap exists for mode **"n"**, lhs: **"zz"**
- INFO: rhs: `<Cmd>lua require('neoscroll').zz(250)<CR>`
- WARNING: conflicting keymap exists for mode **"n"**, lhs: **"ys"**
- INFO: rhs: `<Plug>Ysurround`
- WARNING: conflicting keymap exists for mode **"n"**, lhs: **"yS"**
- INFO: rhs: `<Plug>YSurround`
- WARNING: conflicting keymap exists for mode **"n"**, lhs: **"\_"**
- INFO: rhs: `<Cmd>lua require('projector').continue('all')<CR>`
- WARNING: conflicting keymap exists for mode **"n"**, lhs: **"\_\_"**
- INFO: rhs: `<Cmd>lua require('dap').toggle_breakpoint()<CR>`
- WARNING: conflicting keymap exists for mode **"n"**, lhs: **"\_\_\_"**
- INFO: rhs: `<Cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>`
- WARNING: conflicting keymap exists for mode **"n"**, lhs: **"gb"**
- INFO: rhs: `<Plug>(comment_toggle_blockwise)`
- WARNING: conflicting keymap exists for mode **"n"**, lhs: **"gc"**
- INFO: rhs: `<Plug>(comment_toggle_linewise)`
- WARNING: conflicting keymap exists for mode **"n"**, lhs: **"👇"**
- INFO: rhs: `<Cmd>lua require("luasnip.loaders.from_lua").edit_snippet_files()<CR>`
- WARNING: conflicting keymap exists for mode **"n"**, lhs: **"→"**
- INFO: rhs: `:cnext<CR>`

```

## Customizing

### Icons

Using a nerd font you can use characters as icons. This
[website](https://www.nerdfonts.com/cheat-sheet) is a great reference to look up
an icon. You can copy to neovim and see if is shows up properly, if it does not
show up right choose another one.
