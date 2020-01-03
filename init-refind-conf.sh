#!/bin/bash

pacman -Sy refind-efi
refind-install --alldrivers
cp /usr/share/refind/refind_x64.efi /boot/EFI/Boot/bootx64.efi
cp -r /usr/share/refind/drivers_x64/ /boot/EFI/Boot/


UUID=$(blkid /dev/disk/by-partlabel/system -o export | grep PARTUUID | awk -F "=" '/1/ { print $2 }')

if [[ -d /boot/EFI/Boot ]]; then
	mkdir -p /boot/EFI/Boot
fi

echo "scanfor manual
timeout 1

menuentry \"Arch Linux\" {
    loader vmlinuz-linux
    initrd initramfs-linux.img
    options \"root=PARTUUID=${UUID} rw rootflags=subvol=@root add_efi_memmap\"
}
" > /boot/EFI/Boot/refind.conf


