#!/bin/bash

echo Enter hostname...
read HOSTNAME

echo ${HOSTNAME} > /etc/hostname
ln -sf /usr/share/zoneinfo/Asia/Yekaterinburg /etc/localtime
hwclock --systohc

echo "127.0.0.1  localhost
::1        localhost
127.0.1.1  ${HOSTNAME}.localdomain   ${HOSTNAME}
" > /etc/hosts

echo LANG=en_US.UTF-8 > /etc/locale.conf

sed -i '/^#ru_RU\.UTF-8.*/s/^#//' /etc/locale.gen
sed -i '/^#en_US\.UTF-8.*/s/^#//' /etc/locale.gen
locale-gen
passwd




