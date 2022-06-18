echo '٩(˘◡˘)۶ ...'

# Use vi bindkeys
bindkey -v

export NVM_LAZY_LOAD=true
source <(antibody init)
antibody bundle ohmyzsh/ohmyzsh path:plugins/command-not-found
antibody bundle ohmyzsh/ohmyzsh path:plugins/fzf
antibody bundle ohmyzsh/ohmyzsh path:plugins/fancy-ctrl-z
antibody bundle rupa/z
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle zsh-users/zsh-completions
antibody bundle chriskempson/base16-shell
# antibody bundle lukechilds/zsh-nvm

# Sensible defaults
setopt no_beep
setopt auto_cd
export HISTSIZE=10000
export SAVEHIST=10000
setopt append_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

# Simple calculator
# Taken from https://github.com/addyosmani/dotfiles/blob/master/.functions#L1-L17
function calc() {
  local result=""
  result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')"
  #                       └─ default (when `--mathlib` is used) is 20
  #
  if [[ "$result" == *.* ]]; then
    # improve the output for decimal numbers
    printf "$result" |
      sed -e 's/^\./0./'        `# add "0" for cases like ".5"` \
      -e 's/^-\./-0./'      `# add "0" for cases like "-.5"`\
      -e 's/0*$//;s/\.$//'   # remove trailing zeros
        else
          printf "$result"
  fi
  printf "\n"
}

zstyle ':completion:*' menu select

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

for file in ~/.{exports,aliases}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

export FZF_DEFAULT_COMMAND='fd --type f'

export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/opt/python@3.8/bin:$PATH"

. $(brew --prefix asdf)/libexec/asdf.sh

echo 'おはよう ᕙ(`▿´)ᕗ'

if [[ -z $TMUX ]]; then
  tmux-init
fi
