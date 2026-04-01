# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
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

# neovim
export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"

# fixing kitty ssh issues
export TERM='xterm-256color'

# foundry
export PATH="$PATH:$HOME/.config/.foundry/bin"

# starship
eval "$(starship init bash)"

# ls / eza
alias ls="eza"
alias ll="eza -la"
lst() {
    local depth=$(( ${1:-0} + 1 ))
    local filepath=$2
    eza -lhTL"$depth" --icons --git $filepath
}
lsta() {
    local depth=$(( ${1:-0} + 1 ))
    local filepath=$2
    eza -alhTL"$depth" --icons --git $filepath
}
lstag() {
    local depth=$(( ${1:-0} + 1 ))
    local filepath=$2
    eza -alhTL"$depth" --icons --git --git-ignore $filepath
}

# fzf
eval "$(fzf --bash)"
export FZF_DEFAULT_COMMAND="fd --type f \
--hidden \
--exclude '{.git,.local,.cache,.mozilla}'"
export FZF_DEFAULT_OPTS="
--height 50%
--border
--list-border
--input-border
--preview 'bat --color=always {}'"

# fuzzy nvim
fvim() {
    local files
    files=$(fzf --preview 'bat --color=always {}') || return
    [ -n "$files" ] && nvim "$files"
}

# fuzzy cd
fcd() {
    local dir
    dir=$(fd --type d \
        --hidden \
        --exclude .git \
        --exclude .cache \
        --exclude .local \
        --exclude .mozilla \
        "" "$HOME" | fzf --preview 'eza -la --icons --git --color=always {}') || return
    cd "$dir"
}

# fuzzy grep
frg() {
    fzf --ansi \
        --phony \
        --prompt 'rg> ' \
        --delimiter ':' \
        --preview 'bat --color=always --style=numbers --highlight-line {2} {1}' \
        --bind 'change:reload:rg --hidden \
            --line-number \
            --no-heading \
            --color=always \
            --smart-case \
            --glob "!**/.git/**" \
            --glob "!**/.cache/**" \
            --glob "!**/.local/**" \
            --glob "!**/.mozilla/**" \
            --glob "!**/.bash_history" \
            {q} || true' \
        --bind 'enter:execute(
            file=$(cut -d: -f1 <<< {});
            line=$(cut -d: -f2 <<< {});
            ${EDITOR:-nvim} +"$line" "$file"
        )'
}

# convenience
alias bashrc="nvim $HOME/.bashrc"
alias dots="cd $HOME/github/stevenkelso/dotfiles"
alias tldr="tldr --short-options"

# hyprland
alias ewaybar="hyprctl dispatch exec waybar"
alias rwaybar="killall waybar && hyprctl dispatch exec waybar"
alias ehyprpaper="hyprctl dispatch exec hyprpaper"
alias rhyprpaper="killall hyprpaper && hyprctl dispatch exec hyprpaper"
alias rdunst="pkill -HUP dunst"
