# StimPack Speed Inducing Stenography Neovim Configuration

Derek's Neovim config setup. The name stim pack comes from the StarCraft
Terran upgrade that allows your troops to shoot faster. But of course unlike the
game, there is no self harm from using this repo. Also stim sounds like vim.

![stim pack image](https://imgs.search.brave.com/V_nzTEk0ywpLC6F8D1hqxCqz-HMsh-qvmW9AJ3PzqeU/rs:fit:592:225:1/g:ce/aHR0cHM6Ly90c2Uz/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5u/UWZkLWRMZ0JCY1BR/Z2xMOENBQnl3SGFG/NyZwaWQ9QXBp)

## Stenography Design

This config is not your every day neovim config. Stimpack is designed for use
with stenography. [Plover](https://github.com/openstenoproject/plover) is free
and open source software that the makes stenography available to any all!
Perhaps you have only ever known that stenography could be used by court
reporters. Stenography is a power user dream tool and has limitless
possibilities.

Here is what a steno keyboard looks like:

![steno keyboard](https://imgs.search.brave.com/pbfbYpsrsdMyx6-rpl_GypzoS1YLleIIn5quu7jM8jo/rs:fit:1560:225:1/g:ce/aHR0cHM6Ly90c2Uy/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5i/VHVyUDlEUUk3T3FS/OFFLQjU0d2ZRSGFD/USZwaWQ9QXBp)

One basic fact that allows for so much power usage is the sheer number of key
combinations. A steno keyboard has 23 keys and one or more can be pressed at
once to create any output. So that means there are `2^23 - 1` or `8388607`
unique single chords. Compare that with your archaic keyboard with around 100
keys. There are only 4 modifier keys (Win, shift, alt, ctrl) and ignoring multi
key options like `Ctrl-A-B-C` because there are very rare and deathly
unergonomic and counting key combos like `Ctrl-A` or with all 4 modifiers
`Ctrl+Shift+Win+Alt-R` that makes for

level 1: 1 of 4 = 4 : C,W,S,A
level 2: 2 of 4 = 6 : CW,CS,CA,WS,WA,SA
level 3: 3 of 4 = 4 : CWS,WSA,CSA,CWA
level 4: 4 of 4 = 1 : CWSA

## TODO

TODO items are found in the code. To find all TODO items and add them to the
quick fix list:

Using steno chord `TKPWR*EP` (grep) which sends the key `,fg`. This launches
nvim-telescope doing a live grep on the project, input `TODO` then chord
`KW-FLTZ` (Ctrl-Q) to add them to the quick fix list. Now navigate the quickfix
list by chording `SKWHEFPBL` which sends the key `←` to go to the previous item
and chord `SKWHUFPBL` which sends `→` to go to the next item.

Once again showing that this setup is stenography oriented to its core!

## Style

I'm using [StyLua](https://github.com/JohnnyMorganz/StyLua) for this project and
the file [stylua.toml](./.stylua.toml) includes the formatting options.

## Customizing

### Icons

Using a nerd font you can use characters as icons. This
[website](https://www.nerdfonts.com/cheat-sheet) is a great reference to look up
an icon. You can copy to neovim and see if is shows up properly, if it does not
show up right choose another one.

## Tracking My Open Source Involement

### Neovim Plugins

#### Fixes To Work On

- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) globals in status line disappear if colored
- mason.nvim omnisharp not working well
https://github.com/folke/lazy.nvim
```yaml
 Detected filetype:   cs

 1 client(s) attached to this buffer:

 Client: omnisharp (id: 1, pid: nil, bufnr: [1])
 	filetypes:       cs, vb
 	autostart:       true
 	root directory:  C:/Users/Derek Lomax/source/repos/Freeus.Tools/BXFota
 	cmd:             dotnet C:\Users\Derek Lomax\AppData\Local\nvim-data\lsp_servers\omnisharp\omnisharp\OmniSharp.dll --languageserver --hostPID 16700

 Configured servers list: jedi_language_server, powershell_es, sumneko_lua, lemminx, omnisharp
```

## 2023-01-12 Migrating From Packer.nvim to Lazy.Nvim

Today my startup time was unbearably slow running on windows.
The total start up time was a wopping `7541.379` seconds. WTF!

Somehow, the same config running on Linux had a startup time of `1485.434`
seconds.

I believe switching to the awesome lua plugin manager,
[Lazy.nvim](https://github.com/folke/lazy.nvim) will help a lot.
