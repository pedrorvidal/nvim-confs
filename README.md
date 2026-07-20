# nvim-confs

Personal Neovim config, built on [LazyVim](https://github.com/LazyVim/LazyVim), tailored for
**PHP/Laravel** and **React/Next.js** development. Works on WSL (Ubuntu) and native Linux —
clipboard, Mason binaries, and Treesitter parsers all auto-detect per platform, no manual switches.

## Prerequisites

Install before first launch: `neovim` (>=0.10), `git`, `make`, `gcc`, `unzip`, `ripgrep`, `fd-find`,
`node`/`npm`, `php` (>=8.2), `composer`, `lazygit`, and a global `tree-sitter` CLI
(`npm install -g tree-sitter-cli`).

Clipboard: WSL needs `win32yank.exe` on `PATH`; native Linux needs `xclip`/`xsel` (X11) or
`wl-clipboard` (Wayland).

## Stack

| Area | Tooling |
|---|---|
| PHP | Intelephense (LSP), Pint → php-cs-fixer fallback (format), PHPStan (lint, only if project has it) |
| Blade | `.blade.php` recognized as `blade`, Intelephense + Emmet attached, dedicated Treesitter parser |
| JS/TS/React/Next | vtsls (LSP), Prettier (format), ESLint (lint) |
| CSS/Tailwind | `cssls`, `tailwindcss` LSP |
| HTML/Emmet | `html` LSP, `emmet_language_server` on html/blade/php/css/jsx/tsx |
| Docker/YAML/JSON/Bash | `dockerls`, `docker_compose_language_service`, `yamlls`, `jsonls`, `bashls` |
| Surround | `mini.surround` |
| Navigation | `flash.nvim`, `harpoon2` |
| Search & replace | `grug-far.nvim` |
| Git | Snacks pickers (`git status`, `git diff`, ...) + `lazygit` |

## Shortcuts

### Emmet
Type the abbreviation (e.g. `div.container>ul>li*3`), then expand it like any other completion:
- If the popup isn't already showing: `<C-space>` to open it
- `<CR>` to accept/expand

No special trigger key — it's just an LSP completion source (`emmet_language_server`), active on
`html`, `blade`, `php`, `css`, `javascriptreact`, `typescriptreact`.

### Surround (add / delete / change)
`mini.surround` uses `gs`-prefixed keys (not vim-surround's `ys`/`ds`/`cs`):

| Action | Keys | Example |
|---|---|---|
| Add | `gsa` + motion/textobject + char | `gsaiw"` → `word` becomes `"word"` |
| Add (visual) | select text, then `gsa` + char | select `hello`, `gsa"` → `"hello"` |
| Delete | `gsd` + current char | `gsd"` on `"hello"` → `hello` |
| Change | `gsr` + old char + new char | `gsr'"` on `'hello'` → `"hello"` |
| Change tag | `gsrtt` | retype a JSX/Blade tag name |

### Search and replace across the project
`<leader>sr` opens `grug-far.nvim` — a live, editable buffer (search / replace / files filter),
pre-scoped to the current file's extension. Clear the `Files:` field for a project-wide sweep.
Supports regex (ripgrep syntax).

For renaming an actual code symbol (not just text), use `<leader>cr` (LSP rename) instead —
it's semantic and won't touch unrelated matches.

### Search a string in the entire project
- `<leader>sg` (or `<leader>/`) — live grep across the whole project (root dir)
- `<leader>sG` — same, but scoped to cwd instead of root
- `<leader>sw` — grep the word under cursor / current visual selection (root dir)

### Lazygit
`<leader>gg` — opens `lazygit` in a floating terminal at the project root (requires the `lazygit`
binary on `PATH`, not just a plugin). `<leader>gG` opens it at the current `cwd` instead.

### Other useful ones
| Keys | Action |
|---|---|
| `jj` (insert mode) | Exit to normal mode |
| `s` / `S` | Flash jump / Flash Treesitter jump |
| `<leader>H` | Harpoon: mark current file |
| `<leader>h` | Harpoon: quick menu |
| `<leader>1`–`<leader>9` | Harpoon: jump to marked file N |
| `<leader>ft` / `<c-/>` | Floating terminal at project root (e.g. `php artisan serve`, `npm run dev`) |
