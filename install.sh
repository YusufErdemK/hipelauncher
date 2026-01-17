#!/bin/bash

BIN_DEST="/usr/bin/hipe-launcher"
DESKTOP_DEST="/usr/share/applications/hipe-launcher.desktop"
ICON_DEST="/usr/share/icons/hicolor/256x256/apps/hipe.png"

if [ "$EUID" -ne 0 ]; then
    echo "You need to run this script as root. Try using 'sudo'."
    exit 1
fi

if [ "$1" == "-u" ]; then
    echo -e "\nUninstalling hipe-launcher..."
    [ -f "$BIN_DEST" ] && rm "$BIN_DEST" && echo "Removed $BIN_DEST"
    [ -f "$DESKTOP_DEST" ] && rm "$DESKTOP_DEST" && echo "Removed $DESKTOP_DEST"
    [ -f "$ICON_DEST" ] && rm "$ICON_DEST" && echo "Removed $ICON_DEST"

    if command -v gtk-update-icon-cache &> /dev/null; then
        echo -e "\nUpdating icon cache..."
        gtk-update-icon-cache -f /usr/share/icons/hicolor
        echo "Done."
    fi

    echo -e "\nUninstallation completed!"
    exit 0
fi

BIN_SRC="hipe-launcher"
DESKTOP_SRC="hipe-launcher.desktop"
ICON_SRC="hipe.png"

echo -e "\nloading packages..."
cp "$BIN_SRC" "$BIN_DEST"
chmod 755 "$BIN_DEST"
echo "done."

echo -e "\napp is getting installed..."
cp "$DESKTOP_SRC" "$DESKTOP_DEST"
chmod 644 "$DESKTOP_DEST"
echo "done."

echo -e "\napp icon is getting installed..."
cp "$ICON_SRC" "$ICON_DEST"
chmod 644 "$ICON_DEST"
echo "done."

if command -v gtk-update-icon-cache &> /dev/null; then
    echo -e "\nupdating icon cache..."
    gtk-update-icon-cache -f /usr/share/icons/hicolor
    echo "done."
fi

echo -e "\nInstallation completed! You can now find the application in the menu."
