#!/bin/bash

# Find the Firefox profile directory
PROFILE_DIR=$(find ~/.mozilla/firefox/ -maxdepth 1 -type d -name "*.default-release" | head -n 1)
while [ -z "$PROFILE_DIR" ]; do
    echo "Could not find Firefox profile."
    pacman -Qi firefox > /dev/null
    if [[ $? != 0 ]]; then
        echo "Firefox has not been installed, script failed"
        exit 1
    fi
    echo "Please create a profile"
    firefox -P
    PROFILE_DIR=$(find ~/.mozilla/firefox/ -maxdepth 1 -type d -name "*.default-release" | head -n 1)
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

echo "Stylesheets enabled. Please restart Firefox for changes to take effect."