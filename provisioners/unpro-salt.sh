#!/bin/bash
# Install unpro-salt config

sudo touch /etc/ssh/ssh_known_hosts
wget -O bootstrap-unpro.sh https://raw.githubusercontent.com/TronPaul/unpro-salt/master/bootstrap-unpro-salt
sudo bash ./bootstrap-unpro.sh
