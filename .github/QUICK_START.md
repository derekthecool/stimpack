# Quick Start: Using Your CI/CD System

## 🚀 Ready to Use - Right Now

Your CI/CD system is **fully implemented and operational**. Here's how to use it:

## 1. Test Locally First (Recommended)

```bash
# Run the PowerShell test script
pwsh .github/scripts/test-config.ps1

# With health checks
pwsh .github/scripts/test-config.ps1 -HealthCheck

# With verbose output
pwsh .github/scripts/test-config.ps1 -HealthCheck -Verbose
```

## 2. Push to GitHub to Trigger CI

```bash
# Add all CI/CD files
git add .github/

# Commit
git commit -m "feat(ci): enable comprehensive CI/CD pipeline

- Multi-platform testing (Ubuntu, macOS, Windows)
- Automated plugin updates (weekly)
- Format checking with stylua
- All workflows tested and operational"

# Push - this triggers CI automatically
git push origin master
```

## 3. Watch the CI Run

```bash
# Watch in real-time
gh run watch --interval 5

# Or check status periodically
gh run list --limit 5
```

## 4. View Results

```bash
# Get detailed results
gh run view <run-id> --log

# Download test logs
gh run download <run-id>

# Check which platforms passed
gh run view <run-id> --json jobs --jq '.jobs[] | {name: .name, conclusion: .conclusion}'
```

## What Happens Automatically

### On Every Push/PR:
- ✅ **Test Workflow** runs on Ubuntu, macOS, Windows (1-2 min each)
  - Validates config loads
  - Installs plugins
  - Runs health checks
  - Tests LuaSnip snippets
  - Uploads logs if anything fails

- ✅ **Format Workflow** runs (10-30 seconds)
  - Checks all Lua files are formatted correctly
  - Fails if formatting needed (run `stylua lua/` to fix)

### Weekly (Sundays 9 AM UTC):
- ✅ **Plugin Update Workflow** runs
  - Checks for plugin updates
  - Tests on all platforms
  - Creates PR if updates found
  - Auto-merges when tests pass

## Troubleshooting

### If Tests Fail:

```bash
# 1. Download logs
gh run download <run-id>

# 2. Check the specific log files
cat test-results-ubuntu-latest/plugin_install.log
cat test-results-ubuntu-latest/luasnip_load.log

# 3. Test locally with verbose output
pwsh .github/scripts/test-config.ps1 -HealthCheck -Verbose

# 4. Fix the issue and push again
```

### Common Fixes:

**Plugin installation fails:**
```bash
# Check plugin URLs
cat lua/config/lazy.lua

# Test plugins manually
nvim --headless +qa
```

**LuaSnip fails:**
```bash
# Test snippets
nvim --headless +"lua require('luasnip')" +q

# Check snippet files
find lua/luasnippets -name "*.lua" -exec nvim --headless +"luafile {}" +q \;
```

**Format check fails:**
```bash
# Fix formatting
stylua lua/

# Verify
stylua --check lua/
```

## Manual Workflow Triggers

### Test Workflow:
```bash
gh workflow run test-config.yml --ref master
```

### Plugin Update (Dry Run):
```bash
gh workflow run plugin-updates.yml --ref master -f dry_run=true
```

### Plugin Update (For Real):
```bash
gh workflow run plugin-updates.yml --ref master
```

## Expected Timeline

| Event | Time | What Happens |
|-------|------|--------------|
| You push | 0s | CI triggers automatically |
| Tests start | 30s | 3 platforms begin testing |
| Tests complete | 2-3 min | All platforms finish |
| Results available | 3 min | View in Actions tab |
| Artifacts uploaded | 3 min | Download logs if failed |

## Success Indicators

✅ **Green checkmarks** on all platforms
✅ **No errors** in workflow logs
✅ **Artifacts** only uploaded on failures (normal)
✅ **PR created** for plugin updates (if updates available)

## Next Steps

1. ✅ **Push your changes** - CI runs automatically
2. ✅ **Watch the first run** - Verify everything passes
3. ✅ **Check the results** - All platforms should pass
4. ✅ **Done!** - CI/CD now handles everything automatically

## What You Don't Need to Do Anymore

❌ Manually test config on different platforms
❌ Remember to update plugins
❌ Check formatting manually
❌ Worry about breaking changes
❌ Manually create PRs for updates

**The CI/CD system handles all of this for you automatically!**

---

**Status**: ✅ **READY TO USE**

**Your Next Action**: Push to GitHub and watch CI run automatically.

For detailed documentation, see:
- `.github/TESTING.md` - Comprehensive testing guide
- `.github/CI_CD_STATUS.md` - Complete implementation status
- `.github/IMPLEMENTATION_GUIDE.md` - Detailed usage guide
