# dotfiles

My configs for Arch Linux (KDE Plasma) and macOS. The install scripts symlink files from this repo into `$HOME`, so editing either side edits both.

## Layout

```
common/   shared by both machines: nvim, tmux, git, oh-my-posh theme, wallpaper
arch/     zsh, KDE/KWin/Konsole configs, Krohnkite tiling script
mac/      zsh, AeroSpace, DevPod, Terminal.app profile
```

## Install

### Arch

On a fresh install, run the bootstrap script. Only bash is guaranteed to exist at that point; the script installs `git`, `zsh` and `curl`, runs the zsh installer, and sets zsh as your login shell.

```sh
git clone git@github.com:theGusPassos/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap-arch.sh
```

If zsh is already installed, run `zsh ./install-arch.zsh` to only create the symlinks.

### macOS

```sh
cd ~/dotfiles
zsh ./install-mac.zsh
```

Run both install scripts **from the repo root**: they use `$(pwd)` as the source path.

## What the install scripts do

1. Install Oh My Zsh if `~/.oh-my-zsh` is missing.
2. Symlink each config into place. If a real file is already at the target, it is moved to `<file>.<timestamp>`. If an old symlink is there, it is replaced.

| Source | Target | Arch | Mac |
| --- | --- | :-: | :-: |
| `common/nvim` | `~/.config/nvim` | ✓ | ✓ |
| `common/.tmux.conf` | `~/.tmux.conf` | ✓ | ✓ |
| `common/.gitconfig` | `~/.gitconfig` | ✓ | |
| `arch/.zshrc` | `~/.zshrc` | ✓ | |
| `arch/.config/*` (every file) | `~/.config/` | ✓ | |
| `arch/.local/share/konsole` | `~/.local/share/konsole` | ✓ | |
| `arch/.local/share/kwin/scripts/krohnkite` | `~/.local/share/kwin/scripts/krohnkite` | ✓ | |
| `mac/.zshrc` | `~/.zshrc` | | ✓ |
| `mac/.aerospace.toml` | `~/.aerospace.toml` | | ✓ |
| `mac/.devpod/personal.devpod.yaml` | `~/.devpod/personal.devpod.yaml` | | ✓ |

These are not linked automatically and have to be applied by hand:
- the oh-my-posh theme
- the wallpaper
- `mac/.terminal-settings.plist`

