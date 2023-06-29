local curl = require('plenary.curl')

local res = curl.get('https://scalameta.org/metals/latests.json', { accept = 'application/json' })

if res and res.status == 200 then
    server_version = vim.fn.json_decode(res.body).snapshot
    print(server_version)
else
    log.error_and_show('Something went wrong getting the latest snapshot so defaulting to latest stable.')
    server_version = latest_stable
end
