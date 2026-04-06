# AGENTS.md

Notes for anyone (or any agent) changing this **dotfiles** repo: conventions we rely on and things that took a while to get right.

## Cursor (Glass / 3.x)

- **User settings and keybindings** still live in JSON, even when the Glass UI hides the old “Terminal → Integrated” tree. Edit via **Cmd+Shift+P → “Preferences: Open User Settings (JSON)”** or the files under `~/Library/Application Support/Cursor/User/`. This repo symlinks **`cursor-settings.json`** and **`cursor-keybindings.json`** there from the **`Makefile`** `sync` target.
- **Custom keybindings for the Agent / Composer must use Glass command IDs**, not only legacy VS Code commands. In diagnostics, entries may show a `g.exec.*` label; the real IDs are the **`glass.*`** strings (e.g. **`glass.focusInput`** to focus the agent prompt, **`glass.focusInTerminal`** to focus the terminal). **`composer.focusComposer`** and **`workbench.action.focusAuxiliaryBar`** were unreliable inside Glass compared to those.
- **Order and `when` clauses matter.** For **Cmd+H**, we use **`editorTextFocus`** (not bare **`editorFocus`**) for “focus sidebar” so a **terminal-as-editor-tab** does not steal the chord. Composer / auxiliary-bar rules are listed **before** the generic editor rule so the Composer prompt does not get treated as “editor text only.”
- **Integrated terminal + Fish:** match Ghostty-style behavior by defining an explicit **`terminal.integrated.profiles.osx`** entry for **`fish`** with **`args": ["-l"]`** (login shell), a concrete **`path`** to the binary (e.g. **`/opt/homebrew/bin/fish`** on Apple Silicon; use **`/usr/local/bin/fish`** on Intel Homebrew if needed), plus **`terminal.integrated.inheritEnv": true`**. Without **`-l`**, Fish could start with a different environment than in Ghostty.

## Neovim

- Config is a single **`init.lua`** (symlinked to **`~/.config/nvim/init.lua`**). Plugins are declared with **`vim.pack.add({ ... })`** — Neovim **0.12**’s **built-in** package manager (**`vim.pack`**, also documented as the native plugin workflow in the 0.12 release). This repo does **not** use **lazy.nvim** or **packer.nvim**; do not assume those APIs.
- For upstream details, see the official docs: [Neovim 0.12 news](https://neovim.io/doc/user/news-0.12.html) and [`:help pack`](https://neovim.io/doc/user/pack.html). There is also a practical overview in [A Guide to vim.pack (Neovim built-in plugin manager)](https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack) (Evgeni Chasnovski).

## Repo layout (high level)

- **`Makefile` `sync`**: creates expected dirs and symlinks **fish**, **nvim**, **ghostty**, **tmux**, **Cursor** user JSON, etc. Run **`make sync`** on a new machine before expecting links to exist.
- **Fish**: **`config.fish`** and **`fish/functions/`** are symlinked into **`~/.config/fish/`**.
- **Ghostty**: config symlinked to **`~/.config/ghostty/config`** from **`ghostty.config`**.
