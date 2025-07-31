-- h nvim_cmd  && h nvim_parse_cmd

print(vim.api.nvim_parse_cmd('20vsplit file.txt', {}))
print(vim.api.nvim_parse_cmd('split | terminal', {}))

for k, v in pairs(vim.api.nvim_parse_cmd('split | terminal', {})) do
    print(k, v)
end

print(
    vim.api.nvim_parse_cmd(
        'setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>',
        {}
    )
)
print(vim.api.nvim_parse_cmd('20 split text.txt', {}).range)
print(vim.api.nvim_parse_cmd('silent 0r !~/.derek-shell-config/scripts/generate-vimwiki-diary-template.py \'%\'', {}))
