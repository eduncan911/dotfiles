#!/bin/bash

# set DPTF policy to "adaptive performance"
echo "63BE270F-1C11-48FD-A6F7-3AF253FF3E2D" > /sys/devices/platform/INT3400:00/uuids/current_uuid

# enable INT3400 thermal zone
for zone in /sys/class/thermal/thermal_zone*; do
	if [ "$(cat $zone/type)" == "INT3400 Thermal" ]; then
		echo enabled > $zone/mode
	fi
done

# set TCC offset to 5 degrees (Tmax = 95C)
echo 5 > /sys/devices/pci0000:00/0000:00:04.0/tcc_offset_degree_celsius

