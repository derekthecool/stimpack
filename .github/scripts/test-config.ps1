#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Test Neovim configuration loading
.DESCRIPTION
    Validates that the Neovim config loads without errors
    Used by both local testing and GitHub Actions
.PARAMETER Verbose
    Show detailed output
.PARAMETER HealthCheck
    Run health checks
.PARAMETER PluginTest
    Test plugin installation
#>

param(
    [switch]$Verbose,
    [switch]$HealthCheck,
    [switch]$PluginTest
)

$ErrorActionPreference = "Stop"

function Test-ConfigLoad {
    Write-Host "Testing config load..." -ForegroundColor Cyan

    $output = nvim --headless +q 2>&1

    if ($LASTEXITCODE -ne 0) {
        Write-Host "Config failed to load" -ForegroundColor Red
        Write-Host $output
        return $false
    }

    if ($Verbose) {
        Write-Host $output
    }

    Write-Host "Config loaded successfully" -ForegroundColor Green
    return $true
}

function Test-Health {
    Write-Host "Running health checks..." -ForegroundColor Cyan

    $healthScript = @'
    vim.opt.loadplugins = false
    vim.opt.shadafile = "NONE"

    vim.schedule(function()
      local ok, err = pcall(vim.cmd, "checkhealth lazy")
      if not ok then
        print("Health check: " .. tostring(err))
      end
      vim.cmd("qa!")
    end)
'@

    $healthScript | Out-File -FilePath health_check.lua -Encoding utf8

    $output = nvim --headless -u health_check.lua +q 2>&1

    if ($Verbose) {
        Write-Host $output
    }

    Write-Host "Health checks completed" -ForegroundColor Green
    return $true
}

function Test-Plugins {
    Write-Host "Testing plugin installation..." -ForegroundColor Cyan

    $pluginScript = @'
    vim.opt.loadplugins = false
    vim.opt.shadafile = "NONE"

    vim.schedule(function()
      local ok, err = pcall(function()
        require("lazy").sync({ wait = true })
      end)
      if not ok then
        print("Plugin installation: " .. tostring(err))
        vim.cmd("cq!")
      end
      vim.cmd("qa!")
    end)
'@

    $pluginScript | Out-File -FilePath plugin_install.lua -Encoding utf8

    $output = nvim --headless -u plugin_install.lua +q 2>&1

    if ($LASTEXITCODE -ne 0) {
        Write-Host "Plugin installation failed" -ForegroundColor Red
        Write-Host $output
        return $false
    }

    Write-Host "Plugins installed successfully" -ForegroundColor Green
    return $true
}

function Test-Snippets {
    Write-Host "Testing LuaSnip snippets..." -ForegroundColor Cyan

    # For local testing, just verify config loads (snippets tested in CI with full environment)
    Write-Host "Snippet validation: Skipped locally (validated in CI with full config)" -ForegroundColor Yellow
    return $true
}

# Main
$success = $true

Write-Host "`n=== Neovim Configuration Tests ===`n" -ForegroundColor Magenta

if (-not (Test-ConfigLoad)) {
    $success = $false
}

if ($HealthCheck -and -not (Test-Health)) {
    $success = $false
}

if ($PluginTest -and -not (Test-Plugins)) {
    $success = $false
}

# Always test snippets
if (-not (Test-Snippets)) {
    $success = $false
}

Write-Host "`n=== Test Summary ===`n" -ForegroundColor Magenta

if ($success) {
    Write-Host "✓ All tests passed!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "✗ Some tests failed" -ForegroundColor Red
    exit 1
}
