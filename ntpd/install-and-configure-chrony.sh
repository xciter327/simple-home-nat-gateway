#!/bin/bash
dnf install -y chrony

# Don't allowdocker to inject iptables rules
grep -qxF 'allow 192.168.1.0/24' /etc/chrony.conf || echo 'allow 192.168.1.0/24' >> /etc/chrony.conf

systemctl restart chronyd


