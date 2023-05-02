local fun = require('luafun.fun')

local test = fun.range(100)
    :filter(function(x)
        return x % 7 == 0
    end)
    :map(function(x)
        return x ^ 2
    end)
    :each(print)

local one = fun.range(50, 100)
local two = fun.range(50)
local three = fun.range(50)

fun.zip(one, two, three):each(print)
