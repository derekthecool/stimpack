-- Print all the lua packages that are loaded

local count = 0
for name, _ in pairs(package.loaded) do
    print(name)

    if name:match('stimpack') then
        print('name matched ' .. name)
        count = count + 1
    end
end
print(string.format('Count of matching packages from my config: %d\n', count))
