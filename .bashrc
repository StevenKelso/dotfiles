# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# aliases
alias ls="eza"

# adding golang to the path
export PATH=$PATH:$HOME/go/bin

# set neovim as the default text editor
export EDITOR='nvim'
export VISUAL='nvim'

# set prompt
PS1="[\u@\H \w]\$ "
