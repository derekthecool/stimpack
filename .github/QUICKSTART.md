# CI/CD Quick Reference

Quick commands for working with the Neovim config CI/CD workflows.

## 🚀 Quick Test Commands

### Local Testing

```bash
# Run all tests
pwsh .github/scripts/test-config.ps1

# Run with verbose output
pwsh .github/scripts/test-config.ps1 -Verbose

# Run with health checks
pwsh .github/scripts/test-config.ps1 -HealthCheck

# Check formatting only
stylua --check lua/

# Format all files
stylua lua/
```

### Trigger Workflows

```bash
# Trigger test workflow
gh workflow run test-config.yml

# Trigger plugin update (dry run)
gh workflow run plugin-updates.yml -f dry_run=true

# Trigger plugin update (create PR)
gh workflow run plugin-updates.yml
```

### Monitor Workflows

```bash
# Watch latest workflow run
gh run watch

# List recent runs
gh run list --limit 10

# View specific run
gh run view <run-id>

# View logs
gh run view <run-id> --log

# Download artifacts
gh run download <run-id>
```

## 🔧 Common Scenarios

### "I made changes, did I break anything?"

```bash
# 1. Test locally first
pwsh .github/scripts/test-config.ps1

# 2. Check formatting
stylua --check lua/

# 3. If issues found, fix and retest
stylua lua/
pwsh .github/scripts/test-config.ps1
```

### "I want to update plugins"

```bash
# Option 1: Let automation handle it (runs weekly)
# Nothing to do! Check for PR on Sundays.

# Option 2: Trigger manually
gh workflow run plugin-updates.yml

# Option 3: Test locally first
nvim --headless +"Lazy sync" +qa
```

### "Tests failed, now what?"

```bash
# 1. Get the run ID
RUN_ID=$(gh run list --limit 1 --json databaseId --jq '.[0].databaseId')

# 2. View the failure
gh run view $RUN_ID

# 3. Download logs
gh run download $RUN_ID

# 4. Check specific job logs
gh run view $RUN_ID --log --job <job-id>

# 5. Reproduce locally (if possible)
pwsh .github/scripts/test-config.ps1 -Verbose
```

### "I need to validate a PR"

```bash
# Check PR status
gh pr view <pr-number>

# View CI checks
gh pr checks <pr-number>

# View workflow runs for PR
gh run list --head=<branch-name>

# Watch PR checks in real-time
gh run watch --branch=<branch-name>
```

## 📋 Workflow Status Reference

### Test Workflow (`test-config.yml`)

**What it tests:**
- ✅ Config loads
- ✅ Plugins install
- ✅ Health checks pass
- ✅ Lua syntax valid
- ✅ LuaSnip snippets load

**When it runs:**
- Push to `master`/`main`
- Pull request to `master`/`main`
- Manual trigger

**Duration:** 2-5 minutes (cached), 5-10 minutes (uncached)

### Format Workflow (`format.yml`)

**What it checks:**
- ✅ Code follows `stylua.toml` formatting

**When it runs:**
- Push to any branch
- Pull request to `master`/`main`

**Duration:** 10-30 seconds

### Plugin Update Workflow (`plugin-updates.yml`)

**What it does:**
- 🔍 Checks for plugin updates
- 🧪 Tests updates on all platforms
- 🔧 Creates PR if tests pass
- 🤖 Auto-merges when CI passes

**When it runs:**
- Weekly (Sundays 9 AM UTC)
- Manual trigger (with or without dry-run)

**Duration:** 3-5 minutes (cached), 5-10 minutes (uncached)

## 🎯 Platform Matrix

All workflows test on:

| Platform | Runner | Notes |
|----------|--------|-------|
| Ubuntu | `ubuntu-latest` | Linux, uses apt |
| macOS | `macos-latest` | macOS, uses brew |
| Windows | `windows-latest` | Windows, uses PowerShell |

All platforms must pass for the workflow to succeed.

## 📁 Important Files

```
.github/
├── workflows/
│   ├── test-config.yml       # Main testing pipeline
│   ├── plugin-updates.yml    # Plugin automation
│   └── format.yml            # Format checking
├── scripts/
│   └── test-config.ps1       # Local test script
├── TESTING.md                # Detailed testing guide
├── VALIDATION.md             # CI/CD validation guide
└── QUICKSTART.md             # This file
```

## 🔐 Required Permissions

Workflows require these permissions (auto-configured):

- `contents: read` - Read repository contents
- `pull-requests: write` - Comment on PRs (test failures)
- `contents: write` - Create PRs (plugin updates)

## ⚡ Performance Tips

1. **Caching**: Plugin downloads are cached after first run
2. **Concurrency**: Old workflow runs cancel automatically on new commits
3. **Fail-fast**: Disabled to see all platform results
4. **Artifacts**: Only uploaded on failure (saves storage)

## 🚨 Emergency Commands

### "I need to stop all workflows"

```bash
# Cancel all in-progress runs
gh run list --json databaseId,status --jq '.[] | select(.status == "in_progress") | .databaseId' | xargs -I {} gh run cancel {}
```

### "A bad PR got merged, how do I revert?"

```bash
# Revert the merge commit
git revert -m 1 <merge-commit-hash>
git push origin master

# CI will automatically test the revert
```

### "Plugin update broke everything"

```bash
# Close the plugin update PR
gh pr close <pr-number>

# Revert the lock file
git revert HEAD

# Push the revert
git push origin master
```

## 📊 Status Badges

Add these to your README.md:

```markdown
[![Test Config](https://github.com/<user>/<repo>/actions/workflows/test-config.yml/badge.svg)](https://github.com/<user>/<repo>/actions/workflows/test-config.yml)
[![Format](https://github.com/<user>/<repo>/actions/workflows/format.yml/badge.svg)](https://github.com/<user>/<repo>/actions/workflows/format.yml)
[![Plugin Updates](https://github.com/<user>/<repo>/actions/workflows/plugin-updates.yml/badge.svg)](https://github.com/<user>/<repo>/actions/workflows/plugin-updates.yml)
```

## 🎓 Learning Resources

- **Detailed testing**: See `TESTING.md`
- **Validation guide**: See `VALIDATION.md`
- **Plan document**: See `CI_CD_plan.log`
- **GitHub Actions**: https://docs.github.com/en/actions

## 💡 Pro Tips

1. **Always test locally** before pushing
2. **Use dry-run mode** when testing plugin updates
3. **Monitor the first run** after making workflow changes
4. **Check artifacts** when debugging failures
5. **Read the logs** - they contain detailed error information

## 🆘 Getting Help

If something isn't working:

1. Check workflow logs in GitHub Actions UI
2. Run tests locally with verbose output
3. Download and inspect artifacts
4. Consult `TESTING.md` for detailed procedures
5. Review `VALIDATION.md` for troubleshooting steps

---

**Last Updated**: 2026-05-05
**CI/CD Version**: 1.0 (Production)
**Status**: ✅ All systems operational