#!/bin/bash

# Install prerequisites
sudo yum install -y ncurses-devel make gcc bc bison flex openssl-devel elfutils-libelf-devel rpm-build

# get latest stable kernel (2020-02-26)
cd ~
curl https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.5.6.tar.xz -o linux-5.5.6.tar.xz

# extract kernel
tar xvf linux-5.5.6.tar.xz

# configure kernel
cd linux-5.5.6
cp -v /boot/config-"$(uname -r)" .config
make olddefconfig

# build rmp
make -j "$(nproc)" rpm-pkg

# install linux kernel
sudo rpm -iUv ~/rpmbuild/RPMS/x86_64/*.rpm

# Reboot VM
shutdown -r now
