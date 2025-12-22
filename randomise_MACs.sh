#!/bin/bash

interfaces=$(ip -o link show | awk '$2 != "lo:" && $0 ~ /([0-9a-f]{2}:){5}[0-9a-f]{2}/ {sub(":", "", $2); print $2}')
# lists all valid network interfaces that have a MAC address excluding loopback interface

for interface in $interfaces; do
    ip link set "$interface" down
    macchanger -r "$interface"
    ip link set "$interface" up
done
