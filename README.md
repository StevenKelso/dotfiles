# dotfiles

## Table of Contents
- [Prerequisites](#prerequisites)
- [Installation](#installation)

## Prerequisites
- Git
- Stow
- Hyprland
- Hyprpaper
- Hyprlock
- Hyprshot
- Hyprsunset
- Waybar
- Rofi
- Kitty
- Neovim
- Ripgrep
- Fzf
- Eza
- Nerdfonts
- Bat
- Dunst
- Satty

## Installation
- Navigate to your home directory
```bash
cd ~
```

- Clone the repo and cd into it:
```bash
git clone https://github.com/StevenKelso/dotfiles
cd dotfiles/
```

- Use stow to automatically symlink the dotfiles to their proper place
```bash
stow .
```

## Post Installation
In order for this to work correctly after installation you need to reload/source the configs and/or start services:
```
# source .bashrc
source $HOME/.bashrc

# restart hyprland
hyprctl reload

# start waybar service
hyprctl dispatch exec waybar

# start hyprpaper service
hyprctl dispatch exec hyprpaper

# reload kitty, either start a new terminal or use this keybind:
Ctrl + Shift + F5
```

Alternatively you can simply restart the system to ensure everything is working correctly.
