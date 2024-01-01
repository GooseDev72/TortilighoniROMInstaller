@echo off
echo -----------------------------------
echo Tortilighoni ROM Installer v1.0-AOD
echo --------A-only non-dynamic---------
echo Copying and unpacking ROM
copy %1 .\tmp\package.zip
echo Begin unpack process.
echo Unpacking ROM
7za.exe e tmp\package.zip tmp\
echo Unpacking system.new.dat.br
brotli.exe --decompress tmp\system.new.dat.br
echo Unpacking system.new.dat
python3 sdat2img.py tmp\system.transfer.list tmp\system.new.dat tmp\system.img
echo Got all images!
echo Waiting for ADB connection
adb wait-for-device
echo Got connection! Rebooting to bootloader
echo If your phone is ala-Samsung without bootloader, will not work!
adb reboot bootloader
echo Flashing ROM
fastboot flash boot tmp\boot.img
fastboot flash --disable-verification --disable-verity vbmeta tmp\vbmeta.img
fastboot flash --disable-verification --disable-verity vbmeta_system tmp\vbmeta_system.img
fastboot flash system tmp\system.img
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
