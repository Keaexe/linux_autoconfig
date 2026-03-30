#!/bin/bash

packages=('vesktop-bin' 'rust' 'devtoolbox' 'onlyoffice' 'isoimagewriter' 'nextcloud-client' 'beeper-v4-bin' 'kdeconnect' 'gabutdm' 'localsend')
echo "Optional yay packages :"
for i in "${!packages[@]}"; do
  echo "$(($i + 1)) : ${packages[$i]}"
done
read -p "Enter the number of the packages you don't want to install 
('A' for all, 'return' for none) : " ignored
if [ -n $ignored ]; then
	for package in $ignored; do
		if [[ $package > 0 && $package <= ${#packages[@]} ]]; then
			packages["$((package - 1))"]=''
		fi
	done
fi

if [[ $ignored != 'A' ]]; then
	yay -S --noconfirm --needed "${packages[@]}"
fi