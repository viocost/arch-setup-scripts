#!/bin/bash

pacman -Sy --noconfirm grub efibootmgr
grub-install --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg


