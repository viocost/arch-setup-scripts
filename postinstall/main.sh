#!/bin/bash

# This is main script

## DRIVIER INSTALLERS HELPERS
function xserver(){
    echo "Xserver called"
}

function nvidia(){
    echo "nvidia called"
}

function pulse_audio(){
    echo "Puldeaudio called"
}

function alsa(){
    echo "alsa called"
}

function acpilight(){
    echo "acpilight called"
}


############################################################

## Packages installers

function chromium (){

}


function yay (){

}

function wget (){

}

function  i3_gaps (){

}

function  dunst (){

}

function polybar (){

}

function bspwm (){

}

function  picom (){

}

function dmenu (){

}

function nitrogen (){

}

function gucharmap (){

}

function htop (){

}

function sxiv (){

}

function zathura (){

}

function st (){

}

function tilix (){

}

function emacs (){

}

function nvim (){

}

function ranger (){

}

function zsh (){

}



declare -A drivers

drivers[1]=xserver
drivers[2]=nvidia
drivers[3]=pulse_audio
drivers[4]=alsa
drivers[5]=acpilight

dialog --title "Arch Tools Installer" \
		--checklist "Select drivers you want to install" 0 0 0  \
		1 "X-server" on \
		2 "Nvidia drivedr" on \
		3 "Pulse audio" on \
		4 "Alsa " on \
		5 "Acpi light mocule " on 2>drivers.tmp

DRIVERS=$(cat drivers.tmp)
                	

clear

echo $(date) "Bootstrap\n\n" | tee bootstrap.log
echo "Installing drivers\n\n" | tee -a bootstrap.log
	

for i in $DRIVERS
do
	${drivers[$i]} 2>&1  | tee -a bootstrap.log
done

sleep 2


dialog --title "Arch Tools Installer" \
	--checklist "Select software you want to install" 0 0 0  \
	1 "chromium browser" on \
	2 "yay - AUR package manager" on \
	3 "wget- well, wget" on \
	4 "i3-gaps Window manager" on \
	5 "dunst - notification daemon" on \
	6 "polybar" on \
	7 "bspwm - another window manager" off \
	8 "dmenu - suckless menu for i3 or bspwm" on \
	9 "picom - screen compositor" on \
	10 "nitrogen - wallpaper manager" on \
	11 "gucharmap - GUI charmap viewer" on \
	12 "htop - Fancy process management" on \
	13 "sxiv - Image viewer sxiv" on \
	14 "zsthura - Doc pdf viewer" on \
	15 "st - suckless terminal" on \
	16 "tilix - another terminal emulator" off \
	17 "emacs - well, emacs" on \
	18 "nvim - better vim" on \
	19 "ranger terminal file manager" on \
	20 "zsh shell" on \
	21 "oh-my-zsh plugin manager for zsh" on  2>software.tmp


clear 


echo "\n\n=======================================\n\n" | tee -a bootstrap.log
echo "\n\nInstalling packages...n\n" | tee -a bootstrap.log

SOFTWARE=$(cat software.tmp)

echo $SOFTWARE

rm *.tmp





	
	


