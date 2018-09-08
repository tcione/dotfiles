#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")"
git pull origin master
function doIt() {
  mkdir -p .tmux/plugins

  if [ ! -d "./.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm
  fi

  cd .tmux/plugins/tpm && git pull origin master
  cd ../../../

  rsync --exclude ".git/" \
    --exclude ".DS_Store" \
    --exclude "bootstrap.sh" \
    --exclude "README.md" \
    --exclude "Brewfile" \
    --exclude "Caskfile" \
    --exclude ".osx" \
    --exclude "ubuntu-deps.sh" \
    --exclude "arch-deps.sh" \
    --exclude "LICENSE-MIT.txt" \
    -av --no-perms . ~

  echo "Please open another terminal window and close this one"
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt
  fi
fi
unset doIt
