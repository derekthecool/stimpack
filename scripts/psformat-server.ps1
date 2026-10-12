#requires -Version 7
<#
.SYNOPSIS
    Long-lived Invoke-Formatter server for conform.nvim.
.DESCRIPTION
    Reads one JSON request per line on stdin ({"text": "..."}) and writes one JSON
    response per line on stdout ({"ok": true, "text": "..."} or {"ok": false, "err": "..."}).
    Avoids paying pwsh startup + module load cost on every format.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$SettingsPath
)

$utf8 = [Text.UTF8Encoding]::new($false)
[Console]::InputEncoding = $utf8
[Console]::OutputEncoding = $utf8
$reader = [IO.StreamReader]::new([Console]::OpenStandardInput(), $utf8)
$writer = [IO.StreamWriter]::new([Console]::OpenStandardOutput(), $utf8)
$writer.AutoFlush = $true

Import-Module PSScriptAnalyzer
# Warm up so the first real request is fast.
$null = Invoke-Formatter -ScriptDefinition '$a=1' -Settings $SettingsPath
$writer.WriteLine('{"ready":true}')

while ($null -ne ($line = $reader.ReadLine())) {
    try {
        $request = $line | ConvertFrom-Json
        $text = Invoke-Formatter -ScriptDefinition $request.text -Settings $SettingsPath
        $response = @{ ok = $true; text = $text }
    } catch {
        $response = @{ ok = $false; err = $_.ToString() }
    }
    $writer.WriteLine(($response | ConvertTo-Json -Compress))
}
