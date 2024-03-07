#!/bin/bash
# Install Xcode command line tools.
sudo -K
sudo echo "Welcome"

read -p "Install optional apps (y/n)? " choice
case "$choice" in
  y|Y ) apps=1;;
  n|N ) apps=0;;
  * ) echo "Assuming no"; apps=0;
esac

xcode-select --install

mkdir -p ~/.composer
mkdir -p ~/Code

# App Store
echo "If you get this wrong you'll need to rerun the script"
read -e -p "Enter your App Store email: " APP_STORE_EMAIL
read -e -p "Enter your App Store password: " APP_STORE_PASSWORD

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

read -e -p "Press enter to continue"

# Authenticate App Store
brew install mas
mas signin $APP_STORE_EMAIL $APP_STORE_PASSWORD

# Install nvm (Node Version Manager)
echo "Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Load nvm and install latest node version
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

echo "Installing latest Node.js version..."
nvm install node

echo "Installing PHP..."
brew install php mysql

# Start MySQL on boot
brew services start mysql


# Yarn
brew install yarn
#npm install yarn -g

# Parallax backgrounds
# TODO

# Copy configs
# Hyper
cp ~/.hyper.js ~/.hyper.backup-`date +%Y-%m-%d-%H-%M-%S`.js
cp ./configs/.hyper.js ~/.hyper.js

# Composer
brew install composer
mkdir -p ~/.bin

export PATH="$HOME/.bin:$HOME/.composer/vendor/bin:$PATH"


mkdir ~/Code
cd ~/Code

# Install Cask and GUI apps
brew tap caskroom/cask

# Editors

if [ ! -d /Applications/Sublime\ Text.app ]; then
    brew install sublime-text
fi
if [ ! -d /Applications/Visual\ Studio\ Code.app ]; then
    brew install visual-studio-code
fi

echo "Restoring VSCode settings..."
cp ./configs/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
echo "VSCode settings restored from ./configs/vscode/settings.json"

echo "Restoring VSCode extensions..."
while read extension; do
  code --install-extension $extension
done < ./configs/vscode/extensions.txt
echo "VSCode extensions restored."


# Fonts
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-for-powerline

# Grammar and spellcheck
brew install grammarly-desktop

# Terminals
if [ ! -d /Applications/iTerm.app ]; then
    brew install iterm2;
fi

if [ ! -d /Applications/Hyper.app ]; then
    brew install hyper
fi

# Browsers
if [ ! -d /Applications/Google\ Chrome.app ]; then
    brew install google-chrome
fi

if [ $apps == 1 ]; then
    if [ ! -d /Applications/Firefox.app ]; then
        brew install firefox
    fi

    # Chat
    if [ ! -d /Applications/Slack.app ]; then
        brew install slack
    fi

    # Dev apps
    if [ ! -d /Applications/Sequel\ Pro.app ]; then
        brew install sequel-pro
    fi

    if [ ! -d /Applications/GitHub\ Desktop.app ]; then
        brew install github-desktop
    fi
    if [ ! -d /Applications/Paw.app ]; then
        brew install paw
    fi
    brew install ksdiff

    # Music
    if [ ! -d /Applications/Spotify.app ]; then
        brew install spotify
    fi


    # Nicer plugins for QuickLook.
    brew install qlcolorcode
    brew install qlstephen
    brew install qlmarkdown
    brew install quicklook-json
    brew install webpquicklook
    brew install qlimagesize

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


    # Install App Store apps


    # Flowstate
    mas install 1060276201
    # Things
    mas install 904280696

    # Keynote
    mas install 409183694
    # Paprika
    mas install 1303222628

    # Day One
    mas install 1055511498

    # Microsoft Word
    mas install 462054704


    # Logic Pro
    mas install 634148309

    # TablePlus
    mas install 1362220669

    # Sequel Ace
    mas install 1518036000

    # Xcode
    mas install 497799835

    # Slack
    mas install 803453959


    ## Google Chrome extensions
    mkdir -p ~/Library/Application\ Support/Google/Chrome/External\ Extensions
    install_chrome_extension() {
        echo '{"external_update_url": "https://clients2.google.com/service/update2/crx"}' > ~/Library/Application\ Support/Google/Chrome/External\ Extensions/$1.json
    }
    # 1Password
    install_chrome_extension 'aomjjhallfgjeglblehebfpbcfeobpgk'

    # Browserstack
    install_chrome_extension 'nkihdmlheodkdfojglpcjjmioefjahjb'
    # Clockwork
    install_chrome_extension 'dmggabnehkmmfmdffgajcflpdjlnoemp'

    # Hubspot
    install_chrome_extension 'oiiaigjnkhngdbnoookogelabohpglmd'

fi

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "-------------------------------------"
echo "Enjoy your new system!"
echo "-------------------------------------"

# Open Hyper.app
open -b co.zeit.hyper

# Copy zsh config
cp ./configs/.zshrc ~/.zshrc

sudo -k

