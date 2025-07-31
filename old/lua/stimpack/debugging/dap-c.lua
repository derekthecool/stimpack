-- See ./DebuggingGuide.md for more information

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
