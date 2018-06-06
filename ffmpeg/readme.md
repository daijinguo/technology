
# how to use this script

## set your ndk home directory

1. open this buildffmpeg4android-v1.sh find NDK_HOME set your own directory
```shell
#!/bin/sh

NDK_HOME=~/tools/google/sdk/ndk-bundle

PLATFORMS_DIR=$NDK_HOME/platforms
```

| ndk version                                                                                                               |
|:--------------------------------------------------------------------------------------------------------------------------|
| [android-ndk-r17-beta1-linux-x86_64.zip](https://dl.google.com/android/repository/android-ndk-r17-beta1-linux-x86_64.zip) |
| [android-ndk-r16b-linux-x86_64.zip](https://dl.google.com/android/repository/android-ndk-r16b-linux-x86_64.zip)           |
| [android-ndk-r15c-linux-x86_64.zip](https://dl.google.com/android/repository/android-ndk-r15c-linux-x86_64.zip)           |
| [android-ndk-r14b-linux-x86_64.zip](https://dl.google.com/android/repository/android-ndk-r14b-linux-x86_64.zip)           |

2. command
copy this buildffmpeg4android-v1.sh to your ffmpeg source directory

if you want build with gcc add -C gcc
if you want build with clang add -C clang

if you want build different abi please use follow one of it:  
+ armeabi      -A armeabi
+ armeabi-v7a  -A armeabi-v7a
+ arm64-v8a    -A arm64-v8a
maybe armeabi and armeabi-v7a are same

so there 4 combinations:  

| Command                    | Readme                |
| -------------------------- | --------------------- |
| x.sh -A armeabi -C gcc     | OK, this the default  |
| x.sh -A arm64-v8a -C gcc   | OK                    |
| x.sh -A arm64-v8a -C clang | OK                    |
| x.sh -A armeabi -C clang   | not work for this one |

