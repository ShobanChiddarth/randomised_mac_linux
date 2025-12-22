#!/bin/bash

# lists all valid network interfaces that have a MAC address excluding loopback interface
interfaces=$(ip -o link show | awk '$2 != "lo:" && $0 ~ /([0-9a-f]{2}:){5}[0-9a-f]{2}/ {sub(":", "", $2); print $2}')
### 1. `ip -o link show`
# * `ip link show` lists all network interfaces and their details.
# * `-o` (or `--oneline`) produces **one interface per line**, which is easier to parse.
#
# Sample output:
# 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000 link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
# 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000 link/ether 12:34:56:78:9a:bc brd ff:ff:ff:ff:ff:ff
# 3: wlan0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether de:ad:be:ef:00:01 brd ff:ff:ff:ff:ff:ff
#
### 2. `awk '$2 != "lo:" && $0 ~ /([0-9a-f]{2}:){5}[0-9a-f]{2}/ {sub(":", "", $2); print $2}'`
# * `$2 != "lo:"` → skip the loopback interface (`lo`). `$2` is the second field, which contains the interface name with a colon (e.g., `eth0:`).
# * `$0 ~ /([0-9a-f]{2}:){5}[0-9a-f]{2}/` → only process lines that contain a **MAC address** (6 pairs of hex digits separated by `:`).
# * `sub(":", "", $2)` → remove the trailing colon from the interface name (e.g., `eth0:` → `eth0`).
# * `print $2` → output the cleaned interface name.

for interface in $interfaces; do
    ip link set "$interface" down
    macchanger -r "$interface"
    ip link set "$interface" up
done
