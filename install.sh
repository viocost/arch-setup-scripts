#!/bin/bash

pacstrap /mnt base base-devel linux linux-firmware btrfs-progs vim sudo dhcpcd netctl 

genfstab -U /mnt > /mnt/etc/fstab

cp init-grub.sh /mnt/root
cp stuff.sh /mnt/root


arch-chroot /mnt


