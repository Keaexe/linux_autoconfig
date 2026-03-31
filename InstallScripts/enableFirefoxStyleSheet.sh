#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

get_profile_dir() {
    # Searching for the profile folder
    PROFILES_INI="$HOME/.mozilla/firefox/profiles.ini"
    # Clearing the result
    RELATIVE_PATH=$(grep "^Path=" "$PROFILES_INI" | head -n 1 | cut -d'=' -f2 | tr -d '\r')
    echo "$HOME/.mozilla/firefox/$RELATIVE_PATH"
}

PROFILE_DIR=$(get_profile-dir)
while [ -z "$PROFILE_DIR" ]; do
    echo "Could not find Firefox profile."
    pacman -Qi firefox > /dev/null
    if [[ $? != 0 ]]; then
        echo "Firefox has not been installed, script failed"
        exit 1
    fi
    echo "Please create a profile"
    firefox -P
    PROFILE_DIR=$(get_profile-dir)
done

echo "Targeting profile: $PROFILE_DIR"

mkdir -p "$PROFILE_DIR/chrome"

# Enable the legacy stylesheet setting in prefs.js
PREFS_FILE="$PROFILE_DIR/prefs.js"
if grep -q "toolkit.legacyUserProfileCustomizations.stylesheets" "$PREFS_FILE"; then
    sed -i 's/user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", false)/user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true)/g' "$PREFS_FILE"
else
    echo 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);' >> "$PREFS_FILE"
fi

ln -sf "$SCRIPT_DIR/ConfigFiles/userChrome.css" "$PROFILE_DIR/chrome/userChrome.css"
echo "Stylesheets enabled. Please restart Firefox for changes to take effect."