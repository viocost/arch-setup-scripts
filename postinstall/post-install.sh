#!/bin/bash



function create_user(){
	read  -p "Enter username for new user: " username
	if [[ ${#username} -gt 0 ]]; then
		echo creating new user "$username"
		useradd -m -G wheel,video -s /bin/bash "$username"
		passwd "$username"
	fi
}

function install_packages(){
	pacman -Sy --noconfirm man git 
}


function fix_iwlwifi_intel(){
	path="/etc/modprobe.d/iwlwifi.conf"
	if [[ ! -f "$path" ]] || grep -Fxq "*11n_disable=1*swcrypto=1*" "$path"; then 
		echo "options iwlwifi 11n_disable=1 swcrypto=1" >> /etc/modprobe.d/iwlwifi.conf;
		echo iwlwifi config updated
	else
		echo config already exists
	fi
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



if  [[ $(ask_question "Create user? ")  -gt 0 ]] ; then
	create_user
fi


if  [[ $(ask_question "Install misc packages?")  -gt 0 ]] ; then
	install_packages
fi






# Adding wheel group to sudoers without password

sed -i '/^# %wheel.* NOPASSWD.*/s/^#//' /etc/sudoers
