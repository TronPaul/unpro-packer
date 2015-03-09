#!/bin/bash
# Install unpro-salt config

DIR=`mktemp -d`
sudo wget -q -O $DIR/unpro-salt.tar.gz https://github.com/TronPaul/unpro-salt/archive/master.tar.gz
tar -xzf $DIR/unpro-salt.tar.gz -C $DIR
cp -r $DIR/unpro-salt-master/state /srv/salt
cp -r $DIR/unpro-salt-master/pillar /srv/pillar
salt-call state.highstate
rm -rf $DIR
