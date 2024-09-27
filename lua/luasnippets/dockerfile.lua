---@diagnostic disable: undefined-global

local fun = require('luafun.fun')
local scan = require('plenary.scandir')

local snippets = {

    ms(
        {
            { trig = 'asp.net', snippetType = 'snippet', condition = conds.line_begin },
            { trig = 'asp', snippetType = 'snippet', condition = conds.line_begin },
            { trig = 'dotnet_asp_net_api', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
        # https://hub.docker.com/_/microsoft-dotnet
        # Slight modification for project with solution and project file in same directory
        FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
        WORKDIR /source

        # copy csproj and restore as distinct layers
        COPY *.sln .
        COPY*.csproj .
        RUN dotnet restore

        # copy everything else and build app
        COPY . .
        WORKDIR /source
        RUN dotnet publish -c release -o /app --no-restore

        # final stage/image
        FROM mcr.microsoft.com/dotnet/aspnet:8.0
        WORKDIR /app
        COPY --from=build /app ./
        ENTRYPOINT ["dotnet", "{MyDLL}.dll"]
        ]],
            {
                MyDLL = i(1, 'NameOfMyProjectsDLL'),

            }
        )
    ),

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
                end, {}),
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
    -- s('from', t('FROM ')),
    ms(
        {
            { trig = 'from', snippetType = 'autosnippet' },
        },
        fmt([[FROM {}]], {
            c(1, {
                t('mcr.microsoft.com/dotnet/aspnet:8.0'),
                t('mcr.microsoft.com/dotnet/sdk:8.0'),
                t('mcr.microsoft.com/dotnet/runtime:8.0'),
                i(1, 'ubuntu:latest'),
            }),
        })
    ),
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
