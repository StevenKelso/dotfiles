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
alias lst2="eza -TL2"
alias lst3="eza -TL3"
alias lst4="eza -TL4"
alias lsta="eza -aTL1"
alias lsta2="eza -aTL2"
alias lsta3="eza -aTL3"
alias lsta4="eza -aTL4"

# fzf
eval "$(fzf --bash)"
export FZF_DEFAULT_OPTS='--height 50% --border'
alias fzf='fzf --preview="cat {}"'
alias fzn='nvim $(fzf -m --preview="cat {}")'

# convenience
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias bashrc="nvim ~/.bashrc"
alias rwaybar="killall waybar && hyprctl dispatch exec waybar"
alias rhyprpaper="killall hyprpaper && hyprctl dispatch exec hyprpaper"
