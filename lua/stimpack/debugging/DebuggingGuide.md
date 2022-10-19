# Debugging With Nvim Dap

## Ideal Projector Debug Setup Per Debugger

### dotnet csharp netcoredbg

TODO: need to find a way to use internal terminal instead of default external one.

Here are some related options:

```powershell
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
