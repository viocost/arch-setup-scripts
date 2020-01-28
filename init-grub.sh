#!/bin/bash

echo checking hooks...

input="/etc/mkinitcpio.conf"
while IFS= read -r line
do
	if [[ "$line" == "HOOKS"* ]]; then

		if [[ "$line" != *"btrfs"* ]]; then
			echo Adding btrfs hook...
			sed -i '/^HOOKS.*block/s/block/& btrfs/' /etc/mkinitcpio.conf 
		fi	

		
		sed -i   's/ udev / /' /etc/mkinitcpio.conf 
		sed -i   's/ resume / /' /etc/mkinitcpio.conf 
		sed -i   's/ usr / /' /etc/mkinitcpio.conf 

		if [[ "$line" != *"systemd"* ]]; then
			echo Adding systemd hook...
			sed -i '/^HOOKS.*base/s/base/& systemd/' /etc/mkinitcpio.conf 
		fi	

		break
	fi
done < "$input"

mkinitcpio -p linux

pacman -Sy --noconfirm grub efibootmgr
grub-install --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg








