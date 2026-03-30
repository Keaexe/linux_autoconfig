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
	echo "source $SCRIPT_DIR" >> ~/.local/share/omarchy/default/bash/rc
fi

if [ -f ~/.config/starship.toml ]; then # catpuccine mocha starship 
	mv ~/.config/starship.toml ~/.config/starship.toml.bak 
fi
ln -sf $SCRIPT_DIR/ConfigFile/starship.toml ~/.config/starship.toml

if [ -f ~/.config/fastfetch/config.jsonc ]; then # custom fastfetch
	mv ~/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc.bak
fi
mkdir -p ~/.config/fastfetch
ln -sf $SCRIPT_DIR/ConfigFile/fastfetchConfig.jsonc ~/.config/fastfetch/config.jsonc

read -p "Would you like to install LazyVim ? [Y/n]" wantLazy # lazyvim
if [[ -z $wantLazy || $wantLazy == 'y' || $wantLazy == 'Y' ]]; then
	if [ -d ~/.config/nvim ]; then
		mv ~/.config/nvim{,.bak}
		mv ~/.local/share/nvim{,.bak}
		mv ~/.local/state/nvim{,.bak}
		mv ~/.cache/nvim{,.bak}
	fi
	git clone https://github.com/LazyVim/starter ~/.config/nvim
	rm -rf ~/.config/nvim/.git
fi

if [ -f ~/.config/nvim/lua/config/keymaps.lua ]; then # custom keymap for neovim
	echo "dotfile($SCRIPT_DIR/ConfigFiles/keymap.lua)" >> ~/.config/nvim/lua/config/keymaps.lua
else
	if [ -f ~/.config/nvim/init.lua ]; then
		mv ~/.config/nvim/init.lua ~/.config/nvim/init.lua.bak
	fi
    ln -sf $SCRIPT_DIR/ConfigFile/keymap.lua ~/.config/nvim/init.lua
fi

$SCRIPT_DIR/InstallScripts/yay_packages.sh
$SCRIPT_DIR/InstallScripts/flatpak_packages.sh
