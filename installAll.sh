#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# Installing yay
InstallScripts/yay_download.sh
if [[ $? != 0 ]]; then
    echo "Could not install yay, aborting..."
    exit 1
fi

# Needed packages
sudo pacman -S --noconfirm --needed flatpak firefox
yay -S --noconfirm --needed trash-cli kitty neovim starship fastfetch

# Setting config files
if [ -f ~/.bashrc ]; then #bashrc
	mv ~/.bashrc ~/.bashrc.bak 
fi
ln -s $SCRIPT_DIR/ConfigFile/.bashrc ~/.bashrc

if [ -f ~/.config/starship.toml ]; then # catpuccine mocha starship 
	mv ~/.config/starship.toml ~/.config/starship.toml.bak 
fi
ln -s $SCRIPT_DIR/ConfigFile/starship.toml ~/.config/starship.toml

if [ -f ~/.config/fastfetch/config.jsonc ]; then # custom fastfetch
	mv ~/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc.bak
fi
mkdir -p ~/.config/fastfetch
ln -s $SCRIPT_DIR/ConfigFile/fastfetchConfig.jsonc ~/.config/fastfetch/config.jsonc

read -p "Would you like to install LazyVim ? [Y/n]" wantLazy
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

if [ -f ~/.config/nvim/lua/config/keymaps.lua ]; then # custom keymap
	echo "dotfile($SCRIPT_DIR/ConfigFiles/keymap.lua)" >> ~/.config/nvim/lua/config/keymaps.lua
else
	if [ -f ~/.config/nvim/init.lua ]; then
		mv ~/.config/nvim/init.lua ~/.config/nvim/init.lua.bak
	fi
    ln -s $SCRIPT_DIR/ConfigFile/keymap.lua ~/.config/nvim/init.lua
fi

# Additional packages
yay_packages=('vesktop-bin' 'rust' 'devtoolbox' 'onlyoffice' 'isoimagewriter' 'nextcloud-client' 'beeper-v4-bin' 'kdeconnect' 'gabutdm' 'localsend')
flat_packages=('org.torproject.torbrowser-launcher')

echo "Optionals yay packages :"
for i in "${!yay_packages[@]}"; do
  echo "$(($i + 1)) : ${yay_packages[$i]}"
done
read -p "Enter the number of the packages you don't want to install" ignored_packages
for package in $ignored_packages; do
	if [[ $package > 0 && $package <= ${#yay_packages[@]} ]]; then
		yay_packages["${package - 1}"]=''
	fi
done

echo "Optionals flatpak packages :"
for i in "${!flat_packages[@]}"; do
  echo "$(($i + 1)) : ${flat_packages[$i]}"
done
read -p "Enter the number of the packages you don't want to install" ignored_packages
for package in $ignored_packages; do
	if [[ $ignored_packages > 0 && $ignored_packages <= ${#flat_packages[@]} ]]; then
		flat_packages["${package - 1}"]=''
	fi
done

yay -S --noconfirm --needed ${yay_packages[@]}
flatpak install flathub  -y ${flat_packages[@]}