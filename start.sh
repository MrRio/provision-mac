# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install Cask and GUI apps
brew tap caskroom/cask
brew cask install atom google-chrome slack
brew cask install hipchat sublime-text phpstorm firefox sequel-pro iterm2 hyper
brew cask install virtualbox github-desktop paw ksdiff spotify

# Fluid App (for making web apps into apps)
brew cask install fluid

# Install App Store Apps
brew install mas
mas signin `cat appstore-creds`

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
cp ~/Code/provision-mac/configs/.hyper.js ~/.hyper.js

# Composer
curl -sS https://getcomposer.org/installer | php

mkdir -p ~/.bin
mv composer.phar ~/.bin/composer

# Install valet and configure that
composer global require laravel/valet

valet install

# Add valet to ~/Code
# Setup code directories
mkdir ~/Code
cd ~/Code
valet park

~/.composer/vendor/laravel/installer/laravel new example
cd example
valet secure
valet open

apm install atom-ternjs base16-tomorrow-night-eighties-syntax count-word \
    docblockr editorconfig hyperclick intentions language-blade \
    language-powershell linter linter-js-standard linter-php linter-phpcs \
    minimap no-title-bar nucleus-dark-ui php-cs-fixer \
    php-integrator-annotations php-integrator-autocomplete-plus \
    php-integrator-base php-integrator-call-tips php-integrator-linter \
    php-integrator-navigation php-integrator-refactoring \
    php-integrator-tooltips project-manager seti-ui \
    standard-formatter standardjs-snippets sync-settings unity-dark-ui unity-ui

echo "{
    title: \"Example\"
    paths: [
        \"/Users/`whoami`/Code/example\"
    ]
    devMode: true
}" > project.cson
atom .
echo "To use PHP Integrator, go to Packages > Project Manager > Save Project

Then go to Packages > PHP Integrator > Set Up Current Project
" > setup.md
atom setup.md

# Open Hyper.app
open -b co.zeit.hyper --args "cd ~/Code/example"
