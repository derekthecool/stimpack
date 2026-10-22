---Pass a terminal program's attention requests through to the terminal Neovim runs in.
---
---Claude Code's hook writes an OSC 777 notification followed by one or two bare BELs:
---WezTerm turns the OSC into a toast and counts the bells to colour the tab. Neovim
---swallows both by default -- `belloff` is `all`, and an OSC it does not implement stops
---at `TermRequest` -- so Claude running in a `:terminal` goes unnoticed.
local M = {}

-- `all` minus `term`, so only a bell from inside a terminal buffer gets through.
local SILENCED = 'backspace,cursor,complete,copy,ctrlg,error,esc,hangul,insertmode,lang,'
    .. 'mess,showmatch,operator,register,shell,spell,wildmode'

function M.setup()
    vim.o.belloff = SILENCED

    vim.api.nvim_create_autocmd('TermRequest', {
        group = vim.api.nvim_create_augroup('Terminal notifications', { clear = true }),
        callback = function(args)
            local sequence = args.data and args.data.sequence
            if type(sequence) == 'string' and vim.startswith(sequence, '\27]777;') then
                -- `v:stderr` is Neovim's channel to the terminal it draws on. Neovim reports
                -- the sequence without the terminator it matched, so close the OSC with a BEL.
                pcall(vim.api.nvim_chan_send, vim.v.stderr, sequence .. '\7')
            end
        end,
    })
end

return M
