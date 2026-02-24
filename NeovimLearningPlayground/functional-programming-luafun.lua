-- Check documentation here: https://luafun.github.io/
-- I will write the documented functions as found on the website here
local fun = require('luafun.fun')

-- Basic functions
-- https://luafun.github.io/basic.html
for _it, a in fun.iter({ 1, 2, 3 }) do
    print(a)
end
for _it, k, v in fun.iter({ a = 1, b = 2, c = 3 }) do
    print(k, v)
end
for _it, a in fun.iter('abcde') do
    print(a)
end

-- Generator functions
-- https://luafun.github.io/generators.html
for _it, v in fun.range(5) do
    print(v)
end
for _it, v in fun.range(-5) do
    print(v)
end
for _it, v in fun.range(1, 6) do
    print(v)
end
for _it, v in fun.range(0, 20, 5) do
    print(v)
end
for _it, v in fun.range(0, 10, 3) do
    print(v)
end
for _it, v in fun.range(0, 1.5, 0.2) do
    print(v)
end
for _it, v in fun.range(0) do
    print(v)
end
for _it, v in fun.range(1) do
    print(v)
end

fun.each(print, fun.take(3, fun.duplicate('a', 'b', 'c')))
fun.each(print, fun.take(3, fun.duplicate('x')))
for _it, a, b, c, d, e in fun.take(3, fun.duplicate(1, 2, 'a', 3, 'b')) do
    print(a, b, c, d, e)
end
fun.each(
    print,
    fun.take(
        5,
        fun.tabulate(function(x)
            return 'a', 'b', 2 * x
        end)
    )
)
fun.each(
    print,
    fun.take(
        100,
        fun.tabulate(function(x)
            return x ^ 2
        end)
    )
)

fun.each(print, fun.take(5, fun.zeros()))
fun.each(print, fun.take(5, fun.ones()))
fun.each(print, fun.take(10, fun.rands(10, 20)))
fun.each(print, fun.take(5, fun.rands(10)))
fun.each(print, fun.take(5, fun.rands()))

-- Slicing functions
-- https://luafun.github.io/slicing.html
print(fun.nth(2, fun.range(5)))
print(fun.nth(10, fun.range(5)))
print(fun.nth(2, { 'a', 'b', 'c', 'd', 'e' }))
print(fun.nth(2, fun.enumerate({ 'a', 'b', 'c', 'd', 'e' })))

print(fun.head({ 'a', 'b', 'c', 'd', 'e' }))
-- print(fun.head({}))
-- error: head: iterator is empty
-- print(head(range(0)))
-- error: head: iterator is empty
print(fun.head(fun.enumerate({ 'a', 'b' })))
fun.each(print, fun.tail({ 'a', 'b', 'c', 'd', 'e' }))
fun.each(print, fun.tail({}))
fun.each(print, fun.tail(fun.range(0)))
fun.each(print, fun.tail(fun.enumerate({ 'a', 'b', 'c' })))

fun.each(print, fun.take_n(5, fun.range(10)))
fun.each(print, fun.take_n(5, fun.enumerate(fun.duplicate('x'))))
fun.each(
    print,
    fun.take_while(function(x)
        return x < 5
    end, fun.range(10))
)
fun.each(
    print,
    fun.take_while(function(i, a)
        return i ~= a
    end, fun.enumerate({ 5, 3, 4, 4, 2 }))
)
fun.each(print, fun.drop_n(2, fun.range(5)))
fun.each(print, fun.drop_n(2, fun.enumerate({ 'a', 'b', 'c', 'd', 'e' })))
fun.each(
    print,
    fun.drop_while(function(x)
        return x < 5
    end, fun.range(10))
)
fun.each(
    print,
    fun.zip(fun.span(function(x)
        return x < 5
    end, fun.range(10)))
)
fun.each(print, fun.zip(fun.span(5, fun.range(10))))

-- Indexing
-- https://luafun.github.io/indexing.html
-- index aliases: index_of, elem_index
print(fun.index(2, fun.range(0)))
print(fun.index('b', { 'a', 'b', 'c', 'd', 'e' }))
-- indexes aliases: indices, elem_indexes, elem_indices

fun.each(print, fun.indexes('a', { 'a', 'b', 'c', 'd', 'e', 'a', 'b', 'a', 'a' }))

-- Filtering functions
-- https://luafun.github.io/filtering.html
fun.each(
    print,
    fun.filter(function(x)
        return x % 3 == 0
    end, fun.range(10))
)
fun.each(
    print,
    fun.take(
        5,
        fun.filter(function(i, x)
            return i % 3 == 0
        end, fun.enumerate(fun.duplicate('x')))
    )
)

lines_to_grep = {
    [[Emily]],
    [[Chloe]],
    [[Megan]],
    [[Jessica]],
    [[Emma]],
    [[Sarah]],
    [[Elizabeth]],
    [[Sophie]],
    [[Olivia]],
    [[Lauren]],
}

fun.each(print, fun.grep('^Em', lines_to_grep))

fun.each(print, fun.grep('^P', lines_to_grep))

fun.each(
    print,
    fun.grep(function(x)
        return x % 3 == 0
    end, fun.range(10))
)

fun.each(
    print,
    fun.zip(fun.partition(function(i, x)
        return i % 3 == 0
    end, fun.range(10)))
)

-- Reducing functions
-- https://luafun.github.io/reducing.html

