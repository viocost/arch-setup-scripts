#!/bin/bash

if [[ ! $1  ]]; then
	echo No device specified
	exit 1
elif [[ ! -b $1 ]]; then
	echo Device is not found
	exit 1
fi


echo "GPT partition scheme will be created on ${1}:
   1. 550Mb FAT32 system/efi 
   2. 8gb SWAP
   3. The rest of the drive system BTRFS
      / - root subvol
      /home - home subvol
      /.snapshots - snapshots sabvol

"

read -p "Press enter to continue..."


echo Clearing disk...

sgdisk --zap-all $1

echo Done. Creating new partition table



sgdisk --clear \
	--new=1:0:+550MiB  --typecode=1:ef00 --change-name=1:EFI \
	--new=2:0:+8GiB    --typecode=2:8200 --change-name=2:swap \
	--new=3:0:0        --typecode=3:8300 --change-name=3:system \
	$1

echo Partition table created. Creating file systems

echo Creating EFI fs...
mkfs.fat -F32 -n EFI /dev/disk/by-label/EFI

echo Done. Creating swap  fs
mkswap -L swap /dev/disk/by-label/swap
swapon -L swap 

echo Done. Creating btrfs system...
mkfs.btrfs --force --label system /dev/disk/by-label/system
echo Done. Mounting...


o=defaults.x-mount.mkdir
o_btrfs=$o,compress=lzo,ssd,noatime

mount -t btrfs LABEL=system /mnt

echo Creating subvolumes...

btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/snapshots

echo Done. Unmounting..

umount -R /mnt

echo Mounting subvolumes

mount -t btrfs -o subvol=root,$o_btrfs LABEL=system /mnt
mount -t btrfs -o subvol=home,$o_btrfs LABEL=system /mnt/home
mount -t btrfs -o subvol=snapshots,$o_btrfs LABEL=system /mnt/.snapshots




