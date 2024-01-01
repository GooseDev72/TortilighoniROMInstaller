@echo off
echo -----------------------------------
echo Tortilighoni ROM Installer v1.0-AOD
echo ---------A-only dynamic------------
echo Copying and unpacking ROM
copy %1 .\tmp\package.zip
echo Begin unpack process.
echo Unpacking ROM
7za.exe e tmp\package.zip tmp\
echo Unpacking system.new.dat.br
brotli.exe --decompress tmp\system.new.dat.br
echo Unpacking system.new.dat
python3 sdat2img.py tmp\system.transfer.list tmp\system.new.dat tmp\system.img
echo Unpacking product.new.dat.br
brotli.exe --decompress tmp\product.new.dat.br
echo Unpacking product.new.dat 
python3 sdat2img.py tmp\product.transfer.list tmp\product.new.dat tmp\product.img
echo Unpacking vendor.new.dat.br
brotli.exe --decompress tmp\vendor.new.dat.br
echo Unpacking vendor.new.dat
python3 sdat2img.py tmp\vendor.transfer.list tmp\vendor.new.dat tmp\vendor.img
echo Unpacking system_ext.new.dat.br
brotli.exe --decompress tmp\system_ext.new.dat.br
echo Unpacking system_ext.new.dat
python3 sdat2img.py tmp\system_ext.transfer.list tmp\system_ext.new.dat tmp\system_ext.img
echo Unpacking odm.new.dat.br
brotli.exe --decompress tmp\odm.new.dat.br
echo Unpacking odm.new.dat
python3 sdat2img.py tmp\odm.transfer.list tmp\odm.new.dat tmp\odm.img
echo Got all images!
echo Waiting for ADB connection
adb wait-for-device
echo Got connection! Rebooting to fastbootd
echo If you are getting unbootable components error, flash TWRP!
adb reboot fastboot
echo Flashing ROM
fastboot flash boot tmp\boot.img
fastboot flash dtbo tmp\dtbo.img
fastboot flash odm tmp\odm.img
fastboot flash --disable-verification --disable-verity vbmeta tmp\vbmeta.img
fastboot flash --disable-verification --disable-verity vbmeta_system tmp\vbmeta_system.img
fastboot flash system tmp\system.img
fastboot flash system_ext tmp\system_ext.img
fastboot flash vendor tmp\vendor.img
fastboot flash product tmp\product.img
echo ROM installation completed.
echo Wiping your data!
echo Don't worry about errors.
fastboot -w reboot
echo ROM installed. Temp files will be
echo removed after clicking any button
echo and phone is rebooted! Thanks for
echo using my utility with my idea!!!!
pause
rd \s \q tmp
exit
