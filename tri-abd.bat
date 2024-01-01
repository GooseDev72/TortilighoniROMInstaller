@echo off
echo --------------------------
echo Tortilighoni ROM Installer
echo ------- A\B dynamic ------
echo Copying and unpacking ROM
copy %1 .\tmp\package.zip
echo Begin unpack process.
7za.exe e tmp\package.zip tmp\
echo Dumping payload
move tmp\payload.bin payload_input\
payload_dumper.exe
move payload_output\system.img tmp\system.img
move payload_output\vendor.img tmp\vendor.img
move payload_output\boot.img tmp\boot.img
echo Waiting for ADB connection
adb wait-for-device
echo Got connection.
echo Begin flashing process!
echo Rebooting to fastbootd
echo If you are getting unbootable components error, flash TWRP!
adb reboot fastboot
echo Flashing ROM
fastboot flash boot tmp\boot.img
fastboot flash system tmp\system.img
fastboot flash vendor tmp\vendor.img
echo Wiping userdata and rebooting
fastboot -w reboot
echo Done! Click any button to exit and clean temp files.
pause
rd \s \q tmp
rd \s \q payload_input
rd \s \q payload_output
exit
