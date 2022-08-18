#!/bin/bash

launch_script () {
	internet_check
}

internet_check () {
	echo "Welcome to TARDIS, a utility for Arch Linux that automatically installs and configures a graphical environment based on i3wm." 
	sleep 2
	echo && echo "All of the dotfiles are included in this script, but avoid modifying them until the install is complete."
	echo && sleep 2
	read -p "Can you confirm you're connected to the internet? [y/n] " internet
	#if [ $internet == 'y' ] || [ $internet == 'Y' ]
	#then
		root_permission
	#else
	#	exit	
	#fi
}

# Requesting root privileges
root_permission () {
	echo "Sudo privileges are required for the install. Please type your password." && echo
	sudo su && pacman_update 
}

pacman_update () {
	pacman -Sy && pacman -Syu
       	aur_setup	
}

aur_setup () {
	pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git
	cd yay-bin
	makepkg -si || end_script
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
	pacman -S i3 polybar ttf-fira-code ttf-fira-sans sddm noto-fonts noto-fonts-cjk nitrogen wireplumber pipewire pipewire-pulse pavucontrol xfce4-terminal network-manager-applet chromium vim xorg --noconfirm --needed
	systemctl enable sddm
}

# What causes the script to run
launch_script
