#!/bin/bash

pacstrap /mnt base linux btrfs-progs vim sudo


genfstab -U /mnt > /mnt/etc/fstab

cp init-grub.sh /mnt/root
cp stuff.sh /mnt/root


arch-chroot /mnt


