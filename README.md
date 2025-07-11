# Debian12-DraculaTheme-Autosetup
An automatic installer for the Dracula Theme in Debian 12 with GNOME desktop environment

## What is it? ##
I happen to like the Dracula Theme from Eliver Lara (available on gnomelook dot org), and I wanted an auto-installer for that theme for a fresh install of Debian in the future.

## Prerequisites ##
You will need a local user with `sudo` privileges, and the Gnome Tweaks and Gnome Extensions. The installer will check first if both of these are installed; if not, it will install them. You may be prompted to input your password from time to time.
The theme files are already downloaded and saved under the `themes` folder, so you don't need to download anything.

## Installing ##
1. Run `sudo chmod +x` on the `installer.sh` located at the root of the folder, and execute by `./install.sh`. Afterwards, logout and login again to see the changes.
2. On Gnome Extensions, please make sure that User Themes (https://gitlab.gnome.org/GNOME/gnome-shell-extensions) is installed and enabled.
3. On Gnome Tweaks, select "Dracula" for the Shell Themes and Legacy Applications option, and "Tela Circle Dracula" for the Icons.

## Example Images From My System ##

![image](https://github.com/user-attachments/assets/63d772e5-2e1d-48e9-9f03-6ccbf446f467)

![Screenshot from 2025-06-08 12-42-16](https://github.com/user-attachments/assets/2bd12262-acb7-448c-a075-54ac967de53e)

![Screenshot from 2025-06-08 12-41-55](https://github.com/user-attachments/assets/6f0d7423-e511-4b86-b8f2-a869fa216e4b)
