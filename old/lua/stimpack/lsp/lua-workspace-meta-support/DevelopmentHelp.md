# Lua LSP Development Help

This guide is to help with use the lua-language-server types

The [LuaLS wiki](https://github.com/LuaLS/lua-language-server/wiki/Libraries#link-to-workspace)
shows this method to link to a workspace. This means that you can create help
for your lua files from another file.

This is a great use case for using some lua tools such as:

- Wireshark
- NMAP

And can help to use their APIs more easily.

## Setup From Neovim

In the file [lua_ls.lua](../lua_ls.lua) I have specified to include this
directory for workspace setup.

```lua
OS.join_path( OS.stimpack, 'lsp', 'lua-workspace-meta-support' ),
```

Now anything in this directory will be loaded for projects.
So I can add my own help for [wireshark](./wireshark.lua) functions and get help.

## Help With Lua Annotations

This [link](https://github.com/LuaLS/lua-language-server/wiki/Annotations)
shows how to use basic annotations. These are very helpful because
lua is not a strongly typed language and this help to avoid issues.
