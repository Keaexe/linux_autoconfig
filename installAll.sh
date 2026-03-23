#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
globalisation
# Installing yay
InstallScripts/yay_download.sh
if [[ $? != 0 ]]; then
    echo "Could not install yay, aborting..."
    exit 1
fi

# Needed packages
yay -S --noconfirm --needed trash-cli kitty firefox neovim starship

# Setting config files
if [ -f ~/.bashrc ]; then #bashrc
	mv ~/.bashrc ~/.bashrc.bak 
fi
ln -s ConfigFile/.bashrc ~/.bashrc

if [ -f ~/.config/starship.toml ]; then # catpuccine mocha starship 
	mv ~/.config/starship.toml ~/.config/starship.toml.bak 
fi
ln -s ConfigFile/starship.toml ~/.config/starship.toml

if [ -f ~/.config/fastfetch/config.jsonc ]; then # custom fastfetch
	mv ~/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc.bak
fi
ln -s ConfigFile/fastfetchConfig.jsonc ~/.config/fastfetch/config.jsonc

if [ -f ~/.config/nvim/lua/config/keymap]; then # custom keymap
	echo "dotfile($SCRIPT_DIR/ConfigFiles/keymap.lua)" >> ~/.config/nvim/lua/config/keymap.lua
else
	if [ -f ~/.config/nvim/init.lua]; then
		mv ~/.config/nvim/init.lua ~/.config/nvim/init.lua.bak
	fi
    ln -s ConfigFile/keymap.lua ~/.config/nvim/init.lua
fi

# Additional packages
yay -S --noconfirm --needed vesktop tor rust devtoolbox onlyoffice isoimagewriter nextcloud-client beeper-v4-bin vlc kdeconnect gabutdm localsend