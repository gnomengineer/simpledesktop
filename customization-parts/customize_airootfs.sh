#!/bin/bash

set -e -u

# set GB to locale
sed -i 's/#\(en_GB\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

# set timezone to CEST
ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime

usermod -s /usr/bin/zsh root

# create user, copy skel into its home and correct ownership
useradd -m -p "" -G "users,tty,wheel,uucp,log,lock,dbus,network,video,audio,optical,storage,power" -s /bin/bash gnomengineer
cp -aT /etc/skel/ /home/gnomengineer/
chown -R gnomengineer:gnomengineer /home/gnomengineer

chmod 700 /root

sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

systemctl enable pacman-init.service choose-mirror.service dhcpcd.service
systemctl set-default multi-user.target
