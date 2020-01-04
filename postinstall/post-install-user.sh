#!/bin/bash


function install_nvidia(){
	
}

function ask_question(){
	while true; do
		read -p "$1 Y/n   " yn
		case $yn in 
			[Yy]* ) 
				echo 1
			       	return
				;;
		        [Nn]* ) 
				echo 0
			       	return
				;;
				
		esac
	done
}

sudo pacman -Sy nvidia-lts
sudo pacman -Sy xorg

sudo pacman -Sy lightdm
sudo systemctl enable lightdm.service
sudo pacman -Sy lightdm-gtk-greeter
sudo pacman -Sy tilix

sudo pacman -Sy i3-gaps
sudo pacman -Sy dmenu
sudo pacman -Sy nitrogen
sudo pacman -Sy compton
sudo yaourt -Sy polybar --noconfirm

sudo pacman -Sy htop lm_sensors
sensors-detect




