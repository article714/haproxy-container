#!/bin/bash

#set -x

apt-get update
apt-get instal -yq curl

# Generate French locales
localedef -i fr_FR -c -f UTF-8 -A /usr/share/locale/locale.alias fr_FR.UTF-8

export LANG=en_US.utf8

# Install basic needed packages
LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -qy --no-install-recommends wget gnupg ca-certificates runit rsyslog logrotate

# Install HaProxy from pre-built packages
curl https://haproxy.debian.net/bernat.debian.org.gpg | apt-key add -
echo deb http://haproxy.debian.net buster-backports-2.2 main | tee /etc/apt/sources.list.d/haproxy.list

apt-get update
apt-get upgrade -yq

apt-get install haproxy=2.2.\*

#--
# Cleaning

apt-get -yq clean
apt-get -yq autoremove
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/ci
rm -f tmp/*_dependencies.txt
