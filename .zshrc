echo '٩(˘◡˘)۶ ...'

export NVM_LAZY_LOAD=true
source <(antibody init)
antibody bundle ohmyzsh/ohmyzsh path:plugins/command-not-found
antibody bundle ohmyzsh/ohmyzsh path:plugins/fzf
antibody bundle lukechilds/zsh-nvm
antibody bundle ohmyzsh/ohmyzsh path:plugins/fancy-ctrl-z
antibody bundle rupa/z
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle zsh-users/zsh-completions
antibody bundle chriskempson/base16-shell

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

zstyle ':completion:*' menu select

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

for file in ~/.{exports_local,exports,aliases,functions,extra}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

export FZF_DEFAULT_COMMAND='fd --type f'

# TODO: Remove this if I dont see any problems
# export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH" # Rust cargo
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# Android development stuff
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin" # Ruby version manager

echo 'おはよう ᕙ(`▿´)ᕗ'
