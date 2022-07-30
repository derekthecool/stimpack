local generalSettingsGroup = vim.api.nvim_create_augroup("General settings", { clear = true })
-- TODO: get this to write the message in another color
-- " Triger `autoread` when files changes on disk
-- "autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
-- vim.api.nvim_create_autocmd("FileChangedShellPost *",
--   { callback = function() vim.notify('File changed on disk. Buffer reloaded.') end, group = generalSettingsGroup })
-- vim.api.nvim_create_autocmd("FileChangedShell *",
--   { callback = function() vim.notify('File changed on disk. Buffer reloaded.') end, group = generalSettingsGroup })

vim.api.nvim_create_autocmd("TextYankPost * ",
  {
    command = "silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 500})",
    group = generalSettingsGroup
  })
-- This autocommand does not seem to work right on nonhelp files, not able to do macros
-- vim.api.nvim_create_autocmd("FileType qf,help", {command = "nnoremap <silent> <buffer> q :close<cr>",group = generalSettingsGroup})
vim.api.nvim_create_autocmd("BufWinEnter *", { command = ":set formatoptions-=cro", group = generalSettingsGroup })
-- Format c/h files on save
-- https://www.reddit.com/r/neovim/comments/gm4ir3/does_the_new_builtin_lsp_client_support/
vim.api.nvim_create_autocmd("BufWritePre *.c *.h",
  { command = ":lua vim.lsp.buf.format { async = true }", group = generalSettingsGroup })
-- Map xaml and axaml to have xml syntax
vim.cmd [[
autocmd BufNewFile,BufRead *.xaml,*.axaml set filetype=xml
]]
-- TODO: find why this command it files to set ft
-- vim.api.nvim_create_autocmd("BufNewFile,BufRead *.xaml,*.axaml",
--   { command = ":set filetype=xml", group = generalSettingsGroup })

-- TODO: find why these four command set nearly all file types to xml
-- vim.api.nvim_create_autocmd("BufNewFile *.xaml", { command = ":setfiletype xml", group = generalSettingsGroup })
-- vim.api.nvim_create_autocmd("BufRead *.xaml", { command = ":setfiletype xml", group = generalSettingsGroup })
-- vim.api.nvim_create_autocmd("BufNewFile *.axaml", { command = ":setfiletype xml", group = generalSettingsGroup })
-- vim.api.nvim_create_autocmd("BufRead *.axaml", { command = ":setfiletype xml", group = generalSettingsGroup })
