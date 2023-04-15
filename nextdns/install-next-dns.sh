#/bin/bash
set e
# path to config file. One level up by default
CONFIG_FILE="$PWD../config.json"

# NextDNS Token
NEXTDNS_TOKEN="jq -r nextdns-token $CONFIG_FILE"

# Add repo
curl -Ls https://repo.nextdns.io/nextdns.repo -o /etc/yum.repos.d/nextdns.repo

# Install NextDNS
yum install -y nextdns

# Setup NextDNS binary in router mode
nextdns install \
  --config "$NEXTDNS_TOKEN" \
  -report-client-info \
  -listen :9393

