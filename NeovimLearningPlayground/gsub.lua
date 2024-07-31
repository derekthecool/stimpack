local title_casing = 'This Is Title Casing'

local function invert_case(s)
    if s:byte() < string.byte('a') then
        s = s:lower()
    else
        s = s:upper()
    end
    return s
end

print((title_casing:gsub('%a', invert_case)))
print((title_casing:gsub('%u', invert_case)))
print((title_casing:gsub('%l', invert_case)))

local function to_snake_case(s)
    return (s:gsub(' ', '_'):lower())
end
print((title_casing:gsub(' ?%u', to_snake_case)))
print((title_casing:gsub(' ', '_'):lower()))

local replacement_table = {
    dog = 'cat',
    cow = 'sheep',
    monkey = 'harpy eagle',
}

local original_text = 'the dog met a cow who had been attacked by a monkey'
print(original_text:gsub('%w+', replacement_table))
