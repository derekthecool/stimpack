# CI/CD Validation Guide

This guide provides step-by-step instructions to validate the CI/CD implementation works correctly across all platforms.

## Pre-Validation Checklist

Before running validation, ensure:
- [ ] Repository is synced with remote
- [ ] `gh` CLI is installed and authenticated
- [ ] You have write access to the repository
- [ ] No uncommitted changes (or commit them first)

## Phase 1: Local Testing

### 1.1 Validate Config Loads

```bash
# Test config loads
nvim --headless +q

# Test LuaSnip loads
nvim --headless +"lua require('luasnip')" +q

# Test plugins install
nvim --headless +"Lazy! sync" +qa
```

**Expected**: All commands complete without errors

### 1.2 Validate Formatting

```bash
# Check formatting
stylua --check lua/
```

**Expected**: "All files properly formatted" or list of files needing formatting

### 1.3 Run PowerShell Test Script

```bash
# Basic test
pwsh .github/scripts/test-config.ps1

# Full test with health checks
pwsh .github/scripts/test-config.ps1 -HealthCheck -Verbose

# Test plugin installation
pwsh .github/scripts/test-config.ps1 -PluginTest
```

**Expected**: "✓ All tests passed!"

## Phase 2: Workflow Validation

### 2.1 Trigger Test Workflow

```bash
# Trigger test workflow on master
gh workflow run test-config.yml --ref master

# Watch the workflow run
gh run watch --interval 5

# Wait for completion, then get status
gh run list --workflow=test-config.yml --limit 1
```

**Expected**: All 3 platform jobs pass (ubuntu-latest, macos-latest, windows-latest)

### 2.2 Inspect Test Results

```bash
# Get the run ID
RUN_ID=$(gh run list --workflow=test-config.yml --limit 1 --json databaseId --jq '.[0].databaseId')

# View detailed results
gh run view $RUN_ID

# View logs for a specific job
gh run view $RUN_ID --log --job <job-id>

# Check for failed jobs
gh run view $RUN_ID --json conclusion,jobs --jq '.jobs[] | select(.conclusion != "success")'
```

**Expected**: No failed jobs, all tests pass

### 2.3 Download Test Artifacts (if available)

```bash
# List artifacts
gh run view $RUN_ID --json artifacts --jq '.artifacts[].name'

# Download all artifacts
gh run download $RUN_ID

# Download specific artifact
gh run download $RUN_ID --name test-results-ubuntu-latest
```

**Expected**: Artifacts contain log files if tests failed

### 2.4 Check Test Summary

In GitHub Actions UI, navigate to the workflow run and view the "Summary" tab.

**Expected**: See test results for each platform with status indicators

## Phase 3: Format Workflow Validation

### 3.1 Trigger Format Check

```bash
# The format workflow runs automatically on push
# To trigger manually, create an empty commit:
git commit --allow-empty -m "test: trigger format workflow"
git push origin master
```

**Expected**: Format workflow runs and passes

### 3.2 Check Format Results

```bash
# Get format workflow run
FORMAT_RUN_ID=$(gh run list --workflow=format.yml --limit 1 --json databaseId --jq '.[0].databaseId')

# View results
gh run view $FORMAT_RUN_ID
```

**Expected**: Format check passes

### 3.3 Test Format Failure (Optional)

To test format failure detection:

```bash
# Create a badly formatted Lua file
echo "function test() return 1 end" > lua/bad_format.lua

# Commit and push
git add lua/bad_format.lua
git commit -m "test: badly formatted file"
git push origin master

# Check format workflow fails
gh run watch --workflow=format.yml

# Clean up
git reset --hard HEAD~1
git push origin master --force
stylua lua/bad_format.lua
rm lua/bad_format.lua
```

**Expected**: Format workflow fails with diff showing formatting issues

## Phase 4: Plugin Update Workflow Validation

### 4.1 Dry Run Test

```bash
# Trigger plugin update in dry-run mode
gh workflow run plugin-updates.yml --ref master -f dry_run=true

# Watch the workflow
gh run watch --interval 5
```

**Expected**: Workflow runs, detects updates (if any), but doesn't create PR

### 4.2 Check Dry Run Results

```bash
# Get the run ID
UPDATE_RUN_ID=$(gh run list --workflow=plugin-updates.yml --limit 1 --json databaseId --jq '.[0].databaseId')

# View results
gh run view $UPDATE_RUN_ID

# View logs
gh run view $UPDATE_RUN_ID --log
```

**Expected**: No PR created in dry-run mode

### 4.3 Full Update Test (Optional)

**WARNING**: This will create a PR if plugin updates are available.

```bash
# Trigger full plugin update
gh workflow run plugin-updates.yml --ref master

# Watch the workflow
gh run watch --interval 5

# Check for created PR
gh pr list --head plugin-updates-
```

**Expected**: If updates available, PR is created with lock file changes

### 4.4 Verify PR Auto-Merge (if PR created)

```bash
# Get the PR number
PR_NUMBER=$(gh pr list --head plugin-updates- --json number --jq '.[0].number')

# Check PR status
gh pr view $PR_NUMBER

# Check if auto-merge is enabled
gh pr view $PR_NUMBER --json mergeable,merged,state
```

**Expected**: PR has auto-merge enabled, merges after CI passes

