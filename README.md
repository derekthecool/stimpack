# StimPack Speed Inducing Stenography Neovim Configuration

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![Commitizen friendly](https://img.shields.io/badge/commitizen-friendly-brightgreen.svg)](http://commitizen.github.io/cz-cli/)

Derek's Neovim config setup. The name stim pack comes from the StarCraft
Terran upgrade that allows your troops to shoot faster. But of course unlike the
game, there is no self harm from using this repo. Also stim sounds like vim.

![stim pack image](https://imgs.search.brave.com/V_nzTEk0ywpLC6F8D1hqxCqz-HMsh-qvmW9AJ3PzqeU/rs:fit:592:225:1/g:ce/aHR0cHM6Ly90c2Uz/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5u/UWZkLWRMZ0JCY1BR/Z2xMOENBQnl3SGFG/NyZwaWQ9QXBp)

> [!TIP]
> You must use stenography to use this configuration!

## System Requirements

- Yarn: needed for [Markdown Preview](https://github.com/iamcco/markdown-preview.nvim)
- C compiler: needed for treesitter.
  - Windows version can be installed with `scoop install make gcc`
  - Linux is easy, just install the main build packages for your distro e.g.
    `apt install build-essential`
- Dotnet 6.0 and 7.0:
  - F# tools
  - C# tools

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
unique single chords.

Compare that to a normal keyboard. You have about 60 usable keys and 4 modifiers.
We can get some help from chatGPT on these numbers with this prompt:

```
How many keyboard shortcut possiblities are there for a keyboard with 4 modifier keys
(control, shift, alt, windows) where 0-4 modifiers can be pressed at once with one other key.

The other keys to be included are:
a-z (26 keys total),
0-9 (10 keys total),
F1-F12 (12 keys total),
These non-letter keys should be included as well:
1. space
2. tab
3. left arrow
4. right arrow
5. up arrow
6. down arrow
7. ,
8. .
9. /
10. ;
11. '
12. [
13. ]
14. \
15. `
16. -
17. +
18. backspace
19. delete
20. insert
21. escape
22. enter

Total key count to include is 60

Calculate the total number of key combos using 0-4 modifiers and
only 1 key from this list.
```

Response from 2023-06-01, using ChatGPT May 24 (2023) version

> To calculate the total number of keyboard shortcut possibilities using 0-4 modifiers and only 1 key from the provided list of 60 keys, we need to consider the number of combinations for each case.
>
> For 0 modifiers pressed:
> There is only one possibility: pressing any of the 60 keys individually.
>
> For 1 modifier pressed:
> There are four modifier keys to choose from, and for each modifier key, there are 60 possibilities for the other key. So, the total number of combinations is 4 \* 60 = 240.
>
> For 2 modifiers pressed:
> There are four modifier keys to choose from, and for each combination of two modifiers, there are 60 possibilities for the other key. Since order does not matter for the modifiers, we can calculate the combinations using the formula for choosing 2 items from a set of 4 items: C(4, 2) = 6. So, the total number of combinations is 6 \* 60 = 360.
>
> For 3 modifiers pressed:
> Similarly, we have C(4, 3) = 4 combinations of three modifiers, and for each combination, there are 60 possibilities for the other key. So, the total number of combinations is 4 \* 60 = 240.
>
> For 4 modifiers pressed:
> There is only one possibility since all four modifiers are pressed simultaneously.
>
> Therefore, the total number of keyboard shortcut possibilities using 0-4 modifiers and only 1 key from the provided list is:
>
> Number of possibilities for 0 modifiers + Number of possibilities for 1 modifier + Number of possibilities for 2 modifiers + Number of possibilities for 3 modifiers + Number of possibilities for 4 modifiers
>
> = 60 + 240 + 360 + 240 + 1
> = 901
>
> So, there are a total of 901 keyboard shortcut possibilities with 0-4 modifiers and only 1 key from the given list.

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

## 2023-01-12 Migrating From Packer.nvim to Lazy.Nvim

Today my startup time was unbearably slow running on windows.
The total start up time was a wopping `7541.379` seconds. WTF!

Somehow, the same config running on Linux had a startup time of `1485.434`
seconds.

I believe switching to the awesome lua plugin manager,
[Lazy.nvim](https://github.com/folke/lazy.nvim) will help a lot.
test
