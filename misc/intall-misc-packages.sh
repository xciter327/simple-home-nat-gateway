#!/bin/bash
# We need:
# dnf-plugin-core for DockerCE
# jq for configuration file parsing
# docker-compose for Docker stuff
dnf install -y \
	dnf-plugins-core \
        docker-compose \
	jq

