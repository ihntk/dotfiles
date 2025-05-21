# source "$ZDOTDIR/.antidote/antidote.zsh"
# antidote load

export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE=$ZDOTDIR/.zsh_history

if [ ! -d "$ZDOTDIR/zshrc.d" ]; then
  mkdir -p "$ZDOTDIR/zshrc.d"
fi

if find "$ZDOTDIR/zshrc.d" -mindepth 1 | read; then
    for src in $ZDOTDIR/zshrc.d/*.zsh; do
    source "$src"
    done
    for src in $ZDOTDIR/zshrc.d/*/*.zsh; do
    zsh-defer source "$src"
    done
fi

autoload -U compinit && compinit
grmlcomp
