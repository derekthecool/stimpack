# Testing Guide

This guide covers local testing and CI validation for the Neovim configuration.

## Local Testing

### PowerShell Test Script

Use the provided PowerShell script for comprehensive local testing:

```powershell
# Basic test
pwsh .github/scripts/test-config.ps1

# With health checks and verbose output
pwsh .github/scripts/test-config.ps1 -HealthCheck -Verbose

# Test plugin installation
pwsh .github/scripts/test-config.ps1 -PluginTest
```

### Manual Testing Commands

```bash
# Test config loads
nvim --headless +q

# Run health checks
nvim --headless +"lua vim.schedule(function() vim.cmd('checkhealth lazy') vim.cmd('qa!') end)" +q

# Test plugin sync
nvim --headless +"lua vim.schedule(function() require('lazy').sync({wait=true}) vim.cmd('qa!') end)" +q

# Test LuaSnip snippets
nvim --headless +"lua vim.schedule(function() local ok, err = pcall(require, 'luasnip') print(ok and 'OK' or err) vim.cmd('qa!') end)" +q
```

### Format Checking

```bash
# Check formatting
stylua --check lua/

# Format files
stylua lua/

# Show what would change
stylua lua/ --diff
```

## GitHub CLI Testing

Use `gh` CLI to validate workflows during development:

### Trigger Workflows Manually

```bash
# Trigger test workflow
gh workflow run test-config.yml --ref master

# Trigger with options
gh workflow run test-config.yml --ref master -f run_full_tests=true

# Trigger plugin update (dry run)
gh workflow run plugin-updates.yml --ref master -f dry_run=true
```

### Monitor Workflow Execution

```bash
# Watch workflow run in real-time
gh run watch --interval 5

# List recent workflow runs
gh run list --workflow=test-config.yml --limit 10

# View detailed results
gh run view <run-id>

# View full logs
gh run view <run-id> --log

# Get workflow status as JSON
gh run view <run-id> --json conclusion,displayName,startedAt,updatedAt
```

### Download and Inspect Artifacts

```bash
# List artifacts for a run
gh run view <run-id> --json artifacts --jq '.artifacts[].name'

# Download specific artifact
gh run download <run-id> --name test-results-ubuntu-latest

# Download all artifacts
gh run download <run-id>

# Check job status
gh run view <run-id> --json jobs --jq '.jobs[] | {name: .name, conclusion: .conclusion}'
```

### Debug Failed Runs

```bash
# View failed jobs
gh run view <run-id> --json jobs --jq '.jobs[] | select(.conclusion != "success")'

# View logs for specific job
gh run view <run-id> --log --job <job-id>

# Search logs for errors
gh run view <run-id> --log | grep -i "error"

# Check specific platform logs
gh run view <run-id> --log | grep -A 30 "Config Load Test"
```

## CI Workflow Triggers

### Test Workflow (`test-config.yml`)

**Automatic triggers:**
- Push to `master` or `main` branch
- Pull request to `master` or `main` branch

**Manual trigger:**
```bash
gh workflow run test-config.yml --ref master
```

**What it tests:**
1. Neovim installation
2. Configuration loads without errors
3. Health checks pass
4. Plugins install successfully
5. Lua files have valid syntax
6. LuaSnip snippets load correctly
7. Code is properly formatted

### Format Workflow (`format.yml`)

**Automatic triggers:**
- Push to `master` or `main` branch
- Pull request to `master` or `main` branch

**What it checks:**
- All Lua files conform to `stylua.toml` formatting

### Plugin Update Workflow (`plugin-updates.yml`)

**Automatic triggers:**
- Weekly schedule: Sundays at 9 AM UTC

**Manual trigger:**
```bash
# Dry run (no PR created)
gh workflow run plugin-updates.yml --ref master -f dry_run=true

# Force update all plugins
gh workflow run plugin-updates.yml --ref master -f force_update=true

# Full update with PR creation
gh workflow run plugin-updates.yml --ref master
```

**What it does:**
1. Checks for plugin updates
2. Tests updates on all platforms (Ubuntu, Windows, macOS)
3. Creates PR if all tests pass
4. Auto-merges when CI checks pass

## Troubleshooting

### Config Fails to Load

**Symptoms:** Test workflow fails at "Test configuration loads" step

**Debug steps:**
1. Download test artifacts: `gh run download <run-id> --name test-results-<os>`
2. Check `load_test.log` for specific errors
3. Test locally: `nvim --headless +q`
4. Check `init.lua` for syntax errors
5. Verify all Lua files have correct syntax

### Plugin Installation Fails

**Symptoms:** Test workflow fails at "Test plugin installation" step

**Debug steps:**
1. Check `plugin_install.log` for specific plugin errors
2. Test plugins manually: `nvim --headless +"Lazy sync" +q`
3. Check plugin URLs in `lua/config/lazy.lua`
4. Verify network connectivity in CI environment
5. Check for plugin conflicts or missing dependencies

### Snippet Validation Fails

**Symptoms:** Test workflow fails at "Test LuaSnip snippets" step

**Debug steps:**
1. Check `snippet_test.log` for Lua errors
2. Test snippets locally: `nvim --headless +"lua require('luasnip')" +q`
3. Check snippet files in `lua/luasnippets/` for syntax errors
4. Verify snippet files use correct LuaSnip API
5. Check for undefined variables or typos

### Platform-Specific Issues

**Linux:**
- Path separators use `/`
- Use `sudo apt-get` for packages
- Check for missing dependencies

**Windows:**
- Path separators use `\`
- PowerShell commands may differ
- Check for case-sensitivity issues

**macOS:**
- Uses Homebrew for packages
- May have different default shell
- Check for macOS-specific path issues

### Format Check Fails

**Symptoms:** Format workflow fails with formatting errors

**Fix:**
```bash
# Run locally to fix formatting
stylua lua/

# Verify it's fixed
stylua --check lua/
```

## Expected Test Duration

- **Config load test:** ~10-20 seconds per platform
- **Plugin installation:** ~1-3 minutes per platform
- **Full test suite:** ~5-10 minutes total (all 3 platforms)
- **Format check:** ~5-10 seconds

## Validation Checklist

Use this checklist when validating new workflows:

- [ ] Test workflow runs successfully on Ubuntu
- [ ] Test workflow runs successfully on Windows
- [ ] Test workflow runs successfully on macOS
- [ ] Can download and inspect test artifacts
- [ ] Logs show config loading successfully
- [ ] Plugin installation completes without errors
- [ ] Health checks pass on all platforms
- [ ] Snippet validation shows LuaSnip loaded successfully
- [ ] Format check passes (or shows proper errors)
- [ ] Plugin update workflow detects changes in dry-run mode
- [ ] Plugin update creates PR when dry_run=false
- [ ] Auto-merge works when all tests pass

## Best Practices

1. **Test locally first** - Run the PowerShell script before pushing
2. **Use dry-run mode** - Test plugin updates with `dry_run=true` first
3. **Monitor artifacts** - Download and inspect test logs for debugging
4. **Check all platforms** - Don't assume success on one platform means all work
5. **Read the logs** - Artifact logs contain detailed error information
6. **Format before committing** - Run `stylua lua/` to avoid format check failures
