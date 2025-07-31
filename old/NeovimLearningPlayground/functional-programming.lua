local fun = {}
local fun_mt = {}
fun_mt.Map = function(items, mapping)
    -- local outputTable = {}
    local outputTable = setmetatable({}, fun_mt)

    for k, v in pairs(items) do
        outputTable[k] = mapping(v)
    end

    return outputTable
end
fun_mt.Filter = function(items, filter)
    -- local outputTable = {}
    local outputTable = setmetatable({}, fun_mt)

    for _, v in pairs(items) do
        if filter(v) then
            table.insert(outputTable, v)
        end
    end

    return outputTable
end

fun_mt.__index = fun_mt

local test = setmetatable(fun, fun_mt)
print(test)
print(fun)
print(fun.Map)

local numbers = {
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
}

-- Define a function to square a number
local square = function(x)
    return x * x
end

-- Define a function to check if a number is even
local is_even = function(x)
    return x % 2 == 0
end

-- Example of chained commands
print(fun.Filter(numbers, is_even):Map(square))
for _, v in pairs(fun.Filter(numbers, is_even):Map(square)) do
    print(v)
end
