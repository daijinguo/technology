#!/bin/bash

DEF_DIR=~/worksapce/github
# make the default worksapce/github directory
mkdir -p $DEF_DIR
cd $DEF_DIR

# now we at the directory ~/worksapce/github

# part I{ ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# android player
mkdir -p android/player
cd android/player

# I.1 NiceVieoPlayer
if [ ! -d "01-nvp" ]; then
    echo "download the NiceVieoPlayer ..."
    git clone https://github.com/xiaoyanger0825/NiceVieoPlayer.git 01-nvp
fi

# I.2  HMCPlayer
if [ ! -d "02-hmcplayer" ]; then
    echo "download the HMCPlayer ..."
    git clone https://github.com/emacs2012/HMCPlayer.git 02-hmcplayer
fi

# I.3  ijkplayer
if [ ! -d "ijkplayer" ]; then
    echo "https://github.com/Bilibili/ijkplayer.git"
    git clone https://github.com/Bilibili/ijkplayer.git ijkplayer
fi

# I.4 ExoPlayer
if [ ! -d "ExoPlayer" ]; then
    echo "https://github.com/google/ExoPlayer.git"
    git clone https://github.com/google/ExoPlayer.git
fi


# part I} ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


cd $DEF_DIR
# part II{ +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
mkdir -p module
cd module

# II.1  HMCPlayer
if [ ! -d "01-360RePlugin" ]; then
   echo "download the 360RePlugin ..."
   git clone https://github.com/Qihoo360/RePlugin.git 01-360RePlugin
fi

# II.2  ModularizationArchitecture
if [ ! -d "02-ma" ]; then
   echo "download the ModularizationArchitecture ..."
   git clone https://github.com/SpinyTech/ModularizationArchitecture.git 02-ma
fi

# II.3  DDComponentForAndroid
if [ ! -d "03-ddc" ]; then
   echo "download the DDComponentForAndroid ..."
   git clone https://github.com/luojilab/DDComponentForAndroid.git 03-ddc
fi

# II.4  fat-aar-plugin
if [ ! -d "04-fap" ]; then
   echo "download the fat-aar-plugin ..."
   git clone https://github.com/Vigi0303/fat-aar-plugin.git 04-fap
fi

# II.5  AndroidModulePattern
if [ ! -d "05-ModulePattern" ]; then
   echo "download the fat-aar-plugin ..."
   git clone https://github.com/guiying712/AndroidModulePattern.git 05-ModulePattern
fi

# II.6  ComponentCaller
echo "https://github.com/luckybilly/CC"
if [ ! -d "06-ComponentCaller" ]; then
   echo "download the fat-aar-plugin ..."
   git clone https://github.com/guiying712/AndroidModulePattern.git 06-ComponentCaller
fi

# II.7  VirtualAPK
echo "https://github.com/didi/VirtualAPK.git"
if [ ! -d "VirtualAPK" ]; then
   echo "download the fat-aar-plugin ..."
   git clone https://github.com/didi/VirtualAPK.git VirtualAPK
fi


# part II} +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


cd $DEF_DIR
# part III{ +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# part III google sample
DEF_GOOGLESAMPLE_DIR=$DEF_DIR/googlesamples
mkdir -p $DEF_GOOGLESAMPLE_DIR
cd $DEF_GOOGLESAMPLE_DIR

# III.1  androidtv-Leanback
if [ ! -d "01-tv.leanback" ]; then
   echo "download the androidtv-Leanback ..."
   git clone https://github.com/googlesamples/androidtv-Leanback.git 01-tv.leanback
fi

# III.2  AndroidTVappTutorial
if [ ! -d "02-tv.tutorial" ]; then
   echo "download the AndroidTVappTutorial ..."
   git clone https://github.com/corochann/AndroidTVappTutorial.git 02-tv.tutorial
fi

# III.3  android-architecture
if [ ! -d "03-architecture" ]; then
   echo "download the android-architecture ..."
   git clone https://github.com/googlesamples/android-architecture.git 03-architecture
fi

# III.4  android-BasicMediaDecoder
if [ ! -d "04-basicMediaDecoder" ]; then
   echo "download the android-BasicMediaDecoder ..."
   git clone https://github.com/googlesamples/android-BasicMediaDecoder.git 04-basicMediaDecoder
fi

# III.5  android-MediaBrowserService
if [ ! -d "05-MediaBrowserService" ]; then
   echo "download the android-MediaBrowserService ..."
   git clone https://github.com/googlesamples/android-MediaBrowserService.git 05-MediaBrowserService
fi

# III.6  leanback-showcase
if [ ! -d "06-ls" ]; then
   echo "download the leanback-showcase ..."
   git clone https://github.com/googlesamples/leanback-showcase.git 06-ls
fi

# part III} +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


cd $DEF_DIR
# part IV{ +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# other
mkdir -p other
cd other

# IV.1  AndroidNativeService-meets-ASHMEM
if [ ! -d "01-ashmem" ]; then
   echo "download the AndroidNativeService-meets-ASHMEM ..."
   git clone https://github.com/alximw/AndroidNativeService-meets-ASHMEM.git 01-ashmem
fi

# IV.2  kotlin-life
if [ ! -d "02-kf" ]; then
   echo "download the kotlin-life ..."
   git clone https://github.com/Cuieney/kotlin-life.git 02-kf
fi


# part IV} +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

cd $DEF_DIR
# part V{ +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# this is my self project
mkdir -p myselft
cd myselft

if [ ! -d "androidplayer" ]; then
   echo "download androidplayer  ..."
   git clone https://github.com/goto0x00/androidplayer.git
fi

if [ ! -d "affmpeg" ]; then
   echo "https://github.com/goto0x00/affmpeg.git"
   git clone https://github.com/goto0x00/affmpeg.git
fi

if [ ! -d "dplayer" ]; then
   echo "https://git.coding.net/gooogle/dplayer.git"
   git clone https://git.coding.net/gooogle/dplayer.git
fi

# part V} +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


