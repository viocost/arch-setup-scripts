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
sudo pacman -Sy xorg xorg-xinit

# COMMENTING THIS OUT cause why the hell we need stupid display manager?
#sudo pacman -Sy lightdm
#sudo systemctl enable lightdm.service

# Default
#sudo pacman -Sy lightdm-gtk-greeter

# Good looking
#sudo pacman -Sy lightdm-webkit2-greeter
#yaourt -S lightdm-webkit-theme-aether
#sudo sed -i 's/^webkit_theme\s*=\s*\(.*\)/webkit_theme = lightdm-webkit-theme-aether #\1/g' /etc/lightdm/lightdm-webkit2-greeter.conf


# TODO change /etc/lightdm/lightdm.conf to apply settings

#
#sudo pacman -Sy tilix
#install st

sudo pacman -Sy i3-gaps
sudo pacman -Sy dmenu

# notification daemon
sudo pacman -S dunst

# Wallpaper
sudo pacman -Sy nitrogen
sudo pacman -Sy compton
sudo yaourt -Sy polybar --noconfirm

sudo pacman -Sy htop lm_sensors
sensors-detect

sudo pacman -Sy pulseaudio

pulseaudio --start

# fonts browser
sudo pacman -Sy gucharmap

# disable default bitmap fonts
#sudo ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d

# Brightness module
sudo pacman -Sy acpilight

# TODO
# Bumblebee mesa add configuration to bumblebee intel-virtual-output  alsa tools

sudo pacman -Sy falmeshot

sudo pacman -Sy vlc

# Image viewer
sudo pacman -S sxiv

# Pdf doc viewer and pdf plugin
sudo pacman -S zathura
sudo pacman -S zathura-pdf-poppler

