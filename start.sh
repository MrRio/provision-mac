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

# Install PHP71
brew tap homebrew/php
brew install homebrew/php/php71 homebrew/php/php71-mcrypt mysql

# Install node
brew install node

# Yarn
npm install yarn -g

# Parallax backgrounds
# TODO

# Setup code directories
mkdir ~/Code
cd ~/Code

# Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar ~/.bin/composer

# Install valet and configure that

# TODO: Add valet here
valet park

apm install atom-ternjs base16-tomorrow-night-eighties-syntax count-word \
    docblockr editorconfig hyperclick intentions language-blade \
    language-powershell linter linter-js-standard linter-php linter-phpcs \
    minimap no-title-bar nucleus-dark-ui php-cs-fixer \
    php-integrator-annotations php-integrator-autocomplete-plus \
    php-integrator-base php-integrator-call-tips php-integrator-linter \
    php-integrator-navigation php-integrator-refactoring \
    php-integrator-tooltips project-manager seti-ui \
    standard-formatter standardjs-snippets sync-settings unity-dark-ui unity-ui
