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

zypper install -y automake autoconf
zypper install -y ant
zypper install -y gettext-devel 
zypper install -y cmake
#like debian os: apt-get install build-essential
#like fedora os: dnf groupinstall -y "Development Tools"
zypper install -y --type pattern devel_basis
zypper install -y libtool 
zypper install -y flex
zypper install -y patch 
zypper install -y pkg-config
# dnf install -y protobuf-compiler
# apt-get install -y protobuf-compiler
# replace by follow in opensuse
zypper install -y libprotobuf-c-devel libprotobuf-c1 libprotobuf-lite15 protobuf-c protobuf-devel
zypper install -y ragel
zypper install -y subversion
zypper install -y unzip
zypper install -y git gitk



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
