#!/bin/bash

# change $DEVICE according to your hard drive target
DEVICE="sda"
echo 'type=83' | sudo sfdisk /dev/$DEVICE
mkfs.ext4 /dev/$DEVICE
mount /dev/$DEVICE /mnt

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
