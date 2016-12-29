# Install Xcode command line tools.
xcode-select --install

# Temp fix for perms issue
# This needs to not be world writeable
mkdir ~/.composer
mkdir ~/Code
chmod 0777 ~/.composer
chmod 0777 ~/Code

# Setup Git.
read -e -p "Enter your git username: " USERNAME
read -e -p "Enter your git email address: " EMAIL
git config --global user.name $USERNAME
git config --global user.email $EMAIL
ssh-keygen -t rsa -b 4096 -C $EMAIL
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
pbcopy < ~/.ssh/id_rsa.pub

# App Store
echo "If you get this wrong you'll need to rerun the script"
read -e -p "Enter your App Store email: " APP_STORE_EMAIL
read -e -p "Enter your App Store password: " APP_STORE_PASSWORD

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

read -e -p "Press enter to continue"

# Authenticate App Store
brew install mas
mas signin $APP_STORE_EMAIL $APP_STORE_PASSWORD

# Install PHP71 and MySQL
brew tap homebrew/php
brew install homebrew/php/php71 homebrew/php/php71-mcrypt mysql

# Start MySQL on boot
brew services start mysql

# Install node
brew install node

# Yarn
brew install yarn
#npm install yarn -g

# Parallax backgrounds
# TODO

# Copy configs
# Hyper
cp ~/.hyper.js ~/.hyper.backup-`date +%Y-%m-%d-%H-%M-%S`.js
cp ./configs/.hyper.js ~/.hyper.js
cp ./configs/.zshrc ~/.zshrc

# Composer
brew install composer
mkdir -p ~/.bin

export PATH="$HOME/.bin:$HOME/.composer/vendor/bin:$PATH"

# Install valet and configure that
composer global require laravel/valet
composer global require "phpunit/phpunit=5.5.*"
composer global require "squizlabs/php_codesniffer=*"
composer global require friendsofphp/php-cs-fixer

valet install

# Add valet to ~/Code
# Setup code directories
mkdir ~/Code
cd ~/Code
valet park

# Install Laravel installer
composer global require "laravel/installer"
composer create-project laravel/laravel example
cd example
valet secure
valet open

# Install Cask and GUI apps
brew tap caskroom/cask

# Editors
brew cask install atom
brew cask install sublime-text
brew cask install phpstorm

# Install atom deps
apm install atom-ternjs base16-tomorrow-night-eighties-syntax count-word \
    docblockr editorconfig hyperclick intentions language-blade \
    language-powershell linter linter-js-standard linter-php linter-phpcs \
    minimap nucleus-dark-ui php-cs-fixer \
    php-integrator-annotations php-integrator-autocomplete-plus \
    php-integrator-base php-integrator-call-tips php-integrator-linter \
    php-integrator-navigation php-integrator-refactoring \
    php-integrator-tooltips project-manager seti-ui \
    standard-formatter standardjs-snippets unity-dark-ui unity-ui

# TODO Potentially controversial and doesn't work in VM, also needs CSS hack
apm install no-title-bar

# Fonts
brew tap caskroom/fonts
brew cask install font-meslo-lg-for-powerline

echo "{
    title: \"Example\"
    paths: [
        \"/Users/`whoami`/Code/example\"
    ]
    devMode: true
}" > project.cson
atom .
echo "To use PHP Integrator, go to Packages > Project Manager > Save Project and
enable dev mode.

Then go to Packages > PHP Integrator > Set Up Current Project
" > setup.md
atom setup.md

# Terminals
brew cask install iterm2
brew cask install hyper

# Browsers
brew cask install google-chrome
brew cask install firefox

# Chat
brew cask install hipchat
brew cask install slack
brew cask install skype

# Dev apps
brew cask install sequel-pro
brew cask install virtualbox
brew cask install github-desktop
brew cask install paw
brew cask install ksdiff
brew cask install genymotion
brew cask install sourcetree

# Music
brew cask install spotify

# Adobe Stuff
brew cask install adobe-photoshop-cc
brew cask install adobe-illustrator-cc

# Sketch
brew cask install sketch
brew cask install invisionsync

# Fluid App (for making web apps into apps)
brew cask install fluid

# Nicer plugins for QuickLook.
brew cask install qlcolorcode
brew cask install qlstephen
brew cask install qlmarkdown
brew cask install quicklook-json
brew cask install webpquicklook
brew cask install qlimagesize

# System stuff
brew install vim
brew install coreutils
brew install bash
brew install git
brew install nano
brew install vim
brew install openssh
brew install java
brew install python
curl -L https://get.rvm.io | bash -s stable --ruby

# Install App Store apps

# 1Password
mas install 443987910
# BetterSnapTool
mas install 417375580
# Boxy
mas install 1053031090
# Daisydisk
mas install 411643860
# Integrity
mas install 513610341
# Kaleidoscope
mas install 587512244
# Keynote
mas install 409183694
# Name Mangler
mas install 603637384
# Numbers
mas install 409203825
# Pages
mas install 409201541
# Patterns
mas install 429449079
# Sip
mas install 507257563
# Soulver
mas install 413965349
# Transmit
mas install 403388562
# Xcode
mas install 497799835

## Google Chrome extensions
mkdir -p ~/Library/Application\ Support/Google/Chrome/External\ Extensions
install_chrome_extension() {
    echo '{"external_update_url": "https://clients2.google.com/service/update2/crx"}' > ~/Library/Application\ Support/Google/Chrome/External\ Extensions/$1.json
}
# 1Password
install_chrome_extension 'aomjjhallfgjeglblehebfpbcfeobpgk'
# Capture for JIRA
install_chrome_extension 'mmmjimhmoodbiejkjgcecaoibmochpnj'
# Browserstack
install_chrome_extension 'nkihdmlheodkdfojglpcjjmioefjahjb'
# Clockwork
install_chrome_extension 'dmggabnehkmmfmdffgajcflpdjlnoemp'
# Hubspot
install_chrome_extension 'oiiaigjnkhngdbnoookogelabohpglmd'
# Vue.js devtools
install_chrome_extension 'nhdogjmejiglipccpnnnanhbledajbpd'

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "-------------------------------------"
echo "Your Git key is ready to be pasted!"
echo "Enjoy your new system!"
echo "-------------------------------------"

# Open Hyper.app
open -b co.zeit.hyper
