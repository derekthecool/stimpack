return {
    'rafcamlet/nvim-luapad',
    keys = { { '<leader>dV', '<cmd>lua require(\'luapad\').toggle()<CR>', desc = 'Luapad neovim interactive buffer' } },
    config = {
        count_limit = 150000,
        error_indicator = true,
        eval_on_move = true,
        error_highlight = 'TSQueryLinterError',
        print_highlight = 'DevIconMotoko',
        split_orientation = 'vertical',
        on_init = function()
            print('Hello from Luapad!')
        end,
        context = {
            the_answer = 42,
            shout = function(str)
                return (string.upper(str) .. '!')
            end,
        },
    },
}
