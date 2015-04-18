#!/bin/bash
# Remove the authorized keys so that the next boot will install the correct one
rm -vf $HOME/.ssh/authorized_keys
sudo rm -vf /root/.ssh/authorized_keys
