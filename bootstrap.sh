#!/usr/bin/env bash

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
RUN_BOOTSTRAP="0"
NEEDS_CONFIRMATION="1"
INITIAL_RUN="0"

print_usage () {
  echo "Usage: $0 [OPTIONS] TARGET <COMMAND...>"
  echo
  echo "Configure or udaptes your env :)"
  echo
  echo "Options:"
  echo "  -i, --initial                 Run initial setup scripts (i.e. install homebrew deps)"
  echo "  -y, --no-confirm              Skip confirmation"
  echo "  -h, --help                    Print this usage information"
}

# Arguments
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    -y|--no-confirm)
    NEEDS_CONFIRMATION="0"
    shift # past argument
    ;;
    -i|--initial)
    INITIAL_RUN="1"
    shift
    ;;
    -h|--help)
    print_usage
    exit 0
    ;;
    *)    # unknown option
    POSITIONAL+=("$1")
    shift
    ;;
esac
done

resetDir() {
  cd "$DIR"
}

installTmuxTpm() {
  mkdir -p "$HOME/.tmux/plugins"

  if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  else
    cd "$HOME/.tmux/plugins/tpm" && git pull origin master
  fi

  resetDir
}

installZshAntigen() {
  mkdir -p "$HOME/.config/zsh/"
  curl -L git.io/antigen > "$HOME/.config/zsh/antigen.zsh"
  resetDir
}

moveFilesHome() {
  resetDir

  rsync --exclude ".git/" \
    --exclude ".DS_Store" \
    --exclude "bootstrap.sh" \
    --exclude "README.md" \
    --exclude "Brewfile" \
    --exclude ".osx" \
    --exclude ".tmux/" \
    --exclude ".tmux" \
    --exclude "kitty.conf" \
    --exclude "startship.toml" \
    --exclude ".exports_local.sample" \
    --exclude ".gitconfig_local.sample" \
    --exclude "LICENSE-MIT.txt" \
    -av --no-perms . ~
}

copyConfigFolderFiles() {
  mkdir -p "$HOME/.config/kitty"
  cp "$DIR/kitty.conf" "$HOME/.config/kitty"
  cp "$DIR/startship.toml" "$HOME/.config/starship.toml"
}

doIt() {
  echo "Configuring/updating env..."

  git pull origin master
  installTmuxTpm
  installZshAntigen
  copyConfigFolderFiles
  moveFilesHome
  echo "Please open another terminal window and close this one"
}

osxInitialSetup() {
  xcode-select --install

  # Install homebrew
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  # Install Brewfile packages
  brew bundle

  # Setup osx configs
  bash -c "$DIR/.osx"
}

loadPrivateExports() {
  PRIVATE_EXPORTS="$DIR/.exports_local"
  if [ ! -f "$PRIVATE_EXPORTS" ] || [ ! -r "$PRIVATE_EXPORTS" ]; then
    echo "*** cannot read ./.exports_local. Please, make sure it exists and is readable."
    exit 1
  fi

  source "$PRIVATE_EXPORTS"
}

checkGitconfigLocal() {
  GITCONFIG_LOCAL="$DIR/.exports_local"
  if [ ! -f "$GITCONFIG_LOCAL" ] || [ ! -r "$GITCONFIG_LOCAL" ]; then
    echo "*** cannot read ./.gitconfig_local. Please, make sure it exists and is readable."
    exit 1
  fi
}

initialSetup() {
  echo "Running initial setup..."

  resetDir
  loadPrivateExports
  osxInitialSetup
  chsh -s "$(which zsh)"
}

resetEnvironment() {
  unset doIt
  unset moveFilesHome
  unset installTmuxTpm
  unset installZshAntigen
  unset loadPrivateExports
  unset osxInitialSetup
  unset initialSetup
  unset resetDir
}

if [ "$NEEDS_CONFIRMATION" == "1" ]; then
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    RUN_BOOTSTRAP="1"
  fi
elif [ "$NEEDS_CONFIRMATION" == "0" ]; then
  RUN_BOOTSTRAP="1"
fi

if [ ! "$RUN_BOOTSTRAP" == "1" ]; then
  echo "Nothing to do here"
  exit 0
fi

if [ "$INITIAL_RUN" == "1" ]; then
  initialSetup
fi

doIt

resetEnvironment && unset resetEnvironment
