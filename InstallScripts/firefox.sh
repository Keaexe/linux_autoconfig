#!/bin/bash
yay -S --noconfirm --needed firefox firefoxpwa
xdg-settings set default-web-browser firefox.desktop
firefox -P WebApps
sed -i -e 's/setsid*2}\"/firefox -P WebApps --new-window "$1"/g' ~/.local/share/omarchy/bin/omarchy-launch-webapp
echo "Opening \"Progressive Web Apps for Firefox\" extension in Firefox...
Please add it to firefox"
sleep 1
xdg-open https://addons.mozilla.org/en-US/firefox/addon/pwas-for-firefox/
echo "Once you've add the extension, the web apps should open with firefox"