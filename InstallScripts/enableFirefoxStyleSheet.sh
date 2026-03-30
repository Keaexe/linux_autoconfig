#!/bin/bash

# Find the Firefox profile directory
PROFILE_DIR=$(find ~/.mozilla/firefox/ -maxdepth 1 -type d -name "*.default-release" | head -n 1)
if [ -z "$PROFILE_DIR" ]; then
    echo "Could not find Firefox profile. Is Firefox installed?"
    exit 1
fi

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