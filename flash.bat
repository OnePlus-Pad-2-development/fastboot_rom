@echo off

title Fastboot ROM Flasher for OnePlus Pad 2 by @inferno0230

echo ###############################################################
echo #    Fastboot ROM Flasher for OnePlus Pad 2 by inferno0230    #
echo ###############################################################
echo
echo This script assumes you have nessesary driver installed and fastboot is in your env PATH,
echo for context, fastboot --version command should return V35 or higher,
echo and fastboot devices command should return your device serial number.
echo.

pause
echo READ AGAIN
pause
cls

echo Make sure device is in bootloader before continuing.

pause
cls

echo Starting flash process.........
echo.
fastboot --set-active=a
echo.
echo Flashing images to be flashed in bootloader
fastboot flash boot .\images\boot.img
fastboot flash dtbo .\images\dtbo.img
fastboot flash init_boot .\images\init_boot.img
fastboot flash modem .\images\modem.img
fastboot flash recovery .\images\recovery.img
fastboot flash vbmeta .\images\vbmeta.img
fastboot flash vbmeta_system .\images\vbmeta_system.img
fastboot flash vbmeta_vendor .\images\vbmeta_vendor.img
fastboot flash vendor_boot .\images\vendor_boot.img

echo.
echo Rebooting to FastbootD
fastboot reboot fastboot


for /f "tokens=2 delims=: " %%A in ('fastboot getvar is-userspace 2^>^&1') do (
    if "%%A"=="yes" (
        goto :flash_fastbootd
    ) else (
        echo Device failed to enter FastbootD mode
    echo aborting...
    pause
    goto :ext
    )
)

:flash_fastbootd
echo.
echo Flashing firmware
fastboot flash --slot=all abl .\images\abl.img
fastboot flash --slot=all aop .\images\aop.img
fastboot flash --slot=all aop_config .\images\aop_config.img
fastboot flash --slot=all bluetooth .\images\bluetooth.img
fastboot flash --slot=all cpucp .\images\cpucp.img
fastboot flash --slot=all cpucp_dtb .\images\cpucp_dtb.img
fastboot flash --slot=all devcfg .\images\devcfg.img
fastboot flash --slot=all dsp .\images\dsp.img
fastboot flash --slot=all engineering_cdt .\images\engineering_cdt.img
fastboot flash --slot=all featenabler .\images\featenabler.img
fastboot flash --slot=all hyp .\images\hyp.img
fastboot flash --slot=all imagefv .\images\imagefv.img
fastboot flash --slot=all keymaster .\images\keymaster.img
fastboot flash --slot=all oplus_sec .\images\oplus_sec.img
fastboot flash --slot=all qupfw .\images\qupfw.img
fastboot flash --slot=all shrm .\images\shrm.img
fastboot flash --slot=all splash .\images\splash.img
fastboot flash --slot=all tz .\images\tz.img
fastboot flash --slot=all uefi .\images\uefi.img
fastboot flash --slot=all uefisecapp .\images\uefisecapp.img
fastboot flash --slot=all xbl .\images\xbl.img
fastboot flash --slot=all xbl_config .\images\xbl_config.img
fastboot flash --slot=all xbl_ramdump .\images\xbl_ramdump.img

