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
    brew cask install sublime-text
fi
if [ ! -d /Applications/Visual\ Studio\ Code.app ]; then
    brew cask install visual-studio-code
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



# Terminals
if [ ! -d /Applications/iTerm.app ]; then
    brew cask install iterm2;
fi

if [ ! -d /Applications/Hyper.app ]; then
    brew cask install hyper
fi

# Browsers
if [ ! -d /Applications/Google\ Chrome.app ]; then
    brew cask install google-chrome
fi

if [ $apps == 1 ]; then
    if [ ! -d /Applications/Firefox.app ]; then
        brew cask install firefox
    fi

    # Chat
    if [ ! -d /Applications/HipChat.app ]; then
        brew cask install hipchat
    fi
    if [ ! -d /Applications/Slack.app ]; then
        brew cask install slack
    fi
    if [ ! -d /Applications/Skype.app ]; then
        brew cask install skype
    fi

    # Dev apps
    if [ ! -d /Applications/Sequel\ Pro.app ]; then
        brew cask install sequel-pro
    fi
    if [ ! -d /Applications/VirtualBox.app ]; then
        brew cask install virtualbox
    fi
    if [ ! -d /Applications/GitHub\ Desktop.app ]; then
        brew cask install github-desktop
    fi
    if [ ! -d /Applications/Paw.app ]; then
        brew cask install paw
    fi
    brew cask install ksdiff
    if [ ! -d /Applications/Genymotion.app ]; then
        brew cask install genymotion
    fi
    if [ ! -d /Applications/SourceTree.app ]; then
        brew cask install sourcetree
    fi
    # Music
    if [ ! -d /Applications/Spotify.app ]; then
        brew cask install spotify
    fi

    # Adobe Stuff
    if [ ! -d /Applications/Adobe\ Photoshop\ CC\ 2015 ]; then
        brew cask install adobe-photoshop-cc
    fi
    if [ ! -d /Applications/Adobe\ Illustrator\ CC\ 2015 ]; then
        brew cask install adobe-illustrator-cc
    fi

    # Sketch
    if [ ! -d /Applications/Sketch.app ]; then
        brew cask install sketch
    fi
    if [ ! -d /Applications/InVisionSync.app ]; then
        brew cask install invisionsync
    fi

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

    # Install Ruby
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    \curl -sSL https://get.rvm.io | bash -s stable
    rvm install ruby-head

    # Install App Store apps

    # 1Password
    mas install 443987910
    # BetterSnapTool
    mas install 417375580
    # Boxy
    mas install 1053031090
    # Daisydisk - disk usage visualiser
    mas install 411643860
    # Harvest - Time tracking
    mas install 506189836
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
    # Harvest time tracker
    install_chrome_extension 'fbpiglieekigmkeebmeohkelfpjjlaia'
    # Hubspot
    install_chrome_extension 'oiiaigjnkhngdbnoookogelabohpglmd'
    # Vue.js devtools
    install_chrome_extension 'nhdogjmejiglipccpnnnanhbledajbpd'
fi

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "-------------------------------------"
echo "Your Git key is ready to be pasted!"
echo "Enjoy your new system!"
echo "-------------------------------------"

# Open Hyper.app
open -b co.zeit.hyper

# Copy zsh config
cp ./configs/.zshrc ~/.zshrc

sudo -k

