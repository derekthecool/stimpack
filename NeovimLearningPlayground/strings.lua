-- Testing features with the string library
local text = 'This is sample text'

-- Print length
print('The length of the string is: ' .. #text)

-- http://www.lua.org/manual/5.4/manual.html#pdf-string.reverse
-- All string function can be called in two ways as shown in string.reverse versus text:reverse()
print(string.reverse(text)) -- better if you are NOT using a variable
print(text:reverse()) -- better if you are using a variable

-- http://www.lua.org/manual/5.4/manual.html#pdf-string.dump
local function test()
    return 1 + 1
end

print(string.dump(test, true))

-- http://www.lua.org/manual/5.4/manual.html#pdf-string.byte
print(text:byte(1, #text))

-- http://www.lua.org/manual/5.4/manual.html#pdf-string.char
print(string.char(65))

-- http://www.lua.org/manual/5.4/manual.html#pdf-string.find
print(text:find('is sample'))
print(text:find('z'))
print(text:find('.+'))

-- http://www.lua.org/manual/5.4/manual.html#pdf-string.format
local test_number = 65999.123456789123456789123456789
print(
    string.format(
        'Here is my formatted text: %d, %0.12f, %012X, %012x,%o',
        test_number,
        test_number,
        test_number,
        test_number,
        test_number
    )
)

-- http://www.lua.org/manual/5.4/manual.html#pdf-string.gmatch
print(text:gmatch('is'))
for match in text:gmatch('is') do
    print(match)
end
for match in text:gmatch('%w+') do
    print(match)
end

-- http://www.lua.org/manual/5.4/manual.html#pdf-string.gsub
print(text:gsub('is', 'dog dog dog'))
