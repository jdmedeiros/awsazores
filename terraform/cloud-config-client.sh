#!/usr/bin/env bash

USER=maria              # user to add or configure for - if adding an existing user, change the password manually
PASSWORD=Passw0rd       # password in case we add the user
DISPLAYMANAGER=lightdm  # lightdm or gdm3
HOSTNAME=ubuntudsk      # hostname
SCRIPT_LOG_DETAIL=/var/log/client-config-detail.log

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>"$SCRIPT_LOG_DETAIL" 2>&1

# Debconf needs to be told to accept that user interaction is not desired
export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true

apt-get -o DPkg::Options::=--force-confdef update
apt-get -o DPkg::Options::=--force-confdef -y upgrade
apt-get -o DPkg::Options::=--force-confdef -y dist-upgrade
apt-get -o DPkg::Options::=--force-confdef install -y xfce4 xfce4-goodies

echo "/usr/sbin/$DISPLAYMANAGER" > /etc/X11/default-display-manager

sudo apt-get install -y xrdp chromium-browser filezilla
sudo adduser xrdp ssl-cert

if ! (id "$USER" &>/dev/null); then
  sudo useradd -m -p "$(openssl passwd -1 $PASSWORD)" $USER
fi
runuser -l "$USER" -c 'echo xfce4-session > ~/.xsession'

hostnamectl set-hostname "$HOSTNAME"
