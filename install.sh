#!/bin/bash

pacstrap /mnt base base-devel btrfs-progs vim sudo intel-ucode wpa-supplicant


genfstab -U /mnt > /mnt/etc/fstab


