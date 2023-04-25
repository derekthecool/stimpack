require('dap').adapters.coreclr = {
    type = 'executable',
    command = OS.join_path( Mason.packages, 'netcoredbg', 'netcoredbg', 'netcoredbg' .. OS.executable_extension ),
    args = { '--interpreter=vscode' },
}
