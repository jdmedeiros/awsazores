#!/usr/bin/env bash

HOSTNAME=luxsrv
SCRIPT_LOG_DETAIL=/var/log/server-config-detail.log

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>"$SCRIPT_LOG_DETAIL" 2>&1

# Debconf needs to be told to accept that user interaction is not desired
export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true

apt-get -o DPkg::Options::=--force-confdef update
apt-get -o DPkg::Options::=--force-confdef upgrade
apt-get -o DPkg::Options::=--force-confdef dist-upgrade
apt-get -o DPkg::Options::=--force-confdef install -y apache2 php libapache2-mod-php

hostnamectl set-hostname "$HOSTNAME"
