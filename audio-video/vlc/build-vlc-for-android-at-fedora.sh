#!/bin/bash

# this scrpit only for build vlc for android at fedora os
# you can visit the build help document at web address
# https://wiki.videolan.org/AndroidCompile/
# this article build base at Ubuntu, so if you want build at fedora
# must install all follow soft


current_user=`whoami`

function os_info() {
    release_name=`lsb_release -a | awk 'NR==2 {print $3}'`
    release_code=`lsb_release -a | awk 'NR==4 {print $2}'`

    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "    system info : $release_name - $release_code"
    echo "    current user: $current_user"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
}

# show the system and user information
os_info

dnf install -y automake autoconf
dnf install -y ant
dnf install -y gettext-devel 
dnf install -y cmake
#like debian os install build-essential
dnf groupinstall -y "Development Tools"
dnf install -y libtool 
dnf install -y flex
dnf install -y patch 
dnf install -y pkg-config
dnf install -y protobuf-compiler 
dnf install -y ragel
dnf install -y subversion
dnf install -y unzip
dnf install -y git gitk



if [ "$current_user" == "root" ]; then
    read -p "You are run at root user not recommend, continue?[Yy/Nn] " gn
    if [ "$gn" == "N" ] || [ "$gn" == "n" ]; then
        exit 0
    fi
fi

# go to directory ~/workspace
mkdir -p ~/worksapce/
cd ~/worksapce/

# git clone the code
git clone https://code.videolan.org/videolan/vlc-android.git
cd vlc-android

chmod +x compile.sh

# exec the compilte script
sh compile.sh -l release
