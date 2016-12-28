# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install Cask and GUI apps
brew tap caskroom/cask
brew cask install atom google-chrome slack
brew cask install hipchat sublime-text phpstorm firefox sequel-pro iterm2 hyper
brew cask install virtualbox github-desktop paw ksdiff

# Install App Store Apps
brew install mas
# 1Password
mas install 443987910
# Pages
mas install 409201541
# Numbers
mas install 409203825
# Keynote
mas install 409183694
# Xcode
mas install 497799835
# BetterSnapTool
mas install 417375580
# Transmit
mas install 403388562
# Integrity
mas install 513610341
# Kaleidoscope
mas install 587512244

# Install PHP71
brew tap homebrew/php
brew install homebrew/php/php71 homebrew/php/php71-mcrypt mysql

# Setup code directories
mkdir ~/Code
cd ~/Code

# Install valet and configure that
# TODO: Add valet here
valet park
