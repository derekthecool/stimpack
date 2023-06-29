# Debugging With Nvim Dap

## Ideal Projector Debug Setup Per Debugger

### C Debugging

#### Local (Executable)

This one was a bit tricky. But after working through some items in this GitHub
[nvim-dap #260](https://github.com/mfussenegger/nvim-dap/issues/260)

I came up with this configuration that worked fine on windows.

Debugger configuration:

```lua
local dap = require('dap')
dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = OS.join_path(Mason.bin, 'OpenDebugAD7' .. OS.executable_extension_alt),
    options = {
        detached = false,
    },
    MIMode = 'gdb',
    MIDebuggerPath = 'gdb.exe',
}
-- Set the C++ settings to work for C as well
dap.configurations.c = dap.configurations.cpp
```

Debugee configuration

```json
{
    "type": "cppdbg",
    "request": "launch",
    "program": "${workspaceFolder}/debugging/build/prototest.exe",
    "cwd": "${workspaceFolder}",
    "console": "integratedTerminal",
    "stopAtEntry": true,
    "showLog": false
}
```

#### Remote (Server)

TODO: Find a way to debug an application running in a docker container through localhost
network access.

### dotnet csharp netcoredbg

TODO: need to find a way to use internal terminal instead of default external one.

Here are some related options:

```json`
"console": "integratedTerminal",
"externalConsole": false,
"internalConsoleOptions": "openOnSessionStart",
```

```json
{
  "type": "coreclr",
  "request": "launch",
  "cwd": "${workspaceFolder}",
  "stopAtEntry": true,
  "program": "${workspaceFolder}/DapperTesting/bin/Debug/net6.0/DapperTesting.dll"
}
```
