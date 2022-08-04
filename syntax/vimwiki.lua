-- TODO: replace it these vim.cmd calls with lua ASAP
vim.cmd [[
syntax match todoCheckbox '\v.*\[\ \]'hs=e-2 conceal cchar=⬛
syntax match todoCheckbox '\v.*\[X\]'hs=e-2 conceal cchar=✅
syntax match todoCheckbox '\v.*\[x\]'hs=e-2 conceal cchar=✅
syntax match todoCheckbox '\v.*\[\.\]'hs=e-2 conceal cchar=🐌
syntax match todoCheckbox '\v.*\[o\]'hs=e-2 conceal cchar=🚙
syntax match todoCheckbox '\v.*\[O\]'hs=e-2 conceal cchar=🚁
]]
