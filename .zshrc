echo '٩(˘◡˘)۶ ...'

source ~/.config/zsh/antigen.zsh
antigen bundle command-not-found
antigen bundle z
antigen bundle fzf
antigen bundle nvm
antigen bundle fancy-ctrl-z
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle chriskempson/base16-shell
antigen apply

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


# TODO: Remove this if I dont see any problems
# export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH" # Rust cargo
export PATH="$PATH:$HOME/.rvm/bin" # Ruby Version Manager
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# Android development stuff
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

echo 'おはよう ᕙ(`▿´)ᕗ'

