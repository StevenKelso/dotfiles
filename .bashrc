# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# ---- history ----
HISTCONTROL=ignorespace
HISTCONTROL=ignoredups
HISTSIZE=1000
HISTFILESIZE=2000

# ---- golang ----
export PATH=$PATH:$HOME/go/bin

# ---- neovim ----
export EDITOR='nvim'
export VISUAL='nvim'

# ---- starship ----
eval "$(starship init bash)"

# ---- eza ----
alias ls="eza"
alias ll="eza -la"
alias lst="eza -TL2"
alias lsta="eza -aTL2"

# ---- bat ----
alias cat="bat"

# ---- fzf ----
eval "$(fzf --bash)"
export FZF_DEFAULT_OPTS='--height 50% --border'
alias fzf='fzf --preview="bat --color=always {}"'
alias fzn='nvim $(fzf --preview="bat --color=always {}")'

# ---- convenience ----
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias bashrc="nvim ~/.bashrc"
