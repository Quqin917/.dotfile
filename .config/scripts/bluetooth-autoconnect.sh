#!/bin/bash

# Wait until bluetooth could be access
while ! bluetoothctl show &>/dev/null; do
  sleep 1
done

bluetoothctl power on

top_devices=$(bluetoothctl devices | awk '{print $2}' | head -n 1)

bluetoothctl connect $top_devices
