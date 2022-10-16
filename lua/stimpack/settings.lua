-- Global options
vim.g.mapleader = ',' -- Map leader to comma instead of space since switching to stenography. Spacing is done after each word so comma is better for me now.
vim.g.nobackup = true
vim.g.nowritebackup = true
vim.g.showmatch = true -- Show matching () [] {}

vim.go.lazyredraw = true -- Don't redraw screen during macros

-- Regular options
vim.o.conceallevel = 2
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
vim.o.sidescrolloff = 999 -- Keep cursor horizontally centered
vim.o.smartcase = true -- Uses exact case if any uppercase is used in the search
vim.o.smartindent = true -- Easier indenting
vim.o.splitbelow = true -- Horizontal splits will be below current buffer
vim.o.splitright = true -- Vertical splits will be to the right of the current buffer
vim.o.syntax = 'enable' -- Enable syntax highlighting
vim.o.tabstop = 2 -- Insert 2 spaces for a tab
vim.o.timeoutlen = 500 -- Faster than default 1000 ms
vim.o.updatetime = 300 -- Faster completion
vim.o.termguicolors = true -- Needed for better color display
vim.o.swapfile = false -- Do not create swp files
vim.bo.swapfile = false -- Do not create swp files

-- Window options
vim.wo.number = true -- Show line numbers
vim.wo.relativenumber = true -- Show relative line numbers
vim.wo.wrap = false -- Display long lines as a single line
vim.wo.signcolumn = 'auto:1-4' -- Allow for up to 4 items in the sign column
vim.wo.foldmethod = 'marker'

-- Buffer options
vim.opt.textwidth = 80
vim.opt.iskeyword:append('-')

-- Set items specific to OS
-- Use this command to check OS lua print(vim.loop.os_uname().sysname)
if OS.OS == 'Windows' then
  -- https://github.com/akinsho/toggleterm.nvim/wiki/Tips-and-Tricks
  local windows_shell_options = {
    {
      shell = vim.fn.executable('pwsh') and 'pwsh' or 'powershell',
      shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;',
      shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait',
      shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode',
      shellquote = '',
      shellxquote = '',
    },
    {
      shell = vim.opt.shell,
      shellcmdflag = vim.opt.shellcmdflag,
      shellredir = vim.opt.shellredir,
      shellpipe = vim.opt.shellpipe,
      shellquote = vim.opt.shellquote,
      shellxquote = vim.opt.shellquote,
    }
  }

  -- Start with first index of windows_shell_options
  local shell_settings_start = false

  function WindowsSwapShell()
    local shell_index
    if shell_settings_start then
      shell_index = 1
    else
      shell_index = 2
    end

    for option, value in pairs(windows_shell_options[shell_index]) do
      vim.opt[option] = value
    end

    shell_settings_start = not shell_settings_start
  end
end
