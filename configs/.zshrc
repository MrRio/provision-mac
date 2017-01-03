export ZSH=/Users/`whoami`/.oh-my-zsh
export CDPATH=~/Code:~/Code/expose/current:.
ZSH_THEME="sorin"
source $ZSH/oh-my-zsh.sh

# Set the title
ZSH_THEME_TERM_TITLE_IDLE=%~

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='atom --wait'
fi

# Example aliases
alias zshconfig="atom ~/.zshrc"
alias ohmyzsh="atom ~/.oh-my-zsh"

export PATH="$HOME/.bin:$HOME/.composer/vendor/bin:$PATH"
