#!/bin/bash

echo "You have to edit this install script or take a look at what it does"
echo "if you have done so, remove the exit on the line below and run it (again)"
exit

# change $DEVICE according to your hard drive target (e.g. /dev/sda, /dev/nvme0n1)
DEVICE="/dev/sda"
# set this to false if you don't require UEFI boot
UEFI="true"

# erase previous MBR and GPT paritions
sgdisk -Z $DEVICE

# create an EFI partition (1:) and the main partition (2:)
sgdisk -n 1:0:+512M $DEVICE
sgdisk -n 2:0:+9G $DEVICE

# change the types of previously created partitions
if [ "$UEFI" == "true" ];
then
    sgdisk -t 1:ef00 $DEVICE
else
    sgdisk -t 1:8200 $DEVICE
fi
sgdisk -t 2:8300 $DEVICE

# mount the partitions
# CARE! in case your device is /dev/nvme0n1 put a 'p' in front of the number
mount "${DEVICE}2" /mnt
mkdir /mnt/boot/
mount "${DEVICE}1" /mnt/boot

rsync -aAXvP /* /mnt --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found,/.gvfs}
cp -avT /run/archiso/bootmnt/arch/boot/$(uname -m)/vmlinuz /mnt/boot/vmlinuz-linux
sed -i 's/Storage=volatile/#Storage=auto/' /mnt/etc/systemd/journald.conf
rm /mnt/etc/udev/rules.d/81-dhcpcd.rules
rm /mnt/root/{.automated_script.sh,.zlogin}
rm -r /mnt/etc/systemd/system/{choose-mirror.service,pacman-init.service,etc-pacman.d-gnupg.mount,getty@tty1.service.d}
rm /mnt/etc/systemd/scripts/choose-mirror
chmod 700 /mnt/root
genfstab /mnt >> /mnt/etc/fstab && cat /mnt/etc/fstab
arch-chroot /mnt /bin/bash
