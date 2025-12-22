#!/bin/bash

ip -o link show | awk '$2 != "lo:" && $17 ~ /^([0-9a-f]{2}:){5}[0-9a-f]{2}$/ {sub(":", "", $2); print $2}'
# excluded loopback interface and any interface with no MAC address, and prints only the name of remaining
# interfaces that have MAC addresses
