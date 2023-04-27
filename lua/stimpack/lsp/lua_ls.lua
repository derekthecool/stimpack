return {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim', 'use', 'it', 'describe' },
            },
            completion = {
                callSnippet = 'Replace',
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    vim.api.nvim_get_runtime_file('', true),
                    -- Add awesome WM libraries
                    '/usr/share/awesome/lib/awful/',
                    '/usr/share/awesome/lib/beautiful/',
                    '/usr/share/awesome/lib/gears/',
                    '/usr/share/awesome/lib/menubar/',
                    '/usr/share/awesome/lib/naughty/',
                    '/usr/share/awesome/lib/wibox/',
                    OS.join_path( OS.stimpack, 'lsp', 'lua-workspace-meta-support' ),
                },
                [vim.fn.stdpath('config') .. '/lua'] = true,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
