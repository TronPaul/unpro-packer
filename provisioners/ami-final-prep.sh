#!/bin/bash
# Remove the authorized keys so that the next boot will install the correct one
sudo rm -vf /root/.ssh/authorized_keys
