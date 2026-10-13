# CI

- `format.yml` — `stylua --check lua/` (run `stylua lua/` to fix).
- `test-config.yml` — loads the config headless on Ubuntu and Windows, syntax-checks all Lua, loads LuaSnip snippets.
  Run locally: `nvim --headless '+Lazy! restore' '+luafile .github/scripts/ci-check.lua' +qa`.
- `plugin-updates.yml` — weekly `Lazy! update`; opens a PR if `lazy-lock.json` changed and checks pass.
- `dependabot.yml` — weekly GitHub Actions version bumps.
