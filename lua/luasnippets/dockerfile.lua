---@diagnostic disable: undefined-global

local fun = require('luafun.fun')
local scan = require('plenary.scandir')

local snippets = {

    --[[
     this version seems better
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /App

# Disable Microsoft diagnostics
ENV DOTNET_EnableDiagnostics=0

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /App
COPY --from=build-env /App/out .

ENTRYPOINT ["dotnet", "BelleLTE_DeviceId_Provisioner.dll"]
    ]]
    s(
        'dotnet',
        fmt(
            [[
         FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
         WORKDIR /App

         # Copy everything
         COPY . ./
         # Restore as distinct layers
         RUN dotnet restore
         # Build and publish a release
         RUN dotnet publish -c Release -o out

         # Build runtime image
         FROM mcr.microsoft.com/dotnet/runtime:7.0
         WORKDIR /App
         COPY --from=build-env /App/out .

         # Disable Microsoft diagnostics
         ENV DOTNET_EnableDiagnostics=0

         ENTRYPOINT ["dotnet", "{}.dll"]
         ]],
            {
                d(1, function(args, snip)
                    -- -- Add nodes for snippet
                    -- local dlls = fun.map(function(a)
                    --     return t(vim.fs.normalize(a))
                    -- end, scan.scan_dir('*.dll', { respect_gitignore = false, depth = 2 })):totable()

                    -- Scan directory of current opened file
                    local current_file_directory = vim.fn.expand('%:h')
                    -- print(current_file_directory)
                    local depth_full =
                        scan.scan_dir(current_file_directory, { respect_gitignore = true, search_pattern = '*.dll' })
                    -- print(depth_full)
                    -- print(#depth_full)
                    local dlls = {}
                    for _, value in pairs(depth_full) do
                        table.insert(dlls, t(value))
                    end

                    return sn(nil, c(1, dlls))
                end, { 1 }),
            }
        )
    ),

    s(
        'alpine',
        fmt(
            [[
        FROM alpine

        RUN apk add --no-cache \
            {}
        ]],
            {
                i(1, 'htop'),
            }
        )
    ),
}

local autosnippets = {
    -- Simple set of snippets to get uppercase
    s('from', t('FROM ')),
    s('work dir', t('WORKDIR ')),
    s('copy', t('COPY ')),
    s('run', t('RUN ')),
    s('expose', t('EXPOSE ')),
    s('cmd', t('CMD')),
    s('environment', t('ENV ')),
    s('arg', t('ARG ')),

    s(
        'command',
        fmt([[CMD {}"{}"{}{}]], {
            t('['),
            i(1),
            i(2),
            t(']'),
        })
    ),

    s(
        'FIRST',
        fmt(
            [[
        FROM {}
        ]],
            {
                i(1, 'ubuntu:latest'),
            }
        )
    ),
}

return snippets, autosnippets
