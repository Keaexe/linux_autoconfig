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

# Set default browser
echo "Which browser do you want as WebApp handler ?"
read -p "[F]irefox [Z]en-browser Chromium (default [RETURN])" ans
if [[ -z $ans || $ans == 'f' || $ans == 'F' ]]; then
	$SCRIPT_DIR/InstallScripts/firefox.sh
else 
	if [[ -z $ans || $ans == 'z' || $ans == 'Z' ]]; then
		$SCRIPT_DIR/InstallScripts/zen.sh
	fi
fi

# Setting config files
echo "source $SCRIPT_DIR/ConfigFiles/.bashrc" >> ~/.bashrc

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
if [[ $wantkeymap == 'y' || $wantkeymap == 'Y' ]]; then # custom keymap for neovim
	KEYMAP_DIR="~/.config/nvim/lua/config/keymaps.lua"
	mkdir -p "$KEYMAP_DIR"
	if [ -f "$KEYMAP_DIR/keymaps.lua"]; then
		mv "$KEYMAP_DIR/keymaps.lua" "$KEYMAP_DIR/keymaps.lua.bak"
	fi
	ln -sf "$SCRIPT_DIR/ConfigFiles/keymap.lua" "$KEYMAP_DIR/keymaps.lua"
fi

$SCRIPT_DIR/InstallScripts/yay_packages.sh
$SCRIPT_DIR/InstallScripts/flatpak_packages.sh
