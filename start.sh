
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install mas
./mas/apps.sh

brew install homebrew/php/php71 homebrew/php/php71-mcrypt mysql

mkdir ~/Code
cd ~/Code
valet park
