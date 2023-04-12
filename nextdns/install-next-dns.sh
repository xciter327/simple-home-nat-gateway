#/bin/bash
# NextDNS Token
NEXTDNS_TOKEN='XXXXXXXXXXX'
# Add repo
curl -Ls https://repo.nextdns.io/nextdns.repo -o /etc/yum.repos.d/nextdns.repo
# Install NextDNS
yum install -y nextdns
# Setup NextDNS binary in router mode
nextdns install \
  --config "$NEXTDNS_TOKEN" \
  -report-client-info \
  -listen :9393

