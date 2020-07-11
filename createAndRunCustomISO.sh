#!/bin/bash
# applies custom settings, files and packages to the airootfs
# then builds the ISO image using the copied livecd/build.sh

if [ $# -ne 1 ];
then
    echo "requires the target output directory to copy the livecd template files into"
    exit
fi

#cp achiso/releng
cp -r /usr/share/archiso/configs/releng "$1/livecd"

#patch customize-airootfs.sh
cp customization-parts/customize_airootfs.sh "$1/livecd/airootfs/root/"

#cp skel
cp -r customization-parts/skel/ "$1/livecd/airootfs/etc/"

#cp custom configs
cp customization-parts/hostname customization-parts/locale.conf "$1/livecd/airootfs/etc/"

#add custom packages
cat customization-parts/packages.txt >> "$1/livecd/packages.x86_64"

#add helper scripts to users home
cp helper-scripts/*.sh "$1/livecd/airootfs/etc/skel"

#prepare and run the build.sh
sudo chown -R root:root "$1/livecd/"
cd "$1/livecd/" && sudo ./build.sh -v

