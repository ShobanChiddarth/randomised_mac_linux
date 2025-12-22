#!/bin/bash

for interface in $(./get_interfaces.sh); do
    ip link set "$interface" down
    macchanger -r "$interface"
    ip link set "$interface" up
done