## Phase 5: Cross-Platform Validation

### 5.1 Platform-Specific Tests

For each platform (Ubuntu, macOS, Windows):

1. **Config Load Test**
   - Check logs for "Config loaded successfully"
   - Verify no errors in config_load.log

2. **Plugin Install Test**
   - Check logs for "Plugin installation completed"
   - Verify no errors in plugin_install.log

3. **Health Check Test**
   - Check logs for health check output
   - Verify no critical issues in health_check.log

4. **LuaSnip Load Test**
   - Check logs for LuaSnip success
   - Verify no errors in luasnip_load.log

### 5.2 Validate Lock File Consistency

For plugin updates, verify lock files match across platforms:

```bash
# Download lock files from all platforms
gh run download <run-id> --pattern lock-*

# Compare files
diff lock-ubuntu-latest/lazy-lock.json lock-macos-latest/lazy-lock.json
diff lock-ubuntu-latest/lazy-lock.json lock-windows-latest/lazy-lock.json
```

**Expected**: No differences between platform lock files

## Phase 6: PR Testing

### 6.1 Create Test PR

```bash
# Create a test branch
git checkout -b test/ci-validation

# Make a small change
echo "-- Test comment" >> lua/config/options.lua

# Commit and push
git add lua/config/options.lua
git commit -m "test: validate CI on PR"
git push origin test/ci-validation

# Create PR
gh pr create --title "test: CI validation" --body "Testing CI workflows"
```

**Expected**: PR created, all workflows run automatically

### 6.2 Validate PR Checks

```bash
# Watch workflows run
gh run watch --interval 5

# Check PR status
gh pr view test/ci-validation

# Verify all checks pass
gh pr checks test/ci-validation
```

**Expected**: All CI checks pass on PR

### 6.3 Test PR Failure Notification

```bash
# Introduce a failure
echo "invalid syntax here" >> lua/config/options.lua
git add lua/config/options.lua
git commit -m "test: trigger failure"
git push origin test/ci-validation

# Check for PR comment
gh pr view test/ci-validation --json comments --jq '.comments[].body'
```

**Expected**: Failure notification comment appears on PR

### 6.4 Clean Up Test PR

```bash
# Close PR
gh pr close test/ci-validation

# Delete branch
git checkout master
git branch -D test/ci-validation
git push origin --delete test/ci-validation
```

## Phase 7: Performance Validation

### 7.1 Benchmark Test Workflow

Run the test workflow multiple times and measure duration:

```bash
# First run (cold cache)
time gh workflow run test-config.yml --ref master
gh run watch --interval 5

# Second run (warm cache)
time gh workflow run test-config.yml --ref master
gh run watch --interval 5

# Compare durations in GitHub Actions UI
```

**Expected**: Second run is faster due to caching

### 7.2 Verify Cache Hit Rate

Check workflow logs for cache hit/miss messages:

```bash
# Get run ID and view logs
RUN_ID=$(gh run list --workflow=test-config.yml --limit 1 --json databaseId --jq '.[0].databaseId')
gh run view $RUN_ID --log | grep -i cache
```

**Expected**: "Cache restored" message on subsequent runs

## Validation Checklist

After completing all phases, verify:

- [ ] All workflows run successfully on all platforms
- [ ] Config loads without errors on Ubuntu, macOS, Windows
- [ ] Plugin installation completes successfully
- [ ] Health checks pass on all platforms
- [ ] All 69 Lua files pass syntax validation
- [ ] LuaSnip snippets load correctly
- [ ] Format check passes
- [ ] Plugin update detects changes in dry-run mode
- [ ] Plugin update tests on all platforms
- [ ] Plugin update creates PR when not in dry-run
- [ ] Auto-merge works when all tests pass
- [ ] Caching improves performance on subsequent runs
- [ ] PR comments appear on test failures
- [ ] Artifacts are uploaded on failures
- [ ] Job summaries display correctly

## Troubleshooting

### Workflows Don't Trigger

**Issue**: Workflows don't run on push/PR

**Solution**:
- Check `.github/workflows/` files are committed and pushed
- Verify workflow `on:` triggers match your branch names
- Check GitHub Actions is enabled for repository

### Cache Not Working

**Issue**: Caching doesn't improve performance

**Solution**:
- Verify cache key is correct
- Check cache paths exist on all platforms
- Ensure `lazy-lock.json` changes invalidate cache appropriately

### Tests Fail Intermittently

**Issue**: Tests sometimes fail randomly

**Solution**:
- Check for network issues (plugin downloads)
- Verify race conditions aren't causing failures
- Increase timeout values if needed
- Download and inspect test artifacts

### PR Comments Don't Appear

**Issue**: No PR comment on test failure

**Solution**:
- Verify workflow has `pull-requests: write` permission
- Check `github-token` is available
- Ensure job runs only for PR events (`github.event_name == 'pull_request'`)

## Next Steps

After validation is complete:

1. **Enable workflow badges** in README.md
2. **Set up branch protection** to require CI checks
3. **Configure auto-merge** for plugin update PRs
4. **Schedule weekly reviews** of workflow runs
5. **Monitor performance** and optimize as needed

## Support

For issues or questions:
- Check `.github/TESTING.md` for detailed testing procedures
- Review workflow logs in GitHub Actions UI
- Consult plan document: `CI_CD_plan.log`