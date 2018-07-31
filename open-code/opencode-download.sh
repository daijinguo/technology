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
if [ ! -d "01.NiceVieoPlayer" ]; then
    echo "download the NiceVieoPlayer ..."
    git clone https://github.com/xiaoyanger0825/NiceVieoPlayer.git 01.NiceVieoPlayer
fi

# I.2  ijkplayer
if [ ! -d "02.ijkplayer" ]; then
    echo "https://github.com/Bilibili/ijkplayer.git"
    git clone https://github.com/Bilibili/ijkplayer.git 02.ijkplayer
fi

# I.3 ExoPlayer
if [ ! -d "03.ExoPlayer" ]; then
    echo "https://github.com/google/ExoPlayer.git"
    git clone https://github.com/google/ExoPlayer.git 03.ExoPlayer
fi


# part I} ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


cd $DEF_DIR
# part II{ +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
mkdir -p module
cd module

# II.1  360RePlugin
if [ ! -d "01-360RePlugin" ]; then
   echo "download the 360RePlugin ..."
   git clone https://github.com/Qihoo360/RePlugin.git 01-360RePlugin
fi

# II.2  ModularizationArchitecture
if [ ! -d "02.ModularizationArchitecture" ]; then
   echo "download the ModularizationArchitecture ..."
   git clone https://github.com/SpinyTech/ModularizationArchitecture.git 02.ModularizationArchitecture
fi

# II.3  DDComponentForAndroid
if [ ! -d "03.DDComponentForAndroid" ]; then
   echo "download the DDComponentForAndroid ..."
   git clone https://github.com/luojilab/DDComponentForAndroid.git 03.DDComponentForAndroid
fi

# II.4  fat-aar-plugin
if [ ! -d "04.fat-aar-plugin" ]; then
   echo "download the fat-aar-plugin ..."
   git clone https://github.com/Vigi0303/fat-aar-plugin.git 04.fat-aar-plugin
fi

# II.5  fat-aar-plugin
if [ ! -d "05.fataar-gradle-plugin" ]; then
   echo "download the 05.fataar-gradle-plugin ..."
   git clone https://github.com/Mobbeel/fataar-gradle-plugin.git 05.fataar-gradle-plugin
fi

# II.5  AndroidModulePattern
if [ ! -d "05.AndroidModulePattern" ]; then
   echo "download the fat-aar-plugin ..."
   git clone https://github.com/guiying712/AndroidModulePattern.git 05.AndroidModulePattern
fi

# II.6  ComponentCaller
echo "https://github.com/luckybilly/CC"
if [ ! -d "06.ComponentCaller" ]; then
   echo "download the fat-aar-plugin ..."
   git clone https://github.com/guiying712/AndroidModulePattern.git 06.ComponentCaller
fi

# II.7  VirtualAPK
echo "https://github.com/didi/VirtualAPK.git"
if [ ! -d "07.VirtualAPK" ]; then
   echo "download the fat-aar-plugin ..."
   git clone https://github.com/didi/VirtualAPK.git 07.VirtualAPK
fi


# part II} +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


cd $DEF_DIR
# part III{ +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# part III google sample
DEF_GOOGLESAMPLE_DIR=$DEF_DIR/googlesamples
mkdir -p $DEF_GOOGLESAMPLE_DIR
cd $DEF_GOOGLESAMPLE_DIR

# III.1  androidtv-Leanback
if [ ! -d "01.androidtv-Leanback" ]; then
   echo "download the androidtv-Leanback ..."
   git clone https://github.com/googlesamples/androidtv-Leanback.git 01.androidtv-Leanback
fi

# III.2  AndroidTVappTutorial
if [ ! -d "02.AndroidTVappTutorial" ]; then
   echo "download the AndroidTVappTutorial ..."
   git clone https://github.com/corochann/AndroidTVappTutorial.git 02.AndroidTVappTutorial
fi