-- Folds
print(fun.foldl(function(acc, x)
    return acc + x
end, 0, fun.range(5)))
print(fun.foldl(fun.operator.add, 0, fun.range(5)))
print(fun.foldl(function(acc, x, y)
    return acc + x * y
end, 0, fun.zip(fun.range(1, 5), { 4, 3, 2, 1 })))

-- More preferred name of reduce
print(fun.reduce(function(acc, x)
    return acc + x
end, 0, fun.range(5)))
print(fun.reduce(fun.operator.add, 0, fun.range(5)))
print(fun.reduce(function(acc, x, y)
    return acc + x * y
end, 0, fun.zip(fun.range(1, 5), { 4, 3, 2, 1 })))

-- Length
print(fun.length({ 'a', 'b', 'c', 'd', 'e' }))
print(fun.length({}))
print(fun.length(fun.range(0)))
print(fun.length(fun.range(100)))

-- totable
local tab = fun.totable('abcdef')
print(type(tab), #tab)
fun.each(print, tab)

-- tomap
local tab = fun.tomap(fun.zip(fun.range(1, 8), 'abcdefgh'))
print(type(tab), #tab)
fun.each(print, fun.iter(tab))
print(tab)

-- Predicates
print(fun.is_prefix_of({ 'a' }, { 'a', 'b', 'c' }))
print(fun.is_prefix_of(fun.range(6), fun.range(5)))

print(fun.is_null({ 'a', 'b', 'c', 'd', 'e' }))
print(fun.is_null({}))
print(fun.is_null(fun.range(0)))

print(fun.all(function(x)
    return x
end, { true, true, true, true }))
print(fun.all(function(x)
    return x
end, { true, true, true, false }))

-- Also alias: fun.some
print(fun.any(function(x)
    return x
end, { false, false, false, false }))
print(fun.any(function(x)
    return x
end, { false, false, false, true }))

-- Special folds
print(fun.sum(fun.range(5)))
print(fun.range(5):sum())

print(fun.product(fun.range(5)))
print(fun.range(5):product())

print(fun.min(fun.range(1, 10, 1)))
print(fun.min({ 'f', 'd', 'c', 'd', 'e' }))

function min_cmp(a, b)
    if -a < -b then
        return a
    else
        return b
    end
end

print(fun.min_by(min_cmp, fun.range(1, 10, 1)))

print(fun.max(fun.range(1, 10, 1)))
print(fun.max({ 'f', 'd', 'c', 'd', 'e' }))
function max_cmp(a, b)
    if -a > -b then
        return a
    else
        return b
    end
end

print(fun.max_by(max_cmp, fun.range(1, 10, 1)))

-- Transformation functions
-- https://luafun.github.io/transformations.html
fun.each(
    print,
    fun.map(function(x)
        return 2 * x
    end, fun.range(4))
)

fun.each(print, fun.enumerate({ 'a', 'b', 'c', 'd', 'e' }))
fun.each(print, fun.enumerate(fun.zip({ 'one', 'two', 'three', 'four', 'five' }, { 'a', 'b', 'c', 'd', 'e' })))
fun.each(print, fun.intersperse('x', { 'a', 'b', 'c', 'd', 'e' }))

-- Composition functions
-- https://luafun.github.io/compositions.html
fun.each(print, fun.zip({ 'a', 'b', 'c', 'd' }, { 'one', 'two', 'three' }))
fun.each(print, fun.zip())
fun.each(print, fun.zip(fun.range(5), { 'a', 'b', 'c' }, fun.rands()))
fun.each(
    print,
    fun.zip(fun.partition(function(x)
        return x > 7
    end, fun.range(1, 15, 1)))
)

fun.each(print, fun.take(15, fun.cycle(fun.range(5))))
fun.range(3):cycle():take(100):each(print)
fun.each(print, fun.take(15, fun.cycle(fun.zip(fun.range(5), { 'a', 'b', 'c', 'd', 'e' }))))

fun.each(print, fun.chain(fun.range(2), { 'a', 'b', 'c' }, { 'one', 'two', 'three' }))
fun.each(print, fun.take(15, fun.cycle(fun.chain(fun.enumerate({ 'a', 'b', 'c' }), { 'one', 'two', 'three' }))))

-- Operators
-- https://luafun.github.io/operators.html
-- There are many of these, just use fun.operator LSP help to check them
print(fun.reduce(fun.operator.concat, '', { 'these', 'strings', 'should', 'concat' }))

--[[
-- Step size can't be 0
for _it, v in fun.range(1, 0) do
    print(v)
end
for _it, v in fun.range(0, 10, 0) do
    print(v)
end
]]
-- local test = fun.fun.range(100)
--     :filter(function(x)
--         return x % 7 == 0
--     end)
--     :map(function(x)
--         return x ^ 2
--     end)
--     :each(print)
--
-- local one = fun.fun.range(50, 100)
-- local two = fun.fun.range(50)
-- local three = fun.fun.range(50)
--
-- fun.zip(one, two, three):each(print)
--
-- -- A basic thing I want is to take a single number and create a list with mappings and sum them
-- local sum_test = fun.sum(fun.fun.range(10))
-- print(sum_test)
-- print(type(sum_test))
--
-- local sum_test2 = fun.fun.range(10):map(function(x) return x^2 end):sum()
-- print(sum_test2)
-- print(type(sum_test2))
--
-- local sum_test3 = (fun.fun.range(10):sum() ^ 2)
-- print(sum_test3)
-- print(type(sum_test3))
