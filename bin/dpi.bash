#!/bin/bash

# Change the DPI from standard 96 to 192, and back.
# Usage:
#   dpi.bash [4k|2k]

RES=${1}

if [[ "${RES}" == "4k" ]]; then
  sed -i "s/rofi.dpi: 96/rofi.dpi: 192/" ~/.config/regolith/Xresources
  sed -i "s/Xft.dpi: 96/Xft.dpi: 192/" ~/.config/regolith/Xresources
  sed -i "s/Xcursor.size: 32/Xcursor.size: 64/" ~/.config/regolith/Xresources
elif [[ "${RES}" == "2k" ]]; then
  sed -i "s/rofi.dpi: 192/rofi.dpi: 96/" ~/.config/regolith/Xresources
  sed -i "s/Xft.dpi: 192/Xft.dpi: 96/" ~/.config/regolith/Xresources
  sed -i "s/Xcursor.size: 64/Xcursor.size: 32/" ~/.config/regolith/Xresources
else 
  echo "Usage: ./dpi.bash [4k|2k]"
  exit 2
fi

cat ~/.config/regolith/Xresources
regolith-look refresh
