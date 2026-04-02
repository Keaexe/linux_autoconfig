#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Installing yay
pacman -Qi yay > /dev/null
if [[ $? == 1 ]]; then
	if [[ $? != 0 ]]; then
		echo "Could not install yay, aborting..."
		exit 1
	fi
	$SCRIPT_DIR/InstallScripts/yay_download.sh
fi

# Needed packages
sudo pacman -S --noconfirm --needed flatpak
if [[ $? != 0 ]]; then
    echo "Could not install mandatory pacman packages, aborting..."
    exit 1
fi
yay -S --noconfirm --needed trash-cli kitty neovim starship fastfetch
if [[ $? != 0 ]]; then
    echo "Could not install mandatory yay packages, aborting..."
    exit 1
fi

# Set firefox as default
$SCRIPT_DIR/InstallScripts/firefox.sh

# Setting config files
if [ -f ~/.bashrc ]; then #bashrc
	mv ~/.bashrc ~/.bashrc.bak 
fi
ln -sf $SCRIPT_DIR/ConfigFiles/.bashrc ~/.bashrc

if [ -f ~/.config/starship.toml ]; then # catpuccine mocha starship 
	mv ~/.config/starship.toml ~/.config/starship.toml.bak 
fi
ln -sf $SCRIPT_DIR/ConfigFiles/starship.toml ~/.config/starship.toml
mkdir -p ~/.config/fastfetch # custom fastfetch
if [ -f ~/.config/fastfetch/config.jsonc ]; then
	mv ~/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc.bak
fi
ln -sf $SCRIPT_DIR/ConfigFiles/fastfetchConfig.jsonc ~/.config/fastfetch/config.jsonc

read -p "Would you like my azerty keymaps for neovim ? [y/N] : " wantkeymap
if [[ $wantkeymap == 'y' || $wantkeymap == 'Y' ]]; then
	if [ -f ~/.config/nvim/lua/config/keymaps.lua ]; then # custom keymap for neovim
		KEYMAP_FILE="~/.config/nvim/lua/config/keymaps.lua"
	else
		KEYMAP_FILE="~/.config/nvim/init.lua"
	fi
	if [ -f $KEYMAP_FILE ]; then
		mv $KEYMAP_FILE $KEYMAP_FILE.bak
	fi
	ln -sf $SCRIPT_DIR/ConfigFiles/keymap.lua $KEYMAP_FILE
fi

$SCRIPT_DIR/InstallScripts/yay_packages.sh
$SCRIPT_DIR/InstallScripts/flatpak_packages.sh
