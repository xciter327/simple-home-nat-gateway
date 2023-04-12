#/bin/bash
LAN_INTERFACE='enp3s0'
WAN_INTERFACE='enp2s0'
LAN_NETWORK='192.168.1.0/24'

echo "WAN_INTERFACE: $WAN_INTERFACE"
echo "LAN_INTERFACE: $LAN_INTERFACE"
echo "LAN_NETWORK: $LAN_NETWORK"

# Let's start be clearing everything
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
 
# Flush All Iptables Chains/Firewall rules #
iptables -F
 
# Delete all Iptables Chains #
iptables -X
 
# Flush all counters too #
iptables -Z 
# Flush and delete all nat and  mangle #
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -t raw -F
iptables -t raw -X

# Setup chains for allowing incomming traffic, one for each
iptables -N TCP
iptables -N UDP

# Also create chains to facilitate filtering later
iptables -N fw-interfaces
iptables -N fw-open

# Output is always allowed
iptables -P OUTPUT ACCEPT

# FORWARD CHAIN
# Allow all established connections
iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# Make all other forwarded traffic jump to the forwarding chains
iptables -A FORWARD -j fw-interfaces 
iptables -A FORWARD -j fw-open

# Reject and drop the rest
iptables -A FORWARD -j REJECT --reject-with icmp-host-unreachable
iptables -P FORWARD DROP

# NAT SETUP
# We define our trusted interface
iptables -A fw-interfaces -i "$LAN_INTERFACE" -j ACCEPT
# We ask outgoing traffic from our trusted network to be NAT'd via the outgoing interface
iptables -t nat -A POSTROUTING -s "$LAN_NETWORK" -o "$WAN_INTERFACE" -j MASQUERADE

# INPUT CHAIN
# Allow loopback
iptables -A INPUT -i lo -j ACCEPT

# Allow already established connections
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# Drop invalid traffic
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP

# Allow incomming ping
iptables -A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT

# Attach TCP/UDP chains to incomming traffic. Only new TCP connections are allowed.
iptables -A INPUT -p udp -m conntrack --ctstate NEW -j UDP
iptables -A INPUT -p tcp --syn -m conntrack --ctstate NEW -j TCP

# It's good practice to reject, rather than outright drop silently
iptables -A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
iptables -A INPUT -p tcp -j REJECT --reject-with tcp-reset
iptables -A INPUT -j REJECT --reject-with icmp-proto-unreachable

# Now actually need to allow some traffic
# SSH
iptables -A TCP -i "$LAN_INTERFACE" -p tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT
# DNS, both TCP and UDP since bigger DNS response are replied via TCP
iptables -A TCP -i "$LAN_INTERFACE" -p tcp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
iptables -A UDP -i "$LAN_INTERFACE" -p udp --dport 53 -j ACCEPT

# INPUT is denied by default
iptables -P INPUT DROP
