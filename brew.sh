#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
  echo "Homebrew is already installed...";
fi

# Tap
brew tap homebrew/versions
brew tap homebrew/dupes

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Wait a bit before moving on...
sleep 1

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install Bash 4.
brew install bash
brew tap homebrew/versions
brew install bash-completion2
# We installed the new shell, now we have to activate it
echo "Adding the newly installed shell to the list of allowed shells"
# Prompts for password
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'

# Install zsh.
brew install zsh
brew tap homebrew/versions
brew install zsh-completions
brew install zsh-syntax-highlighting
# We installed the new shell, now we have to activate it
echo "Adding the newly installed shell to the list of allowed shells"
# Prompts for password
sudo bash -c 'echo /usr/local/bin/zsh >> /etc/shells'
# iTerm2 Shell Intergration
curl -L https://iterm2.com/shell_integration/zsh \
-o ~/.iterm2_shell_integration.zsh
# Install oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/
# Change to the new shell, prompts for password
chsh -s /usr/local/bin/zsh

# Install `wget` with IRI support.
brew install wget --with-iri

# Install Python
brew install python

# Install rbenv and ruby-build
brew install rbenv
# Add rbenv to bash so that it loads every time you open a terminal
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.zshrc
source ~/.zshrc

LINE='eval "$(rbenv init -)"'
grep -q "$LINE" ~/.extra || echo "$LINE" >> ~/.extra

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh

# Install other useful binaries.
brew install curl
brew install autojump
brew install bat
brew install exa
brew install ffmpeg
brew install git
brew install git-extras
brew install htop
brew install mas
brew install mackup
brew install tldr
brew install tmux
brew install tree
brew install yarn
brew install youtube-dl

# Wait a bit before moving on...
sleep 1

# Install nvm and node
if ! test [ $(command -v nvm) = "nvm" ]; then

  echo "Installing nvm..."
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

  echo "Installing node..."
  nvm install node # "node" is an alias for the latest version

  else
  echo "Homebrew is already installed...";
fi

# Wait a bit before moving on...
sleep 1

# Cask
brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/drivers
brew tap caskroom/fonts
brew tap caskroom/versions
brew tap homebrew/bundle

# Install cask packages
brew cask install --appdir="/Applications" vlc
brew cask install --appdir="/Applications" flux
brew cask install --appdir="/Applications" iina
brew cask install --appdir="~/Applications" lepton
brew cask install --appdir="~/Applications" rocket
brew cask install --appdir="~/Applications" skype
brew cask install --appdir="~/Applications" spotify
brew cask install --appdir="~/Applications" skim
brew cask install --appdir="~/Applications" imageoptim
brew cask install --appdir="~/Applications" figma
brew cask install --appdir="~/Applications" bitwarden
brew cask install --appdir="~/Applications" the-unarchiver
brew cask install --appdir="~/Applications" notion
brew cask install --appdir="~/Applications" dynalist
brew cask install --appdir="~/Applications" skitch
brew cask install --appdir="~/Applications" itsycal
brew cask install --appdir="~/Applications" kap
brew cask install --appdir="~/Applications" appcleaner
brew cask install --appdir="~/Applications" qbittorrent
brew cask install --appdir="~/Applications" whatsapp
brew cask install --appdir="~/Applications" github
brew cask install --appdir="~/Applications" iterm2
brew cask install --appdir="/Applications" firefox
brew cask install --appdir="/Applications" dropbox
brew cask install --appdir="/Applications" postman
brew cask install --appdir="/Applications" handbrake
brew cask install --appdir="/Applications" google-chrome
brew cask install --appdir="/Applications" caskroom/versions/firefox-developer-edition
brew cask install --appdir="/Applications" caskroom/versions/google-chrome-canary

# Install developer friendly quick look plugins; see https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzip qlimagesize webpquicklook suspicious-package quicklookase qlvideo

# Mac App Store
mas install 1278508951 # Trello

# Fonts
brew tap homebrew/cask-fonts
brew cask install font-office-code-pro
brew cask install font-source-code-pro
brew cask install font-ibm-plex
brew cask install font-fira-code
brew cask install font-fira-sans
brew cask install font-fira-mono
brew cask install font-clear-sans
brew cask install font-work-sans
brew cask install font-hack
brew cask install font-input
brew cask install font-inter

# Remove outdated versions from the cellar.
brew cleanup

# Wait a bit before moving on...
sleep 1

# ...and then.
echo "Success! Brew additional applications are installed."
