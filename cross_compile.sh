# !/bin/bash

date
echo "==================================================================================="
echo "start execute $0"
echo "make clean"
make distclean 
echo "make .config"
# make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bb.org_defconfig 
cp apm_defconfig .config
echo "make kernel zImage"
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- zImage
#make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage
echo "make dtbs"
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- dtbs 
#make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- dtbs 
echo "make modules"
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- modules
#make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- modules 
echo "install zImage dtbs & modules"
rm -rf output; mkdir -p output; mkdir -p output/dtbs
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- modules_install INSTALL_MOD_PATH=`pwd`/output
#make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- modules_install INSTALL_MOD_PATH=`pwd`/output
cp arch/arm/boot/zImage `pwd`/output
cp .config `pwd`/output/kernel_config
cp arch/arm/boot/dts/*.dtb `pwd`/output/dtbs
# cp arch/arm/boot/dts/am335x-boneblack-forSMT.dts `pwd`/output/dtbs
cp arch/arm/boot/dts/Makefile `pwd`/output/dtbs
# cp arch/arm/boot/dts/am335x-bone-common.dtsi `pwd`/output/dtbs

echo "tar zImage dtbs & modules"
cd `pwd`/output; tar -czvf ../`date +%Y%m%d`_apm-kernel-4.1.13_apm-defconfig_ref-ti-r36-inDebian8.tar.gz *

echo "end execute $0"
echo "==================================================================================="
