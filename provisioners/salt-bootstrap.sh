#!/bin/bash
# Bootstrap masterless salt with the correct version

curl -L https://bootstrap.saltstack.com -o install_salt.sh
sudo sh install_salt.sh -X -g https://github.com/TronPaul/salt.git git v2014.7.2 

sudo sed -i "s/^#file_client: remote$/file_client: local/g" /etc/salt/minion
