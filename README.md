# Simple home gateways setup with NAT, DHCP, DNS, NextDNS and some monitoring

Loosely based on the Archlinux pages for the relevant services and offical tool documentation

# TODO
- Source shared environment variables from a single source of truth
- Look into managing the power envelope of the CPU [pstate-frequency](https://github.com/pyamsoft/pstate-frequency) or ThermalD
- Internal DNS zones
- Include Prometheus/Grafana stack
- Blackbox monitor for ad-hoc endpoints/services
- Include port-forwarding setup
- Wireguard based user VPN
- CI where possible for relevant services via Gitlab Actions
- CD via internal Gitlab instance
- Look into traffic marking via iptables and ipset
- Look into scapring iptables metrics via Prometheus
- Implement fair egress queuing via [CAKE](https://wiki.gentoo.org/wiki/User:0xdc/Drafts/Cake)
