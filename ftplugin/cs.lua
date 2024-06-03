vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- Set the fold method to expression
vim.opt.foldmethod = 'expr'
-- Define the fold expression
vim.opt.foldexpr = 'v:lua.CSharpFoldExpr()'

-- Define the fold expression function
function CSharpFoldExpr()
    local lnum = vim.v.lnum
    local line = vim.fn.getline(lnum)

    if string.match(line, '^#region') then
        return '>1'
    elseif string.match(line, '^#endregion') then
        return '<1'
    else
        return '='
    end
end
