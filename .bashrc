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
HISTCONTROL=ignorespace
HISTCONTROL=ignoredups
HISTSIZE=1000
HISTFILESIZE=2000

# no highlight on paste
bind 'set enable-bracketed-paste off'

# neovim
export EDITOR='nvim'
export VISUAL='nvim'

# starship
eval "$(starship init bash)"

# ls / eza
alias ls="eza"
alias ll="eza -la"
alias lst="eza -lhTL1 --icons --git"
alias lst1="eza -lhTL2 --icons --git"
alias lst2="eza -lhTL3 --icons --git"
alias lst3="eza -lhTL4 --icons --git"
alias lsta="eza -alhTL1 --icons --git"
alias lsta1="eza -alhTL2 --icons --git"
alias lsta2="eza -alhTL3 --icons --git"
alias lsta3="eza -alhTL4 --icons --git"

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

# fzf into nvim
alias fzn='nvim $(fzf -m)'

# icat
alias icat="kitty +kitten icat"

# convenience
alias bashrc="nvim $HOME/.bashrc"
alias tldr="tldr --short-options"

# hyprland
alias ewaybar="hyprctl dispatch exec waybar"
alias rwaybar="killall waybar && hyprctl dispatch exec waybar"
alias ehyprpaper="hyprctl dispatch exec hyprpaper"
alias rhyprpaper="killall hyprpaper && hyprctl dispatch exec hyprpaper"
