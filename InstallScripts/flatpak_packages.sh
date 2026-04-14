#!/bin/bash

packages=('org.torproject.torbrowser-launcher' 'com.github.gabutakut.gabutdm' 'com.github.IsmaelMartinez.teams_for_linux')
echo "Optional flatpak packages :"
for i in "${!packages[@]}"; do
  echo "$(($i + 1)) : ${packages[$i]}"
done
read -p "Enter the number of the packages you don't want to install 
('A' for all, 'return' for none) : " ignored
if [[ $ignored != '' && $ignored != 'A' && $ignored != 'a' ]]; then
	for package in $ignored; do
		if (( package > 0 && package <= ${#packages[@]} )); then
			packages["$((package - 1))"]=''
		fi
	done
fi
if [[ $packages != '' && $ignored != 'A' && $ignored != 'a' ]]; then
	flatpak install flathub  -y "${packages[@]}"
fi