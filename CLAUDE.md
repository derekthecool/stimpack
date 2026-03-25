# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

"Stimpack" — a LazyVim-based Neovim configuration. Plugin management is via `lazy.nvim` with LazyVim as the base framework. The config targets Windows (primary) and Linux.

## Formatting

Lua code is formatted with `stylua` (config in `stylua.toml`):

- 4-space indent, single quotes, 120 column width, Unix line endings

Run formatter: `stylua lua/`

## Architecture

### Entry point

`init.lua` bootstraps the config. It defines several globals used throughout all config files:

- `OS` table — platform-aware paths (`OS.home`, `OS.nvim`, `OS.snippets`, `OS.OS`, `OS.separator`)
- `P()` / `V()` — debug print helpers
- `Execute()`, `FileExists()` — shell utilities

Then delegates to `lua/config/lazy.lua` which sets up Lazy.nvim.

### lua/config/

Core Neovim settings, loaded by LazyVim conventions:

- `options.lua` — vim options. Leader is `,`, localleader is `-`. 4-space indent, no mouse, scrolloff=999, default shell is `pwsh`.
- `keymaps.lua` — custom mappings, heavily uses Unicode symbols (→ ← ↑ ↓ ⊃ ⊂ π µ § × ≥ ≤) because the user types on a steno keyboard. These are intentional, not errors.
- `autocmds.lua` — filetype overrides (.xaml→xml, .h→c, .fsproj→xml), disables autoformat for C/C++.

### lua/plugins/

Each file returns a table of lazy.nvim plugin specs. Files are scoped by concern.

### lua/luasnippets/

~60 language-specific snippet files. Each file returns `snippets, autosnippets`.

New snippets should:

- be defined in the `snippets` lua table and not `autosnippets`
- use the multisnippet `ms` instead of single snippet `s`

**Helper modules in `lua/luasnippets/functions/`:**

- `auxiliary.lua` — dynamic node helpers, `insert_include_if_needed()` for C# using directives, `wrap_selected_text()`
- `shareable_snippets.lua` — reusable snippet nodes shared across languages (c-style for/if/while, ternary, lambdas)
- `string_processor.lua` — string manipulation utilities for snippet logic

**Cross-language dotnet helper in `dotnet.lua`:**
`dotnet_static_call(index, class_name, method_name, args_node?)` — returns a dynamic node that formats static calls correctly per filetype:

- `cs`/`fs`: `ClassName.MethodName(args)`
- `ps1`: `[ClassName]::MethodName(args)`

### LazyVim extras (lazyvim.json)

Enabled: claudecode, DAP, dial, harpoon2, navic, clangd, cmake, docker, dotnet, json, markdown, python, sql, toml, yaml, test core.

## Snippet file conventions

All snippet files use `---@diagnostic disable: undefined-global` at the top because LuaSnip globals (`s`, `i`, `c`, `d`, `f`, `t`, `sn`, `fmt`, etc.) are injected via the loader, not required. This is expected.

Filetype extensions (one language's snippets available in another) are configured in `lua/plugins/luasnip.lua` under `filetype_extend`.
