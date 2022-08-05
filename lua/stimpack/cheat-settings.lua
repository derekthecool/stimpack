local which_key_mapper = require('stimpack.which-key-mapping')
which_key_mapper({
    K = {
        name = 'cht.sh helper', -- optional group name
        c = { '<cmd>Cheat<cr>', 'Main cheat interface' },
        i = { '<cmd>FloatermNew cht.sh --shell<cr>', 'Interactive cheat shell' },
    },
})
