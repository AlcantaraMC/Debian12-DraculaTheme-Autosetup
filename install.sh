#!/bin/bash
# Script to set up directories for themes and icons
# Ensure the script is run with bash

clear

# Preliminary instructions 
###############################################################
printf 'Welcome to the Dracula Theme and Tela-circle-dracula Icon Set Installer.\n\n'

printf 'NOTE: This script requires sudo privileges to install necessary packages and set up directories. Please ensure you have the necessary permissions to run this script. This script is tested on Debian and Ubuntu running GNOME.\n\n'

printf 'This script will automatically install the Dracula (https://github.com/dracula/gtk) theme and Tela-circle-dracula icon set (https://github.com/vinceliuice/Tela-circle-icon-theme) for GNOME, on the local user.\n\n'

printf 'Gnome Tweaks and Gnome Shell Extensions will be installed if they are not already present. You may be prompted for your password to install packages.\n\n'

printf 'Press any key to continue or Ctrl+C to cancel...'
read -n 1 -s



# Checking if some dependencies are installed ###############################################################

# checking if gnome tweaks is installed
printf 'Checking if GNOME Tweaks is installed...\n'
if ! command -v gnome-tweaks &> /dev/null; then
	printf 'GNOME Tweaks could not be found, installing...\n'
	sudo apt-get install -y gnome-tweaks
else
	printf 'GNOME Tweaks is already installed.\n'
fi

#check if gnome shell extensions is installed
printf 'Checking if GNOME Shell Extensions is installed...\n'
if ! command -v gnome-shell-extension-tool &> /dev/null; then
	printf 'GNOME Shell Extensions could not be found, installing...\n'
	sudo apt-get install -y gnome-shell-extensions gnome-extensions
else
	printf 'GNOME Shell Extensions is already installed.\n'
fi

# Checking if tar is installed
printf 'Setting up compression tools...\n'
if ! command -v tar &> /dev/null; then
	printf 'tar could not be found, installing...\n'
	sudo apt-get install -y tar
else
	printf 'tar is already installed.\n'
fi


# Setting up environment variables
###############################################################

# get the current logged in user's directory
USER_HOME=$(eval echo ~${SUDO_USER})

# getting the current logged in user's username
USER_NAME=$(eval echo ${SUDO_USER})



# Setting up install directories for themes and icons
###############################################################

echo "Setting up themes and icons directories..."

# checking for the existence of the themes and icons directories according
# to the XDG Base Directory Specification
THEMES_DIRECTORY_XDG=$USER_HOME/.local/share/themes
ICONS_DIRECTORY_XDG=$USER_HOME/.local/share/icons

	if [ -d THEMES_DIRECTORY_XDG ]; then
		echo "Folder '$THEMES_DIRECTORY_XDG' exists."
	else
		echo "Creating folder '$THEMES_DIRECTORY_XDG'..."
		mkdir -p "$THEMES_DIRECTORY_XDG"
	fi

	if [ -d ICONS_DIRECTORY_XDG ]; then
		echo "Folder '$ICONS_DIRECTORY_XDG' exists."
	else
		echo "Creating folder '$ICONS_DIRECTORY_XDG'..."
		mkdir -p "$ICONS_DIRECTORY_XDG"
	fi

# checking for the existence of the themes and icons directories according
# to GTK 3.0 and 4.0 specifications
ICONS_DIRECTORY_LEGACY=$USER_HOME/.icons
THEMES_DIRECTORY_LEGACY=$USER_HOME/.themes

	if [ -d "ICONS_DIRECTORY_LEGACY" ]; then
		echo "Folder '$ICONS_DIRECTORY_LEGACY' exists."
	else
		echo "Creating folder '$ICONS_DIRECTORY_LEGACY'..."
		mkdir -p "$ICONS_DIRECTORY_LEGACY"
	fi

	if [ -d "THEMES_DIRECTORY_LEGACY" ]; then
		echo "Folder '$THEMES_DIRECTORY_LEGACY' exists."
	else
		echo "Creating folder '$THEMES_DIRECTORY_LEGACY'..."
		mkdir -p "$THEMES_DIRECTORY_LEGACY"
	fi

# Displaying the directories
	echo "Themes directory (XDG): $THEMES_DIRECTORY_XDG"
	echo "Icons directory (XDG): $ICONS_DIRECTORY_XDG"
	echo "Themes directory (Legacy): $THEMES_DIRECTORY_LEGACY"
	echo "Icons directory (Legacy): $ICONS_DIRECTORY_LEGACY"
	echo "GTK 4.0 config directory: $USER_HOME/.config/gtk-4.0"



# Copying Theme files and icons to the respective directories
###############################################################

	# extracting the theme and icon files from the compressed archives
	echo "Extracting theme files..."
	tar -xf ./theme/gtk/Dracula.tar.xz
	tar -xf ./theme/icon/Tela-circle-dracula.tar.xz

	# Copying themes and icons to the XDG directories
	echo "Copying themes and icons to the respective directories..."
	cp -r ./Dracula "$THEMES_DIRECTORY_XDG"
	cp -r ./Tela-circle-dracula "$ICONS_DIRECTORY_XDG"
	echo "Cleaning up extracted files..."

	# Copying themes and icons to the legacy directories
	echo "Copying themes and icons to the legacy directories..."
	cp -r ./Dracula "$THEMES_DIRECTORY_LEGACY"
	cp -r ./Tela-circle-dracula "$ICONS_DIRECTORY_LEGACY"

# For GTK 4.0 which GNOME uses by default, override the default gtk.css 
# and gtk-dark.css files with the ones from the Dracula theme

	# Checking if ~/.config/gtk-4.0 exists
	if [ -d $USER_HOME/.config/gtk-4.0 ]; then
		echo "Directory ~/.config/gtk-4.0 already exists."
	else
		echo "Creating directory ~/.config/gtk-4.0..."
		mkdir -p $USER_HOME/.config/gtk-4.0
	fi

	# Copying GTK CSS files to the gtk-4.0 directory
	cp ./Dracula/gtk-4.0/gtk.css $USER_HOME/.config/gtk-4.0/
	cp ./Dracula/gtk-4.0/gtk-dark.css $USER_HOME/.config/gtk-4.0/

# copying assets (e.g. custom buttons) to the correct directories
cp -r ./Dracula/assets $USER_HOME/.config/


# automatically select the theme and icon set using gsettings
echo "Applying the Dracula theme and Tela-circle-dracula icon set to the current user ($USER_NAME)..."
sudo -u "$USER_NAME" dbus-launch --exit-with-session gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
sudo -u "$USER_NAME" dbus-launch --exit-with-session gsettings set org.gnome.desktop.interface icon-theme "Tela-circle-dracula"

# also set the shell theme to Dracula
sudo -u "$USER_NAME" dbus-launch --exit-with-session gsettings set org.gnome.shell.extensions.user-theme name "Dracula"



# exit instructions *******************************************

printf '\n\n###### FINISH ######\n\n'

printf 'Setup complete! Themes should have been automatically applied to the current user (%s).\n\n' "$USER_NAME"

printf 'If in rare cases that it is not, please open GNOME Tweaks and select the "Dracula" theme on the Shell and Legacy Applications menu, and "Tela-circle-dracula" icon set. Log out and log back in to see the changes take effect. If not, restart your system.\n\n'

printf 'TIPS: Awesome wallpapers to complement your installation can be found here: https://github.com/dracula/wallpaper\n\n'

printf 'Press any key to exit...\n\n'

read -n 1 -s
