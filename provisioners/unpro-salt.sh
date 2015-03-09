#!/bin/bash
# Install unpro-salt config

DIR=`mktemp -d`
sudo wget -q -O $DIR/unpro-salt.tar.gz https://github.com/TronPaul/unpro-salt/archive/master.tar.gz
tar -xzf $DIR/unpro-salt.tar.gz -C $DIR
sudo cp -r $DIR/unpro-salt-master/state /srv/salt
sudo cp -r $DIR/unpro-salt-master/pillar /srv/pillar
sudo salt-call state.highstate
rm -rf $DIR
