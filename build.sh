#! /bin/sh

uname -m | grep -qs ".*86.*"
if [ 0 -eq $? ]; then
    export LANG=en_US.UTF-8
    export CROSS_COMPILE=`pwd`/../toolchain/aarch64-linux-android-9.1/bin/aarch64-elf-
    export CROSS_COMPILE_ARM32=`pwd`/../toolchain/arm-eabi-4.8/bin/arm-eabi-
    export ARCH=arm64
    export SUBARCH=arm64
    export PATH=/opt/sdk/usr/bin:/opt/sdk/bin:$PATH
fi

if [ ! -f out/.config ]; then
    make O=out mrproper
    make O=out faber_defconfig
fi

if [ "x" != "x$1" ]; then
    make O=out "$@"
else
    make O=out -j9
fi
