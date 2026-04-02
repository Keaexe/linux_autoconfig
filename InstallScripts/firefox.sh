#!/bin/bash
yay -S --noconfirm --needed firefox
xdg-settings set default-web-browser firefox.desktop


read -p "Do you want as web ? [Y/n]" ans
if [[ -z $ans || $ans == 'y' || $ans == 'Y' ]]; then
    yay -S --noconfirm --needed firefoxpwa
    firefox -CreateProfile "WebApps"
    sed -i "s|setsid.*2}\"|firefox -P WebApps --class 'Omarchy' --new-instance --new-window \"\$1\"|g" ~/.local/share/omarchy/bin/omarchy-launch-webapp
    echo "Opening \"Progressive Web Apps for Firefox\" extension in Firefox...
Please add it to firefox"
    sleep 1
    xdg-open https://addons.mozilla.org/en-US/firefox/addon/pwas-for-firefox/
    echo "Once you've add the extension, the web apps should open with firefox"
fi
