local bit = require('plenary.bit')

local number = 0xAA
print(bit.bnot(number))
print(bit.tobit(number))
print(bit.ror(number, 1))
print(number)
