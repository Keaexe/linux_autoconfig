#!/bin/bash

packages=('org.torproject.torbrowser-launcher')
echo "Optional flatpak packages :"
for i in "${!packages[@]}"; do
  echo "$(($i + 1)) : ${packages[$i]}"
done
read -p "Enter the number of the packages you don't want to install 
('A' for all, 'return' for none) : " ignored
if [ -n $ignored ]; then
	for package in $ignored; do
		if (( package > 0 && package <= ${#packages[@]} )); then
			packages["$((package - 1))"]=''
		fi
	done
fi

if [[ $ignored != 'A' ]]; then
	flatpak install flathub  -y "${packages[@]}"
fi