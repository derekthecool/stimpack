return {
    'NvChad/nvim-colorizer.lua',
    event = 'CursorMoved',
    config = function()
        require('colorizer').setup()
    end,
}
