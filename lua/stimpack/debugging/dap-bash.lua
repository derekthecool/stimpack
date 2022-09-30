require('dap').adapters.bash = {
    type = 'executable',
    command = OS.join_path({ Mason.bin, 'bash-debug-adapter' }),
    args = { '--interpreter=vscode' },
}
