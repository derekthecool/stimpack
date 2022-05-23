-- vim.o  = setting general options
-- vim.g  = setting global options
-- vim.bo = setting buffer-scoped options
-- vim.wo = setting window-scoped options

-- Global options
vim.g.mapleader = ',' -- Map leader to comma instead of space since switching to stenography. Spacing is done after each word so comma is better for me now.
vim.g.noswapfile = true -- Do not create swp files
vim.g.nobackup = true -- Recommended by CoC
vim.g.nowritebackup = true -- Recommended by CoC
vim.g.showmatch = true -- Show matching () [] {}
-- vim.g.lazyredraw = true                 -- Don't redraw screen during macros
-- vim.g.laststatus=3
vim.cmd([[
set lazyredraw
set laststatus=3
highlight WinSeparator guibg=none
]])

-- Regular options
vim.o.clipboard = 'unnamedplus' -- Copy paste between vim and everything else (for WSL clipboard usage see https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl)
vim.o.cmdheight = 2 -- Larger command line height, helps to avoid seeing press any key to continue
vim.o.completeopt = 'menu,noselect,longest,menuone' -- Pop up menu settings
vim.o.cursorline = true -- Highlight the line the cursor is currently on
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.hidden = true -- Required to keep multiple buffers open at once
vim.o.ignorecase = true -- Ignore case when searching
vim.o.inccommand = 'split' -- Watch live updates with search and replace
vim.o.magic = true -- Improved regex options, less backslashes
vim.o.pumheight = 12 -- Height of the popup menu
vim.o.scrolloff = 999 -- Keep cursor vertically centered
vim.o.shiftwidth = 2 -- Number of space characters for indentation
vim.o.showtabline = 2 -- Always show tabs
vim.o.sidescrolloff = 999 -- Keep cursor horizontally centered
vim.o.smartcase = true -- Uses exact case if any uppercase is used in the search
vim.o.smartindent = true -- Easier indenting
vim.o.splitbelow = true -- Horizontal splits will be below current buffer
vim.o.splitright = true -- Vertical splits will be to the right of the current buffer
vim.o.syntax = 'enable' -- Enable syntax highlighting
vim.o.tabstop = 2 -- Insert 2 spaces for a tab
vim.o.timeoutlen = 500 -- Faster than default 1000 ms
vim.o.updatetime = 300 -- Faster completion
vim.o.termguicolors = true                       -- Needed for better color display

-- Window options
vim.wo.number = true -- Show line numbers
vim.wo.colorcolumn = "80" -- Display color column at 80 characters
vim.wo.relativenumber = true -- Show relative line numbers
vim.wo.wrap = false -- Display long lines as a single line
vim.wo.signcolumn = 'auto:1-4' -- Allow for up to 4 items in the sign column

-- Buffer options
-- vim.bo.textwidth = 80                                 -- Set max length for lines
vim.cmd "set textwidth=80" -- The dang lua version above does not always work

local generalSettingsGroup = vim.api.nvim_create_augroup("General settings", { clear = true })
-- TODO: get this to write the message in another color
-- " Triger `autoread` when files changes on disk
-- "autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
vim.api.nvim_create_autocmd("FileChangedShellPost *", { command = "echo 'File changed on disk. Buffer reloaded.'", group = generalSettingsGroup })
vim.api.nvim_create_autocmd("TextYankPost * ", { command = "silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 500})", group = generalSettingsGroup })
-- This autocommand does not seem to work right on nonhelp files, not able to do macros
-- vim.api.nvim_create_autocmd("FileType qf,help", {command = "nnoremap <silent> <buffer> q :close<cr>",group = generalSettingsGroup})
vim.api.nvim_create_autocmd("BufWinEnter *", { command = ":set formatoptions-=cro", group = generalSettingsGroup })
-- Format c/h files on save
-- https://www.reddit.com/r/neovim/comments/gm4ir3/does_the_new_builtin_lsp_client_support/
vim.api.nvim_create_autocmd("BufWritePre *.c *.h", { command = ":lua vim.lsp.buf.format { async = true }", group = generalSettingsGroup })

-- Only possible to set with vim commands
vim.cmd "set iskeyword+=-"
