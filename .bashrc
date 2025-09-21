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
alias lst="eza -TL1"
alias lst1="eza -TL2"
alias lst2="eza -TL3"
alias lst3="eza -TL4"
alias lsta="eza -aTL1"
alias lsta1="eza -aTL2"
alias lsta2="eza -aTL3"
alias lsta3="eza -aTL4"

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
