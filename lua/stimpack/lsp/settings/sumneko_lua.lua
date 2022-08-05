return {
    settings = {

        Lua = {
            diagnostics = {
                -- Added these helps to have a nicer, less noisy checking of nvim files
                globals = { 'vim', 'use', 'it', 'describe' },
            },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.stdpath('config') .. '/lua'] = true,
                },
            },
        },
    },
}
