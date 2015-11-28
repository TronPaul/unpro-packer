#!/bin/bash
# Bootstrap masterless salt with the correct version

sudo pip install -U 'tornado >= 4.0'

sudo mkdir /var/log/salt
sudo mkdir /var/log/salt
sudo mkdir /var/cache/salt
sudo mkdir /var/run/salt

curl -L https://raw.githubusercontent.com/saltstack/salt-bootstrap/stable/bootstrap-salt.sh -O bootstrap-salt.sh
sudo sh bootstrap-salt.sh -P -X git v2015.8

sudo sed -i "s/^#master: salt$/master: salt-master.aws.teamunpro/g" /etc/salt/minion
