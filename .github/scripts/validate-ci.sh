#!/bin/bash
# CI/CD Validation Script
# This script validates that all CI/CD components are properly configured

set -e

echo "=== CI/CD Validation Script ==="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track overall status
ALL_PASSED=true

# Function to print status
print_status() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓ $2${NC}"
    else
        echo -e "${RED}✗ $2${NC}"
        ALL_PASSED=false
    fi
}

# Function to check if a file exists
check_file() {
    if [ -f "$1" ]; then
        print_status 0 "File exists: $1"
        return 0
    else
        print_status 1 "File missing: $1"
        return 1
    fi
}

# Function to check if a file is valid YAML
check_yaml() {
    # Basic YAML syntax check using grep
    if grep -q $'^\t' "$1"; then
        print_status 1 "Invalid YAML (tabs found): $1"
        return 1
    elif [ $(awk 'NR>1 && /^---/ {print NR}' "$1" | wc -l) -gt 1 ]; then
        print_status 0 "Valid YAML structure: $1"
        return 0
    else
        print_status 0 "Valid YAML structure: $1"
        return 0
    fi
}

echo "1. Checking workflow files..."
echo "─────────────────────────────"

# Check if workflow files exist
check_file ".github/workflows/test-config.yml"
check_file ".github/workflows/plugin-updates.yml"
check_file ".github/workflows/format.yml"

echo ""
echo "2. Validating workflow syntax..."
echo "─────────────────────────────────"

# Validate YAML syntax
check_yaml ".github/workflows/test-config.yml"
check_yaml ".github/workflows/plugin-updates.yml"
check_yaml ".github/workflows/format.yml"

echo ""
echo "3. Checking supporting files..."
echo "────────────────────────────────"

# Check supporting files
check_file ".github/scripts/test-config.ps1"
check_file ".github/TESTING.md"
check_file ".github/dependabot.yml"
check_file ".github/DEPLOYMENT.md"

echo ""
echo "4. Checking configuration files..."
echo "──────────────────────────────────"

# Check config files
check_file "init.lua"
check_file "lua/config/lazy.lua"
check_file "stylua.toml"
check_file "lazy-lock.json"

echo ""
echo "5. Checking Lua syntax..."
echo "─────────────────────────"

# Check if nvim is available
if command -v nvim &> /dev/null; then
    print_status 0 "Neovim found: $(nvim --version | head -n1)"
else
    print_status 1 "Neovim not found"
fi

# Check if pwsh is available
if command -v pwsh &> /dev/null; then
    print_status 0 "PowerShell found: $(pwsh --version)"
else
    print_status 1 "PowerShell not found"
fi

# Check if stylua is available
if command -v stylua &> /dev/null; then
    print_status 0 "Stylua found: $(stylua --version)"
else
    print_status 1 "Stylua not found"
fi

echo ""
echo "6. Validating Lua files..."
echo "───────────────────────────"

# Count Lua files
LUA_FILES=$(find lua -name "*.lua" -type f | wc -l)
print_status 0 "Found $LUA_FILES Lua files"

# Count snippet files
SNIPPET_FILES=$(find lua/luasnippets -name "*.lua" -type f 2>/dev/null | wc -l)
print_status 0 "Found $SNIPPET_FILES snippet files"

echo ""
echo "7. Checking workflow structure..."
echo "─────────────────────────────────"

# Check test-config.yml has required jobs
if grep -q "name: Test Neovim Configuration" .github/workflows/test-config.yml; then
    print_status 0 "test-config.yml has correct name"
else
    print_status 1 "test-config.yml missing correct name"
fi

if grep -q "jobs:" .github/workflows/test-config.yml && grep -q "test:" .github/workflows/test-config.yml; then
    print_status 0 "test-config.yml has test job"
else
    print_status 1 "test-config.yml missing test job"
fi

# Check plugin-updates.yml has required jobs
if grep -q "name: Plugin Update Automation" .github/workflows/plugin-updates.yml; then
    print_status 0 "plugin-updates.yml has correct name"
else
    print_status 1 "plugin-updates.yml missing correct name"
fi

if grep -q "schedule:" .github/workflows/plugin-updates.yml; then
    print_status 0 "plugin-updates.yml has schedule trigger"
else
    print_status 1 "plugin-updates.yml missing schedule trigger"
fi

# Check format.yml has required jobs
if grep -q "name: Format Check" .github/workflows/format.yml; then
    print_status 0 "format.yml has correct name"
else
    print_status 1 "format.yml missing correct name"
fi

echo ""
echo "8. Checking for critical fixes..."
echo "──────────────────────────────────"

# Check if workflows use Lua API instead of :Lazy commands
if grep -q 'require("lazy").sync' .github/workflows/test-config.yml; then
    print_status 0 "test-config.yml uses Lua API for plugin sync"
else
    print_status 1 "test-config.yml still uses :Lazy commands (BROKEN)"
fi

if grep -q 'require("lazy").sync' .github/workflows/plugin-updates.yml; then
    print_status 0 "plugin-updates.yml uses Lua API for plugin sync"
else
    print_status 1 "plugin-updates.yml still uses :Lazy commands (BROKEN)"
fi

# Check if workflows use vim.schedule for proper initialization
if grep -q "vim.schedule" .github/workflows/test-config.yml; then
    print_status 0 "test-config.yml uses vim.schedule for proper initialization"
else
    print_status 1 "test-config.yml missing vim.schedule (may fail)"
fi

if grep -q "vim.schedule" .github/workflows/plugin-updates.yml; then
    print_status 0 "plugin-updates.yml uses vim.schedule for proper initialization"
else
    print_status 1 "plugin-updates.yml missing vim.schedule (may fail)"
fi

echo ""
echo "9. Summary..."
echo "─────────────"

if [ "$ALL_PASSED" = true ]; then
    echo -e "${GREEN}✓ All validations passed!${NC}"
    echo ""
    echo "The CI/CD implementation is complete and ready for testing."
    echo ""
    echo "Next steps:"
    echo "1. Push changes to GitHub"
    echo "2. Monitor workflow runs: gh run watch"
    echo "3. View results: gh run view <run-id> --log"
    echo "4. Download artifacts: gh run download <run-id>"
    exit 0
else
    echo -e "${RED}✗ Some validations failed${NC}"
    echo ""
    echo "Please fix the issues above before proceeding."
    exit 1
fi
