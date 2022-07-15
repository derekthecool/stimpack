-- Testing out all the things that the vim.fncommand can do
-- :h vim.fn
-- Also this website is nice: https://vim.fandom.com/wiki/Get_the_name_of_the_current_file

-- :h expand()
print(vim.fn.expand('%:t'))
print(vim.fn.expand('%:p'))
print(vim.fn.expand('%:p:h'))
print(vim.fn.expand('%:p:h:t'))
print(vim.fn.expand('%:r'))
print(vim.fn.expand('%:e'))

-- :h col()
-- Column of cursor
print(vim.fn.col('.'))
-- Length of cursor line + 1
print(vim.fn.col('$'))
-- Column of the mark t
print(vim.fn.col("'t"))

-- :h getpos()
-- :h getcurpos()
-- Getting current location
print(vim.fn.getpos('.'))
print(vim.fn.getcurpos())

-- :h getline()
-- Get text of current line
print(vim.fn.getline('.'))
-- Get a range of lines
print(vim.fn.getline(1, 5))

-- :h registers
-- There are ten types of registers:		*registers* *{register}* *E354*
-- 1. The unnamed register ""
-- 2. 10 numbered registers "0 to "9
-- 3. The small delete register "-
-- 4. 26 named registers "a to "z or "A to "Z
-- 5. Three read-only registers ":, "., "%
-- 6. Alternate buffer register "#
-- 7. The expression register "=
-- 8. The selection registers "* and "+
-- 9. The black hole register "_
-- 10. Last search pattern register "/
print(vim.fn.getreg(''))

print(vim.fn.getreg('-'))

vim.fn.setreg('a', 'Hello I just set register "a"')
print(vim.fn.getreg('a'))
--[[
print(vim.fn.getreg('0'))
print(vim.fn.getreg('1'))
print(vim.fn.getreg('2'))
print(vim.fn.getreg('3'))
print(vim.fn.getreg('4'))
print(vim.fn.getreg('5'))
print(vim.fn.getreg('6'))
print(vim.fn.getreg('7'))
print(vim.fn.getreg('8'))
print(vim.fn.getreg('9'))

print(vim.fn.getreg('b'))
print(vim.fn.getreg('c'))
print(vim.fn.getreg('d'))
print(vim.fn.getreg('e'))
print(vim.fn.getreg('f'))
print(vim.fn.getreg('g'))
print(vim.fn.getreg('h'))
print(vim.fn.getreg('i'))
print(vim.fn.getreg('j'))
print(vim.fn.getreg('k'))
print(vim.fn.getreg('l'))
print(vim.fn.getreg('m'))
print(vim.fn.getreg('n'))
print(vim.fn.getreg('o'))
print(vim.fn.getreg('p'))
print(vim.fn.getreg('q'))
print(vim.fn.getreg('r'))
print(vim.fn.getreg('s'))
print(vim.fn.getreg('t'))
print(vim.fn.getreg('u'))
print(vim.fn.getreg('v'))
print(vim.fn.getreg('w'))
print(vim.fn.getreg('x'))
print(vim.fn.getreg('y'))
print(vim.fn.getreg('z'))
print(vim.fn.getreg('A'))
print(vim.fn.getreg('B'))
print(vim.fn.getreg('C'))
print(vim.fn.getreg('D'))
print(vim.fn.getreg('E'))
print(vim.fn.getreg('F'))
print(vim.fn.getreg('G'))
print(vim.fn.getreg('H'))
print(vim.fn.getreg('I'))
print(vim.fn.getreg('J'))
print(vim.fn.getreg('K'))
print(vim.fn.getreg('L'))
print(vim.fn.getreg('M'))
print(vim.fn.getreg('N'))
print(vim.fn.getreg('O'))
print(vim.fn.getreg('P'))
print(vim.fn.getreg('Q'))
print(vim.fn.getreg('R'))
print(vim.fn.getreg('S'))
print(vim.fn.getreg('T'))
print(vim.fn.getreg('U'))
print(vim.fn.getreg('V'))
print(vim.fn.getreg('W'))
print(vim.fn.getreg('X'))
print(vim.fn.getreg('Y'))
print(vim.fn.getreg('Z')) ]]

print(vim.fn.getreg(':'))
print(vim.fn.getreg('.'))
print(vim.fn.getreg('%'))

print(vim.fn.getreg('#'))
print(vim.fn.getreg('='))
print(vim.fn.getreg('*'))
print(vim.fn.getreg('+'))
print(vim.fn.getreg('_'))
print(vim.fn.getreg('/'))

-- :h has()
-- Returns 1 if he feature is found else 0
-- Version checking
print(vim.fn.has('nvim-0.2.1'))
print(vim.fn.has('nvim-0.8.0'))
print(vim.fn.has('patch148'))

-- Feature checking

--[[ print(vim.fn.has('acl'))
print(vim.fn.has('bsd'))
print(vim.fn.has('clipboar'))
print(vim.fn.has('fname_cas'))
print(vim.fn.has('nvim'))
print(vim.fn.has('python3'))
print(vim.fn.has('pythonx'))
print(vim.fn.has('sun'))
print(vim.fn.has('ttyin'))
print(vim.fn.has('ttyout'))
print(vim.fn.has('vim_startin'))
print(vim.fn.has('iconv')) ]]

-- OS checking
print(vim.fn.has('mac'))
print(vim.fn.has('unix'))
print(vim.fn.has('win32'))
print(vim.fn.has('win64'))
print(vim.fn.has('wsl'))
print(vim.fn.has('linux'))

-- :h line()
print(vim.fn.line('.'))
print(vim.fn.line('$'))
print(vim.fn.line('w0'))

-- :h stdpath()
print(vim.fn.stdpath('cache'))
print(vim.fn.stdpath('config'))
print(vim.fn.stdpath('config_dirs'))
print(vim.fn.stdpath('data'))
print(vim.fn.stdpath('data_dirs'))
print(vim.fn.stdpath('log'))
print(vim.fn.stdpath('state'))
