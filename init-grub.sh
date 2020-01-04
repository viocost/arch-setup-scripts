#!/bin/bash

echo checking hooks...


input="/etc/mkinitcpio.conf"
while IFS= read -r line
do
	if [[ "$line" == "HOOKS"*"btrfs"* ]]; then
		echo "BTRFS hook already exists"
		echo "$line"
		break
	
	elif [[ "$line" == "HOOKS"* ]]; then
		echo Adding btrfs hook...
		sed -i '/^HOOKS.*block/s/block/& btrfs/' /etc/mkinitcpio.conf 
	fi
done < "$input"

mkinitcpio -p linux


pacman -Sy --noconfirm grub efibootmgr
grub-install --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg



