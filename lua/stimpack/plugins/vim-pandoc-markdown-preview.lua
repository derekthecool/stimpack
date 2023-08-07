return {
    'conornewton/vim-pandoc-markdown-preview',
    enabled = false,
    config = function()
        vim.g.md_pdf_viewer = 'zathura'
        vim.g.md_args =
            '--from markdown --template eisvogel --listings -V titlepage:true -V logo:/home/derek/Pictures/FreeusLogo.png'
    end,
}
