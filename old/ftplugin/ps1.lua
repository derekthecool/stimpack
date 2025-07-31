vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4

-- Set the fold method to expression
vim.opt_local.foldmethod = 'expr'
-- Define the fold expression
-- TODO: (Derek Lomax) 6/3/2024 11:03:02 AM, Could be used for powershell and fsharp as well
vim.opt_local.foldexpr = 'v:lua.CSharpFoldExpr()'

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
