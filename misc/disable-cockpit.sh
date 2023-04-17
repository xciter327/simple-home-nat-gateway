#!/bin/bash
# We're not going to be using cockpit here and we need the port for Prometheus, so let's get rid of it
systemctl stop cockpit && systemctl disable cockpit && yum remove -y cockpit

