---@diagnostic disable: undefined-global
local snippets = {
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
                i(1, 'dll_name'),
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
}

return snippets, autosnippets
