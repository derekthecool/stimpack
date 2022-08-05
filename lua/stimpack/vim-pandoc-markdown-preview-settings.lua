-- Settings for plugin vim-pandoc-markdown-preview-settings
-- vim.cmd "let g:md_pdf_viewer='zathura'"
vim.g.md_pdf_viewer = 'zathura'

-- vim.cmd "let g:md_args = '--from markdown --template eisvogel --listings -V titlepage:true -V logo:/home/derek/Pictures/FreeusLogo.png'"
vim.g.md_args =
    '--from markdown --template eisvogel --listings -V titlepage:true -V logo:/home/derek/Pictures/FreeusLogo.png'
