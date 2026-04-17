# Stimpack

This neovim configuration uses [lazyvim](https://www.lazyvim.org/)!
Before using lazyvim I had a great time with my neovim configuration. However, I
could never get my startup time below several seconds and my LSP integration
was not great.

Lazyvim handles both of those so much better with amazing LSP setup and
startup time values of:

- Windows -> 200ms
- Linux -> 20ms

## LazyVim Requirements

- Neovim >= 0.11.2
- Git >= 2.19.0
- A Nerd Font
- tree-sitter-cli and C compiler for treesitter
- curl
- Terminal emulator that supports true color and undercurl e.g. wezterm

Most of these I always already have installed anyway

```sh
# Arch Linux
sudo pacman -S tree-sitter-cli

# Ubuntu Linux
sudo apt install tree-sitter-cli

# Cargo
cargo install --locked tree-sitter-cli

# Scoop is does not have a package as of April 2026

# Winget
winget install --exact tree-sitter-cli

# Possibly using Mason using MasonInstall tree-sitter-cli
```
