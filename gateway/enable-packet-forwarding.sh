#/bin/bash
# Enable packet forwardiong
sysctl net.ipv4.ip_forward=1
# Make it persistent
echo 'net.ipv4.ip_forward=1' > /etc/sysctl.d/30-ipforward.conf
