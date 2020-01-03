#!/bin/bash


o=defaults,x-mount.mkdir
o_btrfs=$o,compress=lzo,ssd,noatime

umount -R /mnt

echo Mounting subvolumes

mount -t btrfs -o subvol=root,$o_btrfs LABEL=system /mnt
mount -t btrfs -o subvol=home,$o_btrfs LABEL=system /mnt/home
mount -t btrfs -o subvol=snapshots,$o_btrfs LABEL=system /mnt/.snapshots

mount LABEL=EFI /mnt/boot

echo Done!



