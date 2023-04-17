# Simple home gateways setup with NAT, DHCP, DNS, NextDNS and some monitoring

Loosely based on the Archlinux pages for the relevant services and offical tool documentation

# TODO
- Look into managing the power envelope of the CPU [pstate-frequency](https://github.com/pyamsoft/pstate-frequency) or ThermalD
- Internal DNS zones
- Include port-forwarding setup
- Wireguard based user VPN
- Implement fair egress queuing via [CAKE](https://wiki.gentoo.org/wiki/User:0xdc/Drafts/Cake)

# Nice-to-Have
- CI where possible for relevant services via Gitlab Actions
- CD via internal Gitlab instance
- Look into traffic marking via iptables and ipset
- Look into scapring iptables metrics via Prometheus
