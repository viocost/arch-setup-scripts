#!/bin/bash



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


function st(){
    wget "https://dl.suckless.org/st/st-0.8.2.tar.gz"
    tar -xvf st
    cd st
    wget "https://st.suckless.org/patches/alpha/st-alpha-0.8.2.diff"
    patch < st-alpha-0.8.2.diff
    make 
    sudo make install
    cd ../
    rm -rf st
}

# install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ../

sudo pacman -Sy xorg xorg-xinit
sudo pacman -Sy nvidia
sudo echo '
Section "OutputClass"
    Identifier "nvidia"
    MatchDriver "nvidia-drm"
    Driver "nvidia"
    Option "AllowEmptyInitialConfiguration"
    Option "PrimaryGPU" "yes"
    ModulePath "/usr/lib/nvidia/xorg"
    ModulePath "/usr/lib/xorg/modules"
EndSection 

' > /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf

sudo echo '
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
' > /home/kostia/.xinitrc


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
sudo pacman -Sy picom
yay -Sy polybar --noconfirm

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
sudo pacman -S wget

