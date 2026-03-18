#!/bin/bash

# Installing yay
/InstallScripts/yay_download.sh
if [[ $? != 0 ]]; then
    echo "Could not install yay, aborting..."
    exit 1
fi

# Needed packages
yay -S --noconfirm --needed trash-cli kitty firefox

# Setting config files
mv ~/.bashrc ~/.bashrc.bak #bashrc
ln -s ConfigFile/.bashrc ~/.bashrc
mv ~/.config/starship.toml ~/.config/starship.toml.bak # catpuccine mocha starship 
ln -s ConfigFile/starship.toml ~/.config/starship.toml
mv ~/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc.bak # catpuccine mocha starship 
ln -s ConfigFile/fastfetchConfig.jsonc ~/.config/fastfetch/config.jsonc

# Additional packages
yay -S --noconfirm --needed vesktop tor rust devtoolbox onlyoffice isoimagewriter nextcloud-client beeper-v4-bin vlc kdeconnect gabutdm localsend