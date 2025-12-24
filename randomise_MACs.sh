#!/bin/bash

# lists all folders (network interfaces) inside /sys/class/net
# that have a subfolder called 'device' (has a real Network Interface Card)
interfaces=$(basename -a $(dirname /sys/class/net/*/device))
# all network interfaces are in /sys/class/net
# only real network interfaces have a subfolder called `device`
# dirname X: lists the absolute path of one directory upward from X
# basename X: lists the base name of last value after / from absolute path X
# basename -a X*: gives basename of each absolute path in X*

for interface in $interfaces; do
    ip link set "$interface" down
    macchanger -r "$interface"
    ip link set "$interface" up
done
