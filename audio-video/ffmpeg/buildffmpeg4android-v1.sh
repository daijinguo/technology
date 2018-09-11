#!/bin/sh


NDK_HOME=~/tools/google/sdk/ndk-bundle

PLATFORMS_DIR=$NDK_HOME/platforms

PLATFORM_CAN_USE_TMP=`find $PLATFORMS_DIR -name "android-*" -type d -exec basename {} \;`
PLATFORM_CAN_USE=`echo "$PLATFORM_CAN_USE_TMP" | tr ' ' '\n' | sort -n -k 2 -t - -r`

tmpDef=`echo $PLATFORM_CAN_USE | cut -d'-' -f 2 | cut -d' ' -f 1`
PLATFORM_CODE=$tmpDef
PLATFORM=android-$PLATFORM_CODE

echo $PLATFORM_DEF

CURRENT_DIR=`pwd`
SRC_DIR=$CURRENT_DIR

NDK_EXPORT=$SRC_DIR/0x00.ndk
rm -rf $NDK_EXPORT
mkdir -p $NDK_EXPORT

C_PREFIX_STR=arm-linux-androideabi-

ARCH=arm
ABI_LIST="armeabi armeabi-v7a arm64-v8a"
ABI=armeabi
COMPILE_DEF=gcc
CONFIG_COMPILE=

function getAbi()
{
    local OK=N
    for i in $ABI_LIST
    do
        if [ "$i" = "$ABI" ]; then
            OK=Y
            break
        fi
    done

    if [ "N" = "$OK" ]; then
        ABI=armeabi
        echo "    Warn: Wrong ABI, use '$ABI' for default"
    fi

    if test "$ABI" = "armeabi" -o "$ABI" = "armeabi-v7a" ; then
        ARCH=arm
    else
        ARCH=arm64
        C_PREFIX_STR=aarch64-linux-android-
    fi
}

function getCompile()
{
    if [ "$COMPILE_DEF" != "gcc" -a "$COMPILE_DEF" != "clang" ]; then
        COMPILE_DEF=gcc
    fi
}


while getopts "C:A:Mh" opt;
do
    case $opt in
        C)
            COMPILE_DEF=$OPTARG
            getCompile
        ;;
        A)
            ABI=$OPTARG
            getAbi
        ;;
        M)
            COMPILE_ONLY=Y
        ;;
        h)
            help
        ;;
        \?)
            help
        ;;
    esac
done

$NDK_HOME/build/tools/make-standalone-toolchain.sh \
    --arch=$ARCH \
    --install-dir=$NDK_EXPORT \
    --platform=$PLATFORM \
    --use-llvm \
    --force


export TMPDIR=$SRC_DIR/0x01.tmp
rm -rf $TMPDIR
mkdir -p $TMPDIR
echo $TMPDIR

echo

PREFIX=$SRC_DIR/0x02.out
rm -rf $PREFIX
mkdir -p $PREFIX

SYSROOT=$NDK_EXPORT/sysroot
C_PREFIX=$NDK_EXPORT/bin/$C_PREFIX_STR
#export CC=$COMPILE_DEF
#CC=$COMPILE_DEF

if [ "$COMPILE_DEF" = "clang" ]; then
    if [ "$ARCH" = "arm64" ];then
        CONFIG_COMPILE="--cc=$NDK_EXPORT/bin/aarch64-linux-android-clang --cxx=$NDK_EXPORT/bin/aarch64-linux-android-clang++"
    else
        CONFIG_COMPILE="--cc=$NDK_EXPORT/bin/arm-linux-androideabi-clang --cxx=$NDK_EXPORT/bin/arm-linux-androideabi-clang++"
        #CONFIG_COMPILE="--cc=clang --cxx=clang++"
    fi
fi


echo "ARCH    : $ARCH"
echo "PLATFORM: $PLATFORM"
echo "TMPDIR  : $TMPDIR"
echo "PREFIX  : $PREFIX"
echo "SYSROOT : $SYSROOT"
echo "CC      : $CC"
echo "CONFIG_COMPILE: $CONFIG_COMPILE"
echo "C_PREFIX: $C_PREFIX"
echo


$SRC_DIR/configure \
    --target-os=android \
    --disable-doc \
    --disable-programs \
    --disable-ffmpeg \
    --disable-ffplay \
    --disable-ffprobe \
    --disable-ffserver \
    --disable-doc \
    --disable-static \
    --enable-shared \
    --enable-cross-compile \
    --arch=$ARCH \
    --prefix=$PREFIX \
    --sysroot=$SYSROOT \
    --cross-prefix=$C_PREFIX \
    $CONFIG_COMPILE


make clean
make
make install