# III.3  android-architecture
if [ ! -d "03.android-architecture" ]; then
   echo "download the android-architecture ..."
   git clone https://github.com/googlesamples/android-architecture.git 03.android-architecture
fi

# III.4  android-BasicMediaDecoder
if [ ! -d "04.android-BasicMediaDecoder" ]; then
   echo "download the android-BasicMediaDecoder ..."
   git clone https://github.com/googlesamples/android-BasicMediaDecoder.git 04.android-BasicMediaDecoder
fi

# III.5  android-MediaBrowserService
if [ ! -d "05.android-MediaBrowserService" ]; then
   echo "download the android-MediaBrowserService ..."
   git clone https://github.com/googlesamples/android-MediaBrowserService.git 05.android-MediaBrowserService
fi

# III.6  leanback-showcase
if [ ! -d "06.leanback-showcase" ]; then
   echo "download the leanback-showcase ..."
   git clone https://github.com/googlesamples/leanback-showcase.git 06.leanback-showcase
fi

# part III} +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


cd $DEF_DIR
# part IV{ +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# other
mkdir -p other
cd other

# IV.1  AndroidNativeService-meets-ASHMEM
if [ ! -d "01.ashmem" ]; then
   echo "download the AndroidNativeService-meets-ASHMEM ..."
   git clone https://github.com/alximw/AndroidNativeService-meets-ASHMEM.git 01.ashmem
fi

# IV.2  kotlin-life
if [ ! -d "02.kotlin-life" ]; then
   echo "download the kotlin-life ..."
   git clone https://github.com/Cuieney/kotlin-life.git 02.kotlin-life
fi


# part IV} +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

cd $DEF_DIR
# part V{ +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# this is my self project
mkdir -p myselft
cd myselft

if [ ! -d "01.androidplayer" ]; then
   echo "download androidplayer  ..."
   git clone https://github.com/goto0x00/androidplayer.git 01.androidplayer
   cd 01.androidplayer
   git config user.name "YourName"
   git config user.email "YourEmail@host.com"
   cd ..
fi

if [ ! -d "02.affmpeg" ]; then
   echo "https://github.com/daijinguo/affmpeg.git"
   git clone https://github.com/daijinguo/affmpeg.git 02.affmpeg
   cd 02.affmpeg
   git config user.name "YourName"
   git config user.email "YourEmail@host.com"
   cd ..
fi

#if [ ! -d "03.dplayer" ]; then
#   echo "https://git.coding.net/gooogle/dplayer.git"
#   git clone https://git.coding.net/gooogle/dplayer.git 03.dplayer
#fi

if [ ! -d "03.sdl-game" ]; then
   echo "https://git.coding.net/gooogle/dplayer.git"
   git clone https://github.com/daijinguo/sdl-game.git 03.sdl-game
   cd 03.sdl-game
   git config user.name "YourName"
   git config user.email "YourEmail@host.com"
   cd ..
fi

if [ ! -d "04.aplayer" ]; then
  #statements
  echo "https://gitlab.com/AndroidOpenCode/aplayer.git"
  git clone https://gitlab.com/AndroidOpenCode/aplayer.git 04.aplayer
  cd 04.aplayer
  git config user.name "YourName"
  git config user.email "YourEmail@host.com"
  cd ..
fi

if [ ! -d "05.opengl" ]; then
  #statements
  echo "https://gitlab.com/AndroidOpenCode/LearnOpenGL.git"
  git clone https://gitlab.com/AndroidOpenCode/LearnOpenGL.git 05.opengl
  cd 05.opengl
  git config user.name "YourName"
  git config user.email "YourEmail@host.com"
  cd ..
fi

if [ ! -d "06.plugins_01" ]; then  
  echo "https://github.com/daijinguo/sn_wpp_compile.git"
  git clone https://github.com/daijinguo/sn_wpp_compile.git 06.plugins_01
  cd 06.plugins_01
  git config user.name "YourName"
  git config user.email "YourEmail@host.com"
  cd ..
fi

# part V} +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


