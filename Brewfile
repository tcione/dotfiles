# Install command-line tools using Homebrew
# Usage: `sh Brewfile`

brew tap caskroom/versions
brew tap homebrew/homebrew-php

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
# Install some other useful utilities like `sponge`
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils
# Install Bash 4
brew install bash
brew install zsh

# Install wget with IRI support
brew install wget --enable-iri

# Install more recent versions of some OS X tools
brew install vim --override-system-vi
brew install grep

# Install other useful binaries
brew install ack
brew install pv
brew install imagemagick --with-webp
brew install node
brew install pigz
brew install rename
brew install tree
brew install webkit2png
brew install zopfli
brew install p7zip
brew install tmux
brew install yarn
brew install gnupg
brew install cmake
brew install the_silver_searcher
brew install fd

brew install mariadb
brew install mongodb
brew install gpg

# Remove outdated versions from the cellar
brew cleanup