echo.
echo Formatting partitions
fastboot delete-logical-partition my_bigball_a
fastboot delete-logical-partition my_bigball_b
fastboot delete-logical-partition my_bigball_a-cow
fastboot delete-logical-partition my_bigball_b-cow
fastboot create-logical-partition my_bigball_a 1
fastboot create-logical-partition my_bigball_b 1
fastboot delete-logical-partition my_carrier_a
fastboot delete-logical-partition my_carrier_b
fastboot delete-logical-partition my_carrier_a-cow
fastboot delete-logical-partition my_carrier_b-cow
fastboot create-logical-partition my_carrier_a 1
fastboot create-logical-partition my_carrier_b 1
fastboot delete-logical-partition my_engineering_a
fastboot delete-logical-partition my_engineering_b
fastboot delete-logical-partition my_engineering_a-cow
fastboot delete-logical-partition my_engineering_b-cow
fastboot create-logical-partition my_engineering_a 1
fastboot create-logical-partition my_engineering_b 1
fastboot delete-logical-partition my_heytap_a
fastboot delete-logical-partition my_heytap_b
fastboot delete-logical-partition my_heytap_a-cow
fastboot delete-logical-partition my_heytap_b-cow
fastboot create-logical-partition my_heytap_a 1
fastboot create-logical-partition my_heytap_b 1
fastboot delete-logical-partition my_manifest_a
fastboot delete-logical-partition my_manifest_b
fastboot delete-logical-partition my_manifest_a-cow
fastboot delete-logical-partition my_manifest_b-cow
fastboot create-logical-partition my_manifest_a 1
fastboot create-logical-partition my_manifest_b 1
fastboot delete-logical-partition my_product_a
fastboot delete-logical-partition my_product_b
fastboot delete-logical-partition my_product_a-cow
fastboot delete-logical-partition my_product_b-cow
fastboot create-logical-partition my_product_a 1
fastboot create-logical-partition my_product_b 1
fastboot delete-logical-partition my_region_a
fastboot delete-logical-partition my_region_b
fastboot delete-logical-partition my_region_a-cow
fastboot delete-logical-partition my_region_b-cow
fastboot create-logical-partition my_region_a 1
fastboot create-logical-partition my_region_b 1
fastboot delete-logical-partition my_stock_a
fastboot delete-logical-partition my_stock_b
fastboot delete-logical-partition my_stock_a-cow
fastboot delete-logical-partition my_stock_b-cow
fastboot create-logical-partition my_stock_a 1
fastboot create-logical-partition my_stock_b 1
fastboot delete-logical-partition odm_a
fastboot delete-logical-partition odm_b
fastboot delete-logical-partition odm_a-cow
fastboot delete-logical-partition odm_b-cow
fastboot create-logical-partition odm_a 1
fastboot create-logical-partition odm_b 1
fastboot delete-logical-partition product_a
fastboot delete-logical-partition product_b
fastboot delete-logical-partition product_a-cow
fastboot delete-logical-partition product_b-cow
fastboot create-logical-partition product_a 1
fastboot create-logical-partition product_b 1
fastboot delete-logical-partition system_a
fastboot delete-logical-partition system_b
fastboot delete-logical-partition system_a-cow
fastboot delete-logical-partition system_b-cow
fastboot create-logical-partition system_a 1
fastboot create-logical-partition system_b 1
fastboot delete-logical-partition system_dlkm_a
fastboot delete-logical-partition system_dlkm_b
fastboot delete-logical-partition system_dlkm_a-cow
fastboot delete-logical-partition system_dlkm_b-cow
fastboot create-logical-partition system_dlkm_a 1
fastboot create-logical-partition system_dlkm_b 1
fastboot delete-logical-partition system_ext_a
fastboot delete-logical-partition system_ext_b
fastboot delete-logical-partition system_ext_a-cow
fastboot delete-logical-partition system_ext_b-cow
fastboot create-logical-partition system_ext_a 1
fastboot create-logical-partition system_ext_b 1
fastboot delete-logical-partition vendor_a
fastboot delete-logical-partition vendor_b
fastboot delete-logical-partition vendor_a-cow
fastboot delete-logical-partition vendor_b-cow
fastboot create-logical-partition vendor_a 1
fastboot create-logical-partition vendor_b 1
fastboot delete-logical-partition vendor_dlkm_a
fastboot delete-logical-partition vendor_dlkm_b
fastboot delete-logical-partition vendor_dlkm_a-cow
fastboot delete-logical-partition vendor_dlkm_b-cow
fastboot create-logical-partition vendor_dlkm_a 1
fastboot create-logical-partition vendor_dlkm_b 1
fastboot delete-logical-partition my_company_a
fastboot delete-logical-partition my_company_b
fastboot delete-logical-partition my_company_a-cow
fastboot delete-logical-partition my_company_b-cow
fastboot create-logical-partition my_company_a 1
fastboot create-logical-partition my_company_b 1
fastboot delete-logical-partition my_preload_a
fastboot delete-logical-partition my_preload_b
fastboot delete-logical-partition my_preload_a-cow
fastboot delete-logical-partition my_preload_b-cow
fastboot create-logical-partition my_preload_a 1
fastboot create-logical-partition my_preload_b 1

echo.
echo Flashing partitions
fastboot flash my_preload .\images\my_preload.img
fastboot flash my_company .\images\my_company.img
fastboot flash vendor_dlkm .\images\vendor_dlkm.img
fastboot flash vendor .\images\vendor.img
fastboot flash system_ext .\images\system_ext.img
fastboot flash system_dlkm .\images\system_dlkm.img
fastboot flash system .\images\system.img
fastboot flash product .\images\product.img
fastboot flash odm .\images\odm.img
fastboot flash my_stock .\images\my_stock.img
fastboot flash my_region .\images\my_region.img
fastboot flash my_product .\images\my_product.img
fastboot flash my_manifest .\images\my_manifest.img
fastboot flash my_heytap .\images\my_heytap.img
fastboot flash my_carrier .\images\my_carrier.img
fastboot flash my_bigball .\images\my_bigball.img
fastboot flash my_engineering .\images\my_engineering.img

echo.
echo Flashing complete, If no errors occured, you can format data and reboot to system.
echo otherwise, reboot to bootloader and reflash.
echo.
pause

:ext
exit /b
