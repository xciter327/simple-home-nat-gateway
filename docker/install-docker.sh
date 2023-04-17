#/bin/bash

# Ofcourse it needs plugins...
dnf install -y dnf-plugins-core

# Install repository
dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

# Actually install docker
dnf install -y docker-ce docker-ce-cli containerd.io

# Don't allowdocker to inject iptables rules
grep -qxF '{ "iptables": false }' /etc/docker/daemon.json || echo '{ "iptables": false }' >> /etc/docker/daemon.json

# Start Docker
systemctl start docker

# Enable docker service at start
systemctl enable docker

# Allow user to run docker commands without sudo
grep -qxF "$SUDO_USER        ALL=(ALL)       NOPASSWD: /usr/bin/docker" /etc/sudoers.d/docker || echo "$SUDO_USER        ALL=(ALL)       NOPASSWD: /usr/bin/docker" >> /etc/sudoers.d/docker

