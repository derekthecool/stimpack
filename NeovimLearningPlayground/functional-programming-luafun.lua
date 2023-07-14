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

-- A basic thing I want is to take a single number and create a list with mappings and sum them
local sum_test = fun.sum(fun.range(10))
print(sum_test)
print(type(sum_test))

local sum_test2 = fun.range(10):map(function(x) return x^2 end):sum()
print(sum_test2)
print(type(sum_test2))

local sum_test3 = (fun.range(10):sum() ^ 2)
print(sum_test3)
print(type(sum_test3))
