#/bin/bash
# By default systemd-resolved listens on 53, which we need for our DNS
grep -qxF 'DNSStubListener=no' /etc/resolv.conf || echo 'DNSStubListener=no' >> /etc/resolv.conf
# restart the service
systemctl restart systemd-resolved
