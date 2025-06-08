#!/bin/bash
# Script to set up directories for themes and icons
# Ensure the script is run with bash

clear

# Preliminary instructions
echo "This script will automatically install the Dracula (https://github.com/dracula/gtk) theme and Tela-circle-dracula icon set (https://github.com/vinceliuice/Tela-circle-icon-theme) for GNOME, on the local user."
echo "Please ensure that Gnome Tweaks and Gnome Shell Extensions (https://gitlab.gnome.org/GNOME/gnome-shell-extensions) is installed on your system. This does not require root privileges, only a local user with sudo. Please ensure you have the necessary permissions to install packages and create directories. You may be prompted for your password to install packages. Press any key to continue or Ctrl+C to cancel..."
read -n 1 -s

# checking if gnome tweaks is installed
echo "Checking if GNOME Tweaks is installed..."
if ! command -v gnome-tweaks &> /dev/null; then
	echo "GNOME Tweaks could not be found, installing..."
	sudo apt-get install -y gnome-tweaks
else
	echo "GNOME Tweaks is already installed."
fi

#check if gnome shell extensions is installed
echo "Checking if GNOME Shell Extensions is installed..."
if ! command -v gnome-shell-extension-tool &> /dev/null; then
	echo "GNOME Shell Extensions could not be found, installing..."
	sudo apt-get install -y gnome-shell-extensions
else
	echo "GNOME Shell Extensions is already installed."
fi

# Checking if tar is installed
echo "Setting up compression tools..."
if ! command -v tar &> /dev/null; then
	echo "tar could not be found, installing..."
	sudo apt-get install -y tar
else
	echo "tar is already installed."
fi


# Setting up directories for themes and icons
ICONS_DIRECTORY=~/.icons
THEMES_DIRECTORY=~/.themes

echo "Setting up themes and icons directories..."

	if [ -d "ICONS_DIRECTORY" ]; then
		echo "Folder '$ICONS_DIRECTORY' exists."
	else
		echo "Creating folder '$ICONS_DIRECTORY'..."
		mkdir -p "$ICONS_DIRECTORY"
	fi

	if [ -d "THEMES_DIRECTORY" ]; then
		echo "Folder '$THEMES_DIRECTORY' exists."
	else
		echo "Creating folder '$THEMES_DIRECTORY'..."
		mkdir -p "$THEMES_DIRECTORY"
	fi

echo "Extracting theme files..."
tar -xf ./theme/gtk/Dracula.tar.xz
tar -xf ./theme/icon/Tela-circle-dracula.tar.xz

# Copying themes and icons to the respective directories
echo "Copying themes and icons to the respective directories..."
cp -r ./Dracula "$THEMES_DIRECTORY"
cp -r ./Tela-circle-dracula "$ICONS_DIRECTORY"
echo "Cleaning up extracted files..."

# Checking if ~/.config/gtk-4.0 exists
if [ -d ~/.config/gtk-4.0 ]; then
	echo "Directory ~/.config/gtk-4.0 already exists."
else
	echo "Creating directory ~/.config/gtk-4.0..."
	mkdir -p ~/.config/gtk-4.0
fi

# Copying GTK CSS files to the gtk-4.0 directory
cp ./Dracula/gtk-4.0/gtk.css ~/.config/gtk-4.0/
cp ./Dracula/gtk-4.0/gtk-dark.css ~/.config/gtk-4.0/

# copying assets to the correct directories
cp -r ./Dracula/assets ~/.config/

# Displaying the directories
echo "Themes directory: $THEMES_DIRECTORY"
echo "Icons directory: $ICONS_DIRECTORY"

clear
echo "Setup complete! You can now use GNOME Tweaks to apply the themes and icons."
echo "Please open GNOME Tweaks and select the 'Dracula' theme on the Shell and Legacy Applications menu, and 'Tela-circle-dracula' icon set."
echo "Awesome wallpapers to complement your installation can be found here: https://github.com/dracula/wallpaper"
echo "Log out and log back in to see the changes take effect."
echo "Press any key to exit..."
read -n 1 -s
