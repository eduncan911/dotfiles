#!/bin/bash 

# TODO: if %1 is blank, exit...

VMNAME="RocketSim"
# fake-out machine as Mac Pro
VBoxManage modifyvm "$VMNAME" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
VBoxManage setextradata "$VMNAME" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac11,3"
VBoxManage setextradata "$VMNAME" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
VBoxManage setextradata "$VMNAME" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple"
VBoxManage setextradata "$VMNAME" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
VBoxManage setextradata "$VMNAME" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1
# tweak some settings
VBoxManage modifyvm "$VMNAME" --vram 256

