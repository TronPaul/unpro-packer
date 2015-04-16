#!/bin/bash
# Install unpro-salt config

echo "Applying base state"
DIR=`mktemp -d`
sudo wget -q -O $DIR/unpro-salt.tar.gz https://github.com/TronPaul/unpro-salt/archive/master.tar.gz
tar -xzf $DIR/unpro-salt.tar.gz -C $DIR
sudo cp -r $DIR/unpro-salt-master/state /srv/salt
sudo cp -r $DIR/unpro-salt-master/pillar /srv/pillar
sudo salt-call state.highstate

echo "Cleaning up"
rm -rf $DIR
# clear minion id and grains
sudo rm -f /etc/salt/minion_id
sudo rm -f /etc/salt/grains
