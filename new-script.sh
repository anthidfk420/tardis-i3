#!/bin/bash

launch_script () {
	internet_check
}

internet_check () {
	cwd=$(pwd)
  echo '  _____ _   ___ ___ ___ ___     _ ____'
 echo ' |_   _/_\ | _ \   \_ _/ __|___(_)__ /'
   echo '   | |/ _ \|   / |) | |\__ \___| ||_ \'
   echo '   |_/_/ \_\_|_\___/___|___/   |_|___/'
	echo 
	echo "Free Software licensed under the GNU General Public License 3.0"	
   echo && sleep 2
   	read -p "Type the user you wish to install Tardis for: " selected_username
	echo
	read -p "Can you confirm you're connected to the internet and want to go ahead with the installer? [y/n] " internet
	if [ $internet == 'y' ] || [ $internet == 'Y' ]
	then
		pacman_update
	else
		end_script	
	fi
}

pacman_update () {
	pacman -Sy && pacman -Syu
       	pacman_install	
}

# If something goes wrong with the script
end_script () {
	echo
	echo "An error has occurred and the script was unable to install successfully."
	exit
}

# Installing packages
pacman_install () {
	pacman -S i3 dmenu polybar ttf-fira-code arc-icon-theme lxappearance thunar materia-gtk-theme ttf-fira-sans sddm noto-fonts noto-fonts-cjk nitrogen wireplumber pipewire pipewire-pulse pavucontrol xfce4-terminal network-manager-applet chromium vim --noconfirm --needed
	systemctl enable sddm
	wm_customise
}

# Setup for WM and utilities
wm_customise () {
	cp -r $cwd/config/i3 /home/$selected_username/.config/
	cp -r $cwd/config/polybar /home/$selected_username/.config/
	cp -r $cwd/config/gtk-2.0 /home/$selected_username/.config/
	cp -r $cwd/config/gtk-3.0 /home/$selected_username/.config/
	mv $cwd/wallpapers /home/$selected_username/ && cp -r $cw/config/nitrogen /home/$selected_username/.config/
	end_of_install
}

end_of_install () {
	clear
	echo "Installation complete, please restart your computer."
}

# What causes the script to run
launch_script
