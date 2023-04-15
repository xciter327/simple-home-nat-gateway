#!/bin/bash
# We need:
# dnf-plugin-core for DockerCE
# jq for configuration file parsing
dnf install -y \
	dnf-plugins-core \
	jq

