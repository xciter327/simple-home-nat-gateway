#!/bin/bash
set e
# path to config file. One level up by default
CONFIG_FILE="$PWD../config.json"

dnf install -y chrony

# Don't allowdocker to inject iptables rules
grep -qxF "allow $LAN_NETWORK" /etc/chrony.conf || echo "allow $LAN_NETWORK" >> /etc/chrony.conf

systemctl restart chronyd


