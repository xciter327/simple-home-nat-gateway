#/bin/bash
set e
# path to config file. One level up by default
CONFIG_FILE="$PWD../config.json"

LAN_NETWORK="jq -r .lan-network $CONFIG_FILE"
LAN_DOMAIN="jq -r .lan-domain $CONFIG_FILE"
DNS_RESOLVER="jq -r .dns-resolver $CONFIG_FILE"

# Install BIND
yum install -y dhcpd

# Seed configuration
cat > /etc/dhcpd.conf << EOF
# dhcpd.conf
#
# Sample configuration file for ISC dhcpd
#

# option definitions common to all supported networks...
option domain-name "$LAN_DOMAIN";
option domain-name-servers "$DNS_RESOLVER";

default-lease-time 600;
max-lease-time 7200;

# Use this to enble / disable dynamic dns updates globally.
#ddns-update-style none;

# If this DHCP server is the official DHCP server for the local
# network, the authoritative directive should be uncommented.
#authoritative;

# Use this to send dhcp log messages to a different log file (you also
# have to hack syslog.conf to complete the redirection).
log-facility local7;

# No service will be given on this subnet, but declaring it helps the
# DHCP server to understand the network topology.

# A slightly different configuration for an internal subnet.
subnet 192.168.1.0 netmask 255.255.255.0 {
  range 192.168.1.100 192.168.1.200;
  option routers 192.168.1.1;
  option domain-name "network.home";
  option broadcast-address 192.168.1.255;
}
EOF
