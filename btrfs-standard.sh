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

umount -R /mnt
swapoff -a
sgdisk --zap-all $1

echo Done. Creating new partition table



sgdisk --clear \
	--new=1:0:+550MiB  --typecode=1:ef00 --change-name=1:EFI \
	--new=2:0:+8GiB    --typecode=2:8200 --change-name=2:swap \
	--new=3:0:0        --typecode=3:8300 --change-name=3:system \
	$1

echo Partition table created. Creating file systems

sleep 2
echo Creating EFI fs...
mkfs.fat -F32 -n EFI /dev/disk/by-partlabel/EFI

sleep 2

echo Done. Creating swap  fs
mkswap -L swap /dev/disk/by-partlabel/swap

sleep 1
swapon -L swap 
sleep 1

echo Done. Creating btrfs system...
mkfs.btrfs --force --label system /dev/disk/by-partlabel/system
echo Done. Mounting...

sleep 1

o=defaults,x-mount.mkdir
o_btrfs=$o,compress=lzo,ssd,noatime

mount -t btrfs LABEL=system /mnt

echo Creating subvolumes...

btrfs subvolume create /mnt/root

sleep 1
btrfs subvolume create /mnt/home

sleep 1
btrfs subvolume create /mnt/snapshots

sleep 1

echo Done. Unmounting..

umount -R /mnt

echo Mounting subvolumes

sleep 1
mount -t btrfs -o subvol=root,$o_btrfs LABEL=system /mnt

sleep 1
mount -t btrfs -o subvol=home,$o_btrfs LABEL=system /mnt/home

sleep 1
mount -t btrfs -o subvol=snapshots,$o_btrfs LABEL=system /mnt/.snapshots

if [[ ! -d /mnt/boot ]]; then
	mkdir /mnt/boot
fi

mount LABEL=EFI /mnt/boot



