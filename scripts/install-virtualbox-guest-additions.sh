#!/bin/bash

# Install needed packages
PACKAGES="
dkms
build-essential
"
apt-get -y install $PACKAGES

# Mount the disk image
cd /tmp
mkdir /tmp/isomount
mount -t iso9660 -o loop /home/vagrant/VBoxGuestAdditions.iso /tmp/isomount

# Install the drivers
/tmp/isomount/VBoxLinuxAdditions.run

# Cleanup
umount isomount
rm -rf isomount /home/vagrant/VBoxGuestAdditions.iso
