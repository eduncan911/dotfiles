#!/bin/bash

cryptsetup luksOpen /dev/nvme0n1p2 cryptdata2
mount -o ro /dev/data2/root /media/data2-root/
