#!/bin/bash

echo "###############################################################"
echo "#    Fastboot ROM Flasher for OnePlus Pad 2 by inferno0230    #"
echo "###############################################################"
echo
echo "This script assumes you have the necessary drivers installed and fastboot is in your PATH."
echo "For context, 'fastboot --version' should return V33 or higher."
echo "Also, 'fastboot devices' should return your device serial number."
echo
read -p "Press Enter to continue..."

clear

echo "Make sure the device is in bootloader mode before continuing."
read -p "Press Enter to continue..."

clear

echo "Starting flash process..........."
echo
fastboot --set-active=a
echo
echo "Flashing images to bootloader..."
fastboot flash boot ./images/boot.img
fastboot flash dtbo ./images/dtbo.img
fastboot flash init_boot ./images/init_boot.img
fastboot flash modem ./images/modem.img
fastboot flash recovery ./images/recovery.img
fastboot flash vbmeta ./images/vbmeta.img
fastboot flash vbmeta_system ./images/vbmeta_system.img
fastboot flash vbmeta_vendor ./images/vbmeta_vendor.img
fastboot flash vendor_boot ./images/vendor_boot.img

echo
echo "Rebooting to FastbootD..."
fastboot reboot fastboot

output=$(fastboot getvar is-userspace 2>&1)
echo "Output: '$output'"

if echo "$output" | grep -q "^is-userspace: yes"; then
    echo "Device entered FastbootD mode"
else
    echo "Device failed to enter FastbootD mode. Aborting..."
    exit 1
fi

echo "Flashing firmware..."
fastboot flash --slot=all abl ./images/abl.img
fastboot flash --slot=all aop ./images/aop.img
fastboot flash --slot=all aop_config ./images/aop_config.img
fastboot flash --slot=all bluetooth ./images/bluetooth.img
fastboot flash --slot=all cpucp ./images/cpucp.img
fastboot flash --slot=all cpucp_dtb ./images/cpucp_dtb.img
fastboot flash --slot=all devcfg ./images/devcfg.img
fastboot flash --slot=all dsp ./images/dsp.img
fastboot flash --slot=all engineering_cdt ./images/engineering_cdt.img
fastboot flash --slot=all featenabler ./images/featenabler.img
fastboot flash --slot=all hyp ./images/hyp.img
fastboot flash --slot=all imagefv ./images/imagefv.img
fastboot flash --slot=all keymaster ./images/keymaster.img
fastboot flash --slot=all oplus_sec ./images/oplus_sec.img
fastboot flash --slot=all qupfw ./images/qupfw.img
fastboot flash --slot=all shrm ./images/shrm.img
fastboot flash --slot=all splash ./images/splash.img
fastboot flash --slot=all tz ./images/tz.img
fastboot flash --slot=all uefi ./images/uefi.img
fastboot flash --slot=all uefisecapp ./images/uefisecapp.img
fastboot flash --slot=all xbl ./images/xbl.img
fastboot flash --slot=all xbl_config ./images/xbl_config.img
fastboot flash --slot=all xbl_ramdump ./images/xbl_ramdump.img

echo
echo "Formatting partitions..."
for partition in my_bigball my_carrier my_engineering my_heytap my_manifest my_product my_region my_stock odm product system_dlkm system_ext vendor_dlkm; do
    fastboot delete-logical-partition "${partition}_a"
    fastboot delete-logical-partition "${partition}_b"
    fastboot delete-logical-partition "${partition}_a-cow"
    fastboot delete-logical-partition "${partition}_b-cow"
    fastboot create-logical-partition "${partition}_a" 1
    fastboot create-logical-partition "${partition}_b" 1
done

echo
echo "Flashing partitions..."
for partition in my_preload my_company vendor_dlkm vendor system_ext system_dlkm system product odm my_stock my_region my_product my_manifest my_heytap my_carrier my_bigball my_engineering; do
    fastboot flash "${partition}" ./images/"${partition}.img"
done
fastboot -w

echo
echo "Flashing complete. If no errors occurred, you can format data and reboot to the system."
echo "Otherwise, reboot to bootloader and reflash."
echo
read -p "Press Enter to exit..."
