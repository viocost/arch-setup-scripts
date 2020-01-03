#!/bin/bash
#
# Initializes refind configuration file
# Assumes that partlabel for root subvolume is set to system
#
# Must run as new installation root after arch-chroot


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


