#!/bin/bash

#
# help webside https://pocoproject.org/docs/99300-AndroidPlatformNotes.html
#

# NDK_HOME=/home/patrick/tools/google/ndk/android-ndk-r16b
NDK_HOME=/home/patrick/tools/google/sdk/ndk-bundle
PLATFORMS_DIR=$NDK_HOME/platforms

PLATFORM=android-28

ARCH=arm
android_abi=armeabi-v7a

echo $1

if [ "$1" = "arm64" ]; then
    ARCH=arm64
    android_abi=arm64-v8a
fi


PWD=$(pwd)
NDK_EXPORT=$PWD/mybuild/$ARCH
POCO_OUT=$PWD/mybuild/out/$ARCH

# make directory
mkdir -p $NDK_EXPORT
mkdir -p $POCO_OUT

#
# make build tool dir
$NDK_HOME/build/tools/make-standalone-toolchain.sh \
    --arch=$ARCH \
    --install-dir=$NDK_EXPORT \
    --platform=$PLATFORM \
    --force

export PATH=$PATH:$NDK_EXPORT/bin

#
# 需要注意:
# 不能使用软链接的路径，需要实际路径
export POCO_BASE=/work/me/workspace/c++/ndk/poco-1.9.1

cd $POCO_BASE
./configure --no-samples \
            --no-tests \
            --config=Android \
            --shared \
            --no-prefix \
            --no-ipv6 \
            --minimal \
            --prefix=$POCO_OUT

make clean
make -s -j4 ANDROID_ABI=$android_abi
make install


