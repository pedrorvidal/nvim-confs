# Repository Guidelines

## Project Structure & Module Organization
`init.lua` bootstraps LazyVim and delegates setup to modules under `lua/`. Shared editor behavior lives in `lua/config/` (options, keymaps, autocmds, lazy config); add new core tweaks there rather than inside plugin specs. Plugin definitions reside in `lua/plugins/` using one file per plugin; return the Lazy spec table and keep helpers local to the file. Update lockfiles (`lazy-lock.json`, `lazyvim.json`) only via Lazy commands so plugin versions stay reproducible.

## Build, Test, and Development Commands
Use `nvim --headless "+Lazy sync" +qa` after introducing plugins or adjusting specs to install dependencies. Run `nvim --headless "+Lazy check" +qa` to surface missing binaries and plugin errors before review. Format Lua code with `stylua lua` (configured in `stylua.toml`) to apply the shared style. When debugging, launch `nvim` interactively and inspect `:messages` or `:Lazy log` to confirm modules load.

## Coding Style & Naming Conventions
Stylua enforces spaces with two-space indentation and a 120-column limit; avoid manual tabs. Name modules in lowercase without hyphens (e.g., `python.lua`, `treesitter.lua`) and keep exported tables aligned with the plugin they configure. Group keymaps by leader prefix (`<leader>c` for code, `<leader>g` for git) and document non-obvious bindings with concise comments.

## Testing Guidelines
No automated test suite exists, so rely on headless Lazy checks plus targeted manual validation. After changes, open representative filetypes (`:edit test.py`, `:edit index.blade.php`) and run `:checkhealth` or plugin-specific health checks. Capture any regressions with minimal reproduction steps and include relevant `:Lazy log` excerpts in review.

## Commit & Pull Request Guidelines
Mirror the repository history: write short, present-tense commit subjects (`add typescript autoimport`, `fix cwd autocmd`) and split unrelated changes, especially lockfile bumps. Summaries should mention the module touched (`lua/plugins/telescope.lua`) and why the change matters. Pull requests need a brief rationale, a list of validation commands run, and screenshots when UI or theme output shifts. Reference issues or TODOs when available so future contributors can trace the context.

## Security & Configuration Tips
Avoid committing machine-specific secrets; prefer local overrides in `~/.config/nvim/lua/custom/` ignored by git. Audit new plugins for lazy-loading hints to keep startup fast, and document any non-default binaries they require. When bumping versions, scan changelogs for breaking changes and note follow-up tasks in the PR if additional configuration is needed.
