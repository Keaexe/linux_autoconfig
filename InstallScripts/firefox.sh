#!/bin/bash
yay -S --noconfirm --needed firefox
xdg-settings set default-web-browser firefox.desktop


read -p "Do you want to share cookies and history between main browser and web apps ? [Y/n]" ans
if [[ -z $ans || $ans == 'y' || $ans == 'Y' ]]; then
    SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    sed -i -e 's/setsid*2}\"/firefox --new-window "$1"/g' ~/.local/share/omarchy/bin/omarchy-launch-webapp
    $SCRIPT_DIR/enableFirefoxStyleSheet.sh

    # Searching for the profile folder
    PROFILES_INI="$HOME/.mozilla/firefox/profiles.ini"
    # Clearing the result
    RELATIVE_PATH=$(grep "^Path=" "$PROFILES_INI" | head -n 1 | cut -d'=' -f2 | sed 's/\r//')

    ABS_PATH="$HOME/.mozilla/firefox/$RELATIVE_PATH"
    mkdir -p "$ABS_PATH/chrome"
    ln -sf "$SCRIPT_DIR/ConfigFiles/userChrome.css" "$ABS_PATH/chrome/userChrome.css"
else
    yay -S --noconfirm --needed firefoxpwa
    firefox -P WebApps
    sed -i -e 's/setsid*2}\"/firefox -P WebApps --new-window "$1"/g' ~/.local/share/omarchy/bin/omarchy-launch-webapp
    echo "Opening \"Progressive Web Apps for Firefox\" extension in Firefox...
Please add it to firefox"
    sleep 1
    xdg-open https://addons.mozilla.org/en-US/firefox/addon/pwas-for-firefox/
    echo "Once you've add the extension, the web apps should open with firefox"
fi
