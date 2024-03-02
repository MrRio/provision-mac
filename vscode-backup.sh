# Copy current VSCode settings to this repo
mkdir -p ./configs/vscode
cp ~/Library/Application\ Support/Code/User/settings.json ./configs/vscode/settings.json
echo "VSCode settings copied to ./configs/vscode/settings.json"

# List of VSCode extensions
echo "Listing installed VSCode extensions..."
code --list-extensions > ./configs/vscode/extensions.txt
echo "VSCode extensions list copied to ./configs/vscode/extensions.txt"

