#!/bin/bash

yay -S --noconfirm --needed zen-browser
xdg-settings set default-web-browser zen-browser.desktop
zen-browser -CreateProfile "WebApps"
PROFILE_DIR=$(grep -E 'Path=.*WebApps' ~/.zen/profiles.ini | cut -d'=' -f2)
PROFILE_PATH="$HOME/.zen/$PROFILE_DIR"
echo "Please go through first launch setup, then close the window"
zen-browser -P WebApps
echo 'user_pref("zen.view.compact.enable-at-startup", true);' >> "$PROFILE_PATH/prefs.js"
echo 'user_pref("zen.view.compact.show-sidebar-and-toolbar-on-hover", false);' >> "$PROFILE_PATH/prefs.js"
sed -i "s|setsid.*2}\"|zen-browser -P WebApps --new-window \"\$1\"|g" ~/.local/share/omarchy/bin/omarchy-launch-webapp
echo "Zen should now be the WebApps handler"