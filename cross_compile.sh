# !/bin/bash

date
echo "==================================================================================="
echo "start execute $0"
echo "make distclean"
export CC=/home/roger/Test/BBB-kernel-git/RobertCNelson/bb-kernel/toolchain-roger/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux/bin/arm-linux-gnueabihf-
make distclean 
echo "make .config"
# make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bb.org_defconfig 
cp apm_defconfig .config
echo "make kernel zImage"
# make ARCH=arm zImage 
#make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage
make ARCH=arm CROSS_COMPILE=$CC zImage
echo "make dtbs"
make ARCH=arm  dtbs 
#make ARCH=arm  dtbs 
echo "make modules"
make ARCH=arm CROSS_COMPILE=$CC modules 
#make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- modules 
echo "install zImage dtbs & modules"
rm -rf output; mkdir -p output; mkdir -p output/dtbs
make ARCH=arm  modules_install INSTALL_MOD_PATH=`pwd`/output
#make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- modules_install INSTALL_MOD_PATH=`pwd`/output
cp arch/arm/boot/zImage `pwd`/output
cp .config `pwd`/output/kernel_config
cp arch/arm/boot/dts/*.dtb `pwd`/output/dtbs
cp arch/arm/boot/dts/am335x-boneblack-forSMT.dts `pwd`/output/dtbs
cp arch/arm/boot/dts/Makefile `pwd`/output/dtbs
cp arch/arm/boot/dts/am335x-bone-common.dtsi `pwd`/output/dtbs

echo "tar zImage dtbs & modules"
cd `pwd`/output; tar -czvf ../`date +%Y%m%d`_apm-kernel-4.1.18.tar.gz *

echo "end execute $0"
echo "==================================================================================="
