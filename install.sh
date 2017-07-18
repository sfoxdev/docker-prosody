#!/bin/bash

set -euxo pipefail

apt-get update
apt-get install -y apt-utils gnupg gnupg1 gnupg2
echo deb http://packages.prosody.im/debian stretch main >>/etc/apt/sources.list
apt-key add /root/prosody-debian-packages.key
apt-get update
apt-get install -y prosody
#apt-get install -y prosody-0.10
#apt-get install -y prosody-trunk
apt-get install -y --no-install-recommends mc ca-certificates curl lua-sec lua-event lua-ldap lua-dbi-mysql lua-dbi-postgresql lua-dbi-sqlite3 lua-ldap lua-zlib mercurial

mkdir -vp /var/run/prosody
chown -vR prosody:prosody /var/run/prosody
ln -sv /dev/stdout /var/log/prosody/prosody.log
ln -sv /dev/stderr /var/log/prosody/prosody.err
chown -vR prosody:prosody /var/log/prosody

# install additional modules
hg clone https://hg.prosody.im/prosody-modules/ /usr/lib/prosody/additional_modules

mv /etc/prosody/prosody.cfg.lua /etc/prosody/prosody.cfg.lua.rpm_orig

# clean cache to keep the image small
apt-get purge --auto-remove -y curl
apt-get clean autoclean
apt-get autoremove --yes
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
