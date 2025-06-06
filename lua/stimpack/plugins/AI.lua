return {

    {
        'David-Kunz/gen.nvim',
        config = function()
            local host = 'localhost'
            local port = 11434
            -- local model = 'llama2'
            -- local model = 'moondream'
            local model = 'llama3.2'
            require('gen').setup({
                model = model, -- The default model to use.
                host = host, -- The host running the Ollama service.
                port = port, -- The port on which the Ollama service is listening.
                quit_map = 'q', -- set keymap for close the response window
                retry_map = '<c-r>', -- set keymap to re-send the current prompt

                -- Running in docker/podman doesn't need an init
                init = function(options)
                    -- pcall(io.popen, 'ollama serve > /dev/null 2>&1 &')
                end,

                -- Function to initialize Ollama
                command = function(options)
                    local body = { model = model, stream = true }
                    return 'curl --silent http://' .. host .. ':' .. port .. '/api/chat -d $body'
                end,
                -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
                -- This can also be a command string.
                -- The executed command must return a JSON object with { response, context }
                -- (context property is optional).
                -- list_models = '<omitted lua function>', -- Retrieves a list of model names
                display_mode = 'float', -- The display mode. Can be "float" or "split".
                show_prompt = false, -- Shows the prompt submitted to Ollama.
                show_model = false, -- Displays which model you are using at the beginning of your chat session.
                no_auto_close = false, -- Never closes the window automatically.
                debug = false, -- Prints errors and the command which is run.
            })
        end,
    },
}
