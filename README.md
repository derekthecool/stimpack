# Stimpack

This neovim configuration uses [lazyvim](https://www.lazyvim.org/)!
Before using lazyvim I had a great time with my neovim configuration. However, I
could never get my startup time below several seconds and my LSP integration
was not great.

Lazyvim handles both of those so much better with amazing LSP setup and
startup time values of:

- Windows -> 200ms
- Linux -> 20ms

## LazyVim Requirements

- Neovim >= 0.11.2
- Git >= 2.19.0
- A Nerd Font
- tree-sitter-cli and C compiler for treesitter
- curl
- Terminal emulator that supports true color and undercurl e.g. wezterm

Most of these I always already have installed anyway

```sh
# Arch Linux
sudo pacman -S tree-sitter-cli

# Ubuntu Linux
sudo apt install tree-sitter-cli

# Cargo
cargo install --locked tree-sitter-cli

# Scoop is does not have a package as of April 2026

# Winget
winget install --exact tree-sitter-cli

# Possibly using Mason using MasonInstall tree-sitter-cli
```

## CI/CD

This configuration uses GitHub Actions for automated testing and maintenance:

### Automated Testing

- **Cross-platform testing**: Validates config works on Ubuntu, Windows, and macOS
- **Plugin validation**: Ensures all plugins install correctly
- **Health checks**: Runs `:checkhealth lazy` on all platforms
- **Snippet testing**: Validates LuaSnip snippets load without errors
- **Format checking**: Ensures Lua code is formatted with stylua

Tests run automatically on every push and pull request.

### Automated Plugin Updates

- **Weekly checks**: Every Sunday at 9 AM UTC
- **Cross-platform validation**: Updates tested on all platforms before creating PR
- **Auto-merge**: PRs merge automatically when all tests pass
- **Safety first**: Dry-run mode available for testing

### Local Testing

Test the config locally before pushing:

```powershell
# Run all tests
pwsh .github/scripts/test-config.ps1

# With health checks and verbose output
pwsh .github/scripts/test-config.ps1 -HealthCheck -Verbose
```

### Monitor Workflows

```bash
# Watch workflow runs
gh run watch

# View test results
gh run view <run-id>

# Download test artifacts
gh run download <run-id>
```

See [`.github/TESTING.md`](.github/TESTING.md) for detailed testing documentation.
