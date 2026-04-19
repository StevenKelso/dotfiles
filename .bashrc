# source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# user specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# history
HISTCONTROL=ignorespace:ignoredups
HISTSIZE=1000
HISTFILESIZE=2000

# no highlight on paste
bind 'set enable-bracketed-paste off'

# exports
export TERM='xterm-256color'
export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
export PATH="$PATH:$HOME/.config/.foundry/bin"
export GOPATH=$HOME/.local/share/go
export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude '{.git,.local,.cache,.mozilla,.cargo,.npm,.vscode-oss}'"
export FZF_DEFAULT_OPTS="--height 50% --border --list-border --input-border --preview 'bat --color=always {}'"

# starship
eval "$(starship init bash)"

# fzf
eval "$(fzf --bash)"

# aliases
# ls / eza
alias ls="eza"
alias ll="eza -lh"
alias la="eza -lah"
alias lst="eza -lhTL1 --icons --git"
alias lst1="eza -lhTL2 --icons --git"
alias lst2="eza -lhTL3 --icons --git"
alias lsta="eza -lahTL1 --icons --git"
alias lsta1="eza -lahTL2 --icons --git"
alias lsta2="eza -lahTL3 --icons --git"
alias lstag="eza -lahTL1 --icons --git --git-ignore"
alias lstag1="eza -lahTL2 --icons --git --git-ignore"
alias lstag2="eza -lahTL3 --icons --git --git-ignore"
# convenience
alias bashrc="nvim $HOME/.bashrc"
alias dots="cd $HOME/github/stevenkelso/dotfiles"
alias tldr="tldr --short-options"
alias diff="diff --color=auto"
# hyprland
alias ewaybar="hyprctl dispatch exec waybar"
alias rwaybar="killall waybar && hyprctl dispatch exec waybar"
alias ehyprpaper="hyprctl dispatch exec hyprpaper"
alias rhyprpaper="killall hyprpaper && hyprctl dispatch exec hyprpaper"
alias rdunst="pkill -HUP dunst"

# fuzzy cd
fcd() {
    local dir
    dir=$(fd --type d \
        --hidden \
        --exclude .git \
        --exclude .local \
        --exclude .cache \
        --exclude .mozilla \
        --exclude .cargo \
        --exclude .npm \
        --exclude .vscode-oss \
        "" "$HOME" | fzf --preview 'eza -la --icons --git --color=always {}') || return
    cd "$dir"
}
