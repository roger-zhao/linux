# !/bin/bash

date
echo "==================================================================================="
echo "start execute $0"
echo "make distclean"
# make clean
echo "make .config"
# make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- apm_defconfig 
cp apm_defconfig .config
echo "make kernel zImage"
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage -j4
echo "make dtbs"
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- dtbs 
echo "make modules"
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- modules -j4
echo "install zImage dtbs & modules"
rm -rf output; mkdir -p output; mkdir -p output/dtbs output/dts
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- modules_install INSTALL_MOD_PATH=`pwd`/output
cp arch/arm/boot/zImage `pwd`/output
cp arch/arm/boot/dts/*.dtb `pwd`/output/dtbs
cp -rf arch/arm/boot/dts `pwd`/output/dts
cp .config `pwd`/output/kernel_config

echo "tar zImage dtbs & modules"
cd `pwd`/output; tar -czvf ../`date +%Y%m%d`_apm-kernel-4.1.13-rt.tar.gz *
cd -
rm -rf output

echo "end execute $0"
echo "==================================================================================="
