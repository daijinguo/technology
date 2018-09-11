#!/bin/bash

# this script for ffmpeg 4.0
# some webside addesss
# https://blog.csdn.net/leixiaohua1020/article/details/47011021
# https://blog.csdn.net/sunwutian0325/article/details/53502025


NDK_HOME=~/tools/google/sdk/ndk-bundle
PLATFORMS_DIR=$NDK_HOME/platforms

PLATFORM_CAN_USE_TMP=`find $PLATFORMS_DIR -name "android-*" -type d -exec basename {} \;`
PLATFORM_CAN_USE=`echo "$PLATFORM_CAN_USE_TMP" | tr ' ' '\n' | sort -n -k 2 -t - -r`

tmpDef=`echo $PLATFORM_CAN_USE | cut -d'-' -f 2 | cut -d' ' -f 1`
PLATFORM_CODE=$tmpDef
PLATFORM=android-$PLATFORM_CODE

CURRENT_DIR=`pwd`
SRC_DIR=$CURRENT_DIR

NDK_EXPORT=$SRC_DIR/build/ndk
rm -rf $NDK_EXPORT && mkdir -p $NDK_EXPORT
sleep 2

C_PREFIX_STR=arm-linux-androideabi-
ARCH=arm
ABI_LIST="armeabi armeabi-v7a arm64-v8a"
ABI=armeabi
COMPILE_DEF=gcc
CONFIG_COMPILE=
LD=
STRIP=
ONE_SHARE_SO=N

function getAbi
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

function getCompile
{
    if [ "$COMPILE_DEF" != "gcc" -a "$COMPILE_DEF" != "clang" ]; then
        COMPILE_DEF=gcc
    fi
}

function help
{
    cat <<@EOF
    $0 usage:
        -O build one share file 'libffmpeg.so', default not for share one
        -A android arm abi, one of the follow:
            armeabi armeabi-v7a arm64-v8a, default armeabi
        -C compile one of the follow:
            gcc clang, default gcc
@EOF
    exit 0
}


while getopts "C:A:Oh" opt;
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
        O)
            ONE_SHARE_SO=Y
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


export TMPDIR=$SRC_DIR/build/tmp
rm -rf $TMPDIR && mkdir -p $TMPDIR
sleep 2

PREFIX=$SRC_DIR/build/out
rm -rf $PREFIX && mkdir -p $PREFIX
sleep 2

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

if [ "$ARCH" = "arm64" ];then
    LD=$NDK_EXPORT/bin/aarch64-linux-android-ld
    STRIP=$NDK_EXPORT/bin/aarch64-linux-android-strip
else
    LD=$NDK_EXPORT/bin/arm-linux-androideabi-ld
    STRIP=$NDK_EXPORT/bin/arm-linux-androideabi-strip
fi

echo "--------------------------------------------------"
echo "ARCH           : $ARCH"
echo "PLATFORM       : $PLATFORM"
echo "Al in one so   : $ONE_SHARE_SO"
echo "TMPDIR         : $TMPDIR"
echo "PREFIX         : $PREFIX"
echo "SYSROOT        : $SYSROOT"
echo "CC             : $CC"
echo "CONFIG_COMPILE : $CONFIG_COMPILE"
echo "C_PREFIX       : $C_PREFIX"
echo "LD             : $LD"
echo "--------------------------------------------------"

goNext=N
while true;do
    read -p "Are you want to build with show information?[Yy/Nn] " ny
    case $ny in
        [Nn]* ) break;;
        [Yy]* ) goNext=Y; break;;
    esac
done

if [ "N" = "goNext" ];then
    exit 1
fi


SHARE_TYPE=
if [ "Y" = "$ONE_SHARE_SO" ];then
    SHARE_TYPE="--disable-shared --enable-static"
else
    SHARE_TYPE="--disable-static --enable-shared"
fi


$SRC_DIR/configure \
    --target-os=android \
    --disable-doc \
    --disable-programs \
    --disable-ffmpeg \
    --disable-ffplay \
    --disable-ffprobe \
    $SHARE_TYPE \
    --enable-cross-compile \
    --arch=$ARCH \
    --prefix=$PREFIX \
    --sysroot=$SYSROOT \
    --cross-prefix=$C_PREFIX \
    --extra-cflags="-O2 -fpic -DANDROID -Wfatal-errors -Wno-deprecated"
    $CONFIG_COMPILE


make clean
make
make install


### package this to one
if [ "Y" = "$ONE_SHARE_SO" ];then
    static_files=`find $PREFIX/lib -name "lib*.a" -type f`

    echo "will make the follow libs to one share lib"
    for str in $static_files;
    do
        echo "   $str"
    done
    sleep 4

    libgcc=
    if [ "$ARCH" = "arm64" ];then
        libgcc=$NDK_EXPORT/lib/gcc/aarch64-linux-android/4.9.x/libgcc.a
    else
        libgcc=$NDK_EXPORT/lib/gcc/arm-linux-androideabi/4.9.x/libgcc.a
    fi

    stripFile=
    if [ "$ARCH" = "arm64" ];then
        stripFile=$NDK_EXPORT/lib/gcc/aarch64-linux-android/4.9.x/libgcc.a
    else
        stripFile=$NDK_EXPORT/lib/gcc/arm-linux-androideabi/4.9.x/libgcc.a
    fi

    #echo $static_files
    $LD \
        -rpath-link=$SYSROOT/usr/lib \
        -L$SYSROOT/usr/lib \
        -soname libffmpeg.so -shared -nostdlib -Bsymbolic --whole-archive --no-undefined -o \
        $PREFIX/lib/libffmpeg.so \
        $static_files \
        -lc -lm -lz -ldl -llog --dynamic-linker=/system/bin/linker \
        $libgcc

    $STRIP $PREFIX/lib/libffmpeg.so
fi

# at last we change the directory
DST_DIR=$SRC_DIR/build_$COMPILE_DEF_$ABI

mv $SRC_DIR/build $DST_DIR
