#!/bin/bash

yay -S --noconfirm --needed zen-browser
xdg-settings set default-web-browser zen-browser.desktop
zen-browser -CreateProfile "WebApps"
echo "Zen browser will open the config, please turn on the \"compact on startup\" option then close the window"
sleep 1
zen-browser -P WebApps about:config
sed -i "s|setsid.*2}\"|zen-browser -P WebApps --new-window \"\$1\"|g" ~/.local/share/omarchy/bin/omarchy-launch-webapp
echo "Zen should now be the WebApps handler"