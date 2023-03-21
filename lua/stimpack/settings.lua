-- Global options
vim.g.mapleader = ',' -- Map leader to comma instead of space since switching to stenography. Spacing is done after each word so comma is better for me now.
vim.g.nobackup = true
vim.g.nowritebackup = true
vim.g.showmatch = true -- Show matching () [] {}

vim.go.lazyredraw = true -- Don't redraw screen during macros

-- Regular options
vim.opt.mouse = '' -- No mouse!!
vim.o.conceallevel = 2
vim.o.clipboard = 'unnamedplus' -- Copy paste between vim and everything else (for WSL clipboard usage see https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl)
vim.o.completeopt = 'menu,noselect,longest,menuone' -- Pop up menu settings
vim.o.cursorline = true -- Highlight the line the cursor is currently on
vim.o.hidden = true -- Required to keep multiple buffers open at once
vim.o.ignorecase = true -- Ignore case when searching
vim.o.inccommand = 'split' -- Watch live updates with search and replace
vim.o.magic = true -- Improved regex options, less backslashes
vim.o.pumheight = 12 -- Height of the popup menu
vim.o.scrolloff = 999 -- Keep cursor vertically centered
vim.o.sidescrolloff = 999 -- Keep cursor horizontally centered
vim.o.smartcase = true -- Uses exact case if any uppercase is used in the search
vim.o.splitbelow = true -- Horizontal splits will be below current buffer
vim.o.splitright = true -- Vertical splits will be to the right of the current buffer
vim.o.syntax = 'enable' -- Enable syntax highlighting
vim.o.timeoutlen = 500 -- Faster than default 1000 ms
vim.o.updatetime = 300 -- Faster completion
vim.o.swapfile = false -- Do not create swp files
vim.bo.swapfile = false -- Do not create swp files

-- Default text formatting options: see overrides to these in ftplugin/*.lua
vim.o.shiftwidth = 4 -- Number of space characters for indentation
vim.o.tabstop = 4 -- Insert 2 spaces for a tab
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.smartindent = true -- Easier indenting
vim.opt.textwidth = 80

-- Window options
-- vim.wo.number = true -- Show line numbers
-- vim.wo.relativenumber = true -- Show relative line numbers
vim.wo.wrap = false -- Display long lines as a single line
vim.wo.signcolumn = 'auto:1-2' -- Allow for up to 4 items in the sign column
-- vim.wo.foldmethod = 'marker'

-- Buffer options
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
            shell = 'cmd',
            shellcmdflag = '/s /c',
            shellredir = '>%s 2>&1',
            shellpipe = '>%s 2>&1',
            shellquote = '',
            shellxquote = '"',
        },
    }

    -- Start with first index of windows_shell_options
    local shell_settings_start = true

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

        -- Only notify when I change to CMD, I don't want to see this on start up
        if windows_shell_options[shell_index].shell == 'cmd' then
            vim.notify(
                windows_shell_options[shell_index].shell,
                vim.log.levels.INFO,
                { title = 'Stimpack Notification' }
            )
        end

        shell_settings_start = not shell_settings_start
    end

    -- Call once to set initial values
    WindowsSwapShell()
end
